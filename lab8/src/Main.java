

import java.io.*;

import java.sql.*;

import oracle.sql.BLOB;

import oracle.sql.CLOB;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

/****
 CREATE TABLE java_objects (object_id NUMBER, object_name varchar(128), object_value BLOB DEFAULT empty_blob(), primary key (object_id));
 SQL> desc java_objects;
 Name                                      Null?    Type
 ----------------------------------------- -------- ----------------------------
 OBJECT_ID                                 NOT NULL NUMBER
 OBJECT_NAME                                        VARCHAR2(128)
 OBJECT_VALUE                                       BLOB

 SQL> select SEQUENCE_NAME, MIN_VALUE, MAX_VALUE, INCREMENT_BY, LAST_NUMBER from  user_sequences;

 SEQUENCE_NAME                   MIN_VALUE  MAX_VALUE INCREMENT_BY LAST_NUMBER
 ------------------------------ ---------- ---------- ------------ -----------
 ID_SEQ                                  1 1.0000E+27            1          21
 JAVA_OBJECT_SEQUENCE                    1 1.0000E+27            1           1

 */
public class Main {
    public static void main(String[] args) throws Exception {
        String WRITE_OBJECT_SQL = "BEGIN "
                + "  INSERT INTO java_objects(object_id, object_name, object_value) "
                + "  VALUES (?, ?, empty_blob()) " + "  RETURN object_value INTO ?; " + "END;";
        String READ_OBJECT_SQL = "SELECT object_value FROM java_objects WHERE object_id = ?";

        Connection conn = getOracleConnection();
        conn.setAutoCommit(false);
        List<Object> list = new ArrayList<Object>();
        list.add("This is a short string.");
        list.add(new Integer(1234));
        list.add(new java.util.Date());

        // write object to Oracle
        long id = 0001;
        String className = list.getClass().getName();
        CallableStatement cstmt = conn.prepareCall(WRITE_OBJECT_SQL);

        cstmt.setLong(1, id);
        cstmt.setString(2, className);

        cstmt.registerOutParameter(3, java.sql.Types.BLOB);

        cstmt.executeUpdate();
        BLOB blob = (BLOB) cstmt.getBlob(3);
        OutputStream os = blob.getBinaryOutputStream();
        ObjectOutputStream oop = new ObjectOutputStream(os);
        oop.writeObject(list);
        oop.flush();
        oop.close();
        os.close();

        // Read object from oracle
        PreparedStatement pstmt = conn.prepareStatement(READ_OBJECT_SQL);
        pstmt.setLong(1, id);
        ResultSet rs = pstmt.executeQuery();
        rs.next();
        InputStream is = rs.getBlob(1).getBinaryStream();
        ObjectInputStream oip = new ObjectInputStream(is);
        Object object = oip.readObject();
        className = object.getClass().getName();
        oip.close();
        is.close();
        rs.close();
        pstmt.close();
        conn.commit();

        // de-serialize list a java object from a given objectID
        List listFromDatabase = (List) object;
        System.out.println("[After De-Serialization] list=" + listFromDatabase);
        conn.close();
    }

    private static Connection getHSQLConnection() throws Exception {
        Class.forName("org.hsqldb.jdbcDriver");
        System.out.println("Driver Loaded.");
        String url = "jdbc:hsqldb:data/tutorial";
        return DriverManager.getConnection(url, "sa", "");
    }

    public static Connection getMySqlConnection() throws Exception {
        String driver = "org.gjt.mm.mysql.Driver";
        String url = "jdbc:mysql://localhost/demo2s";
        String username = "oost";
        String password = "oost";

        Class.forName(driver);
        Connection conn = DriverManager.getConnection(url, username, password);
        return conn;
    }

    public static Connection getOracleConnection() throws Exception {
        String driver = "oracle.jdbc.driver.OracleDriver";
        String url = "jdbc:oracle:thin:@localhost:1521:databaseName";
        String username = "userName";
        String password = "password";

        Class.forName(driver); // load Oracle driver
        Connection conn = DriverManager.getConnection(url, username, password);
        return conn;
    }

}
