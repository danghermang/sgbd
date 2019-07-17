
import java.sql.*;
import java.util.Scanner;

public class OracleJDBCExample {
    public static String name="aaaa";
    public static String rasa="bbb";
    public String name2="";
    public String rasa2="";
    public static void main(String[] argv) {

        System.out.println("-------- Oracle JDBC Connection Testing ------");

        try {

            Class.forName("oracle.jdbc.driver.OracleDriver");

        } catch (ClassNotFoundException e) {

            System.out.println("Where is your Oracle JDBC Driver?");
            e.printStackTrace();
            return;

        }

        System.out.println("Oracle JDBC Driver Registered!");

        Connection connection = null;

        try {

            connection = DriverManager.getConnection(
                    "jdbc:oracle:thin:@localhost:1521:xe", "student", "STUDENT");

        } catch (SQLException e) {

            System.out.println("Connection Failed! Check output console");
            e.printStackTrace();
            return;

        }

        if (connection != null) {
            System.out.println("You made it, take control your database now!");
        } else {
            System.out.println("Failed to make connection!");
        }
        Interfata123(connection,"Student");
    }
    public static void serialise(Connection con, String dbName) throws SQLException {
        Statement stmt = null;
        String query;
        stmt = con.createStatement();
        query = "DROP TABLE if exists EXERCITIU5T";
        stmt.executeUpdate(query);
        query = "CREATE TABLE EXERCITIU5T(OBIECT doggo)";
        stmt.executeUpdate(query);
        query="INSERT INTO EXERCITIU5T(OBIECT) VALUES (OBIECTA:=doggo("+name+","+rasa+"))";
        stmt.executeUpdate(query);
    }
    public static void deserialise(Connection con, String dbName) throws SQLException {
        Statement stmt = null;
        stmt = con.createStatement();
        String query="select * from EXERCITIU5";
        try {
            stmt = con.createStatement();
            ResultSet rs = stmt.executeQuery(query);
            while (rs.next()) {
                String NAME = rs.getString("TREAT(VALUE(EXERCITIU5T AS EXERCITIU5)).NUME");
                String RASA = rs.getString("TREAT(VALUE(EXERCITIU5T AS EXERCITIU5)).RASA");
                System.out.println(NAME + "\t" + RASA);
            }
        } catch (SQLException e ) {
            e.printStackTrace();
        } finally {
            if (stmt != null) { stmt.close(); }
        }
    }

    public static void Interfata123(Connection con, String dbName){
        Scanner reader = new Scanner(System.in);
        int n=0;
        while(true){
            System.out.println("\nYour options are:\n\t1.Serialise." +
                    "\n\t2.Deserialise.");
            do {
                if(n<1 || n>2)
                    System.out.println("\nBetween 1 and 2 pls.");
                n = reader.nextInt();
            }while(n<1 || n>2);
            switch(n){
                case 1:
                    try{
                    serialise(con,dbName);
                    } catch (SQLException e ) {
                    e.printStackTrace();
                    }
                    break;
                case 2:
                    try{
                        deserialise(con,dbName);
                    } catch (SQLException e ) {
                        e.printStackTrace();
                    }
                    break;
            }
        }
    }
}