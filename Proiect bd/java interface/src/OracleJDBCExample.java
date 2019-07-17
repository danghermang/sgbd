
import java.sql.*;
import java.util.Scanner;

public class OracleJDBCExample {

    public static String center(String text, int len){
        String out = String.format("%"+len+"s%s%"+len+"s", "",text,"");
        float mid = (out.length()/2);
        float start = mid - (len/2);
        float end = start + len;
        return out.substring((int)start, (int)end);
    }
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
                    "jdbc:oracle:thin:@localhost:1521:xe", "proiect", "PROIECT");

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
        Interfata123(connection, "Proiect");
    }

    public static void viewUSERS(Connection con, String dbName)
            throws SQLException {
        int counter = 0;
        Statement stmt = null;
        String query = "select NUME, PRENUME, MAIL, ID " +
                "from " + dbName + ".USERS";
        try {
            stmt = con.createStatement();
            ResultSet rs = stmt.executeQuery(query);
            while (rs.next() && counter <= 100) {
                String USERSURNAME = rs.getString("NUME");
                String USERNAME = rs.getString("PRENUME");
                String MAIL = rs.getString("MAIL");
                int ID = rs.getInt("ID");
                System.out.println(center(USERSURNAME,40) + "|" + center(USERNAME,40) +
                        "|" + center(MAIL,40) + "|" + center(Integer.toString(ID),40));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            if (stmt != null) {
                stmt.close();
            }
        }
    }

    public static void viewCATEGORII(Connection con, String dbName)
            throws SQLException {
        int counter = 0;
        Statement stmt = null;
        String query = "select NUME, ID " +
                "from " + dbName + ".categorii";
        try {
            stmt = con.createStatement();
            ResultSet rs = stmt.executeQuery(query);
            while (rs.next() && counter <= 100) {
                String USERSURNAME = rs.getString("NUME");
                int ID = rs.getInt("ID");
                System.out.println(center(USERSURNAME,40) + "|" + center(Integer.toString(ID),40));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            if (stmt != null) {
                stmt.close();
            }
        }
    }

    public static void viewANGAJATI(Connection con, String dbName)
            throws SQLException {
        int counter = 0;
        Statement stmt = null;
        String query = "select NUME, PRENUME, MAIL, ID " +
                "from " + dbName + ".ANGAJAT";
        try {
            stmt = con.createStatement();
            ResultSet rs = stmt.executeQuery(query);
            while (rs.next() && counter <= 100) {
                String ANGSURNAME = rs.getString("NUME");
                String ANGNAME = rs.getString("PRENUME");
                String MAIL = rs.getString("MAIL");
                int ID = rs.getInt("ID");
                System.out.println(center(ANGSURNAME,40) + "|" + center(ANGNAME,40) +
                        "|" + center(MAIL,40) + "|" + center(Integer.toString(ID),40));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            if (stmt != null) {
                stmt.close();
            }
        }
    }

    public static void viewAngajati_magazin(Connection con, String dbName)
            throws SQLException {
        int counter = 0;
        PreparedStatement stmt = null;
        Scanner reader = new Scanner(System.in);
        int n = 0;
        System.out.println("Introduceti numele");
        String nume = reader.next();
        String query = "select NUME,PRENUME,MAIL,BONUS,ID_ANGAJAT,NUME_FUNCTIE,SALAR,NUME_MAGAZIN,LOCATIE_MAGAZIN " +
                "from " + dbName + ".ANGAJAT_COMPLET where lower(ANGAJAT_COMPLET.NUME_MAGAZIN) like LOWER( '%'||?||'%' )";
        try {
            stmt = con.prepareStatement(query);
            stmt.setString(1, nume);
            ResultSet rs = stmt.executeQuery();
            while (rs.next() && counter <= 100) {
                String lastname= rs.getString("NUME");
                String firstname= rs.getString("PRENUME");
                String mail= rs.getString("MAIL");
                int bonus = rs.getInt("BONUS");
                int ID = rs.getInt("ID_ANGAJAT");
                String nume_functie= rs.getString("NUME_FUNCTIE");
                int salar = rs.getInt("SALAR");
                String Nume_magazin = rs.getString("NUME_MAGAZIN");
                String adresa_magazin = rs.getString("LOCATIE_MAGAZIN");
                System.out.println(center(lastname,25) + "|" + center(firstname,25) + "|" + center(mail,25) + "|" + center(Integer.toString(ID),25)
                        + "|" + center(Integer.toString(bonus),25) + "|" + center(nume_functie,25)+ "|" + center(Integer.toString(salar),25)+
                        "|" + center(Nume_magazin,25)+ "|" + center(adresa_magazin,25));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            if (stmt != null) {
                stmt.close();

            }
        }
    }

    public static void viewComenzi(Connection con, String dbName)
            throws SQLException {
        int counter = 0;
        PreparedStatement stmt = null;
        Scanner reader = new Scanner(System.in);
        int n = 0;
            System.out.println("\nYour options are:\n\t\t1.Dupa id" +
                    "\n\t\t2.Dupa data." +
                    "\n\t\t3.Dupa id user." +
                    "\n\t\t4.Dupa id_produs.\n");
            do {
                if (n < 1 || n > 5)
                    System.out.println("\nBetween 1 and 4 pls.");
                n = reader.nextInt();
            } while (n < 1 || n > 4);
            if (n == 1) {
                System.out.println("Introduceti id-ul");
                int id = reader.nextInt();
                String query = "select DATA_COMENZII,ID_PRODUS,ID_ANGAJAT,ID,ADRESS,ID_USER " +
                        "from " + dbName + ".comenzi where comenzi.ID=?";
                try {
                    stmt=con.prepareStatement(query);
                    stmt.setInt(1,id);
                    ResultSet rs = stmt.executeQuery();
                    while (rs.next() && counter <= 100) {
                        Date DATA = rs.getDate("DATA_COMENZII");
                        int ID1 = rs.getInt("ID_PRODUS");
                        int ID2 = rs.getInt("ID_ANGAJAT");
                        int ID3 = rs.getInt("ID");
                        String ADRESA = rs.getString("ADRESS");
                        int ID4 = rs.getInt("ID_USER");
                        System.out.println(center(DATA.toString(),25) + "|" + center(Integer.toString(ID1),25) + "|" +
                                center(Integer.toString(ID2),25) + "|" + center(Integer.toString(ID3),25) + "|" +
                                center(ADRESA,25) + "|" + center(Integer.toString(ID4),25));
                    }
                } catch (SQLException e) {
                    e.printStackTrace();
                } finally {
                    if (stmt != null) {
                        stmt.close();

                    }
                }
            } else if (n == 2) {
                System.out.println("Introduceti data");
                String date = reader.next();
                String query = "select DATA_COMENZII,ID_PRODUS,ID_ANGAJAT,ID,ADRESS,ID_USER " +
                        "from " + dbName + ".comenzi where data_comenzii=TO_DATE(?,'dd-mm-yyyy')";
                try {
                    stmt=con.prepareStatement(query);
                    stmt.setString(1,date);
                    ResultSet rs = stmt.executeQuery();
                    while (rs.next() && counter <= 100) {
                        Date DATA = rs.getDate("DATA_COMENZII");
                        int ID1 = rs.getInt("ID_PRODUS");
                        int ID2 = rs.getInt("ID_ANGAJAT");
                        int ID3 = rs.getInt("ID");
                        String ADRESA = rs.getString("ADRESS");
                        int ID4 = rs.getInt("ID_USER");
                        System.out.println(center(DATA.toString(),25) + "|" + center(Integer.toString(ID1),25) + "|" +
                                center(Integer.toString(ID2),25) + "|" + center(Integer.toString(ID3),25) + "|" +
                                center(ADRESA,25) + "|" + center(Integer.toString(ID4),25));
                    }
                } catch (SQLException e) {
                    e.printStackTrace();
                } finally {
                    if (stmt != null) {
                        stmt.close();
                    }
                }
            } else if (n == 3) {
                System.out.println("Introduceti id-ul userului");
                int id = reader.nextInt();
                String query = "select DATA_COMENZII,ID_PRODUS,ID_ANGAJAT,ID,ADRESS,ID_USER " +
                        "from " + dbName + ".comenzi where ID_user=?";
                try {
                    stmt=con.prepareStatement(query);
                    stmt.setInt(1,id);
                    ResultSet rs = stmt.executeQuery();
                    while (rs.next() && counter <= 100) {
                        Date DATA = rs.getDate("DATA_COMENZII");
                        int ID1 = rs.getInt("ID_PRODUS");
                        int ID2 = rs.getInt("ID_ANGAJAT");
                        int ID3 = rs.getInt("ID");
                        String ADRESA = rs.getString("ADRESS");
                        int ID4 = rs.getInt("ID_USER");
                        System.out.println(center(DATA.toString(),25) + "|" + center(Integer.toString(ID1),25) + "|" +
                                center(Integer.toString(ID2),25) + "|" + center(Integer.toString(ID3),25) + "|" +
                                center(ADRESA,25) + "|" + center(Integer.toString(ID4),25));
                    }
                } catch (SQLException e) {
                    e.printStackTrace();
                } finally {
                    if (stmt != null) {
                        stmt.close();
                    }
                }
            }else if (n == 4) {
                System.out.println("Introduceti id-ul produs");
                int id = reader.nextInt();
                String query = "select DATA_COMENZII,ID_PRODUS,ID_ANGAJAT,ID,ADRESS,ID_USER " +
                        "from " + dbName + ".comenzi where ID_produs=?";
                try {
                    stmt=con.prepareStatement(query);
                    stmt.setInt(1,id);
                    ResultSet rs = stmt.executeQuery();
                    while (rs.next() && counter <= 100) {
                        Date DATA = rs.getDate("DATA_COMENZII");
                        int ID1 = rs.getInt("ID_PRODUS");
                        int ID2 = rs.getInt("ID_ANGAJAT");
                        int ID3 = rs.getInt("ID");
                        String ADRESA = rs.getString("ADRESS");
                        int ID4 = rs.getInt("ID_USER");
                        System.out.println(center(DATA.toString(),25) + "|" + center(Integer.toString(ID1),25) + "|" +
                                center(Integer.toString(ID2),25) + "|" + center(Integer.toString(ID3),25) + "|" +
                                center(ADRESA,25) + "|" + center(Integer.toString(ID4),25));
                    }
                } catch (SQLException e) {
                    e.printStackTrace();
                } finally {
                    if (stmt != null) {
                        stmt.close();
                    }
                }
            }
    }
    public static void exportDatabase(Connection con,String dbName)throws SQLException{
        int counter = 0;
        CallableStatement stmt = null;
        String query = "CALL "+dbName+".EXPORT_DB()";
        try {
            stmt = con.prepareCall(query);
            stmt.executeQuery();
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            if (stmt != null) {
                stmt.close();
            }
        }
    }
    public static void viewFUNCTII(Connection con, String dbName)
            throws SQLException {
        int counter = 0;
        Statement stmt = null;
        String query = "select NUME,ID,SALAR " +
                "from " + dbName + ".FUNCTIE";
        try {
            stmt = con.createStatement();
            ResultSet rs = stmt.executeQuery(query);
            while (rs.next() && counter <= 100) {
                String NAME = rs.getString("NUME");
                int ID = rs.getInt("ID");
                int SALAR = rs.getInt("SALAR");
                System.out.println(center(NAME,40) + "|" +
                        center(Integer.toString(ID),40) + "|" + center(Integer.toString(SALAR),40));
                counter++;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            if (stmt != null) {
                stmt.close();
            }
        }
    }
    public static void introducereComanda(Connection con, String dbName)
            throws SQLException {
        int counter = 0;
        Scanner reader = new Scanner(System.in);
        PreparedStatement stmt = null;
        String query = "INSERT INTO " + dbName + ".COMENZI_MV VALUES(SYSDATE,?,?,?,SYSDATE+3,'Din aplicatie',?)";
        try {
            stmt = con.prepareStatement(query);
            System.out.println("ID_PRODUS:");
            stmt.setInt(1, reader.nextInt());
            System.out.println("ID_ANGAJAT:");
            stmt.setInt(2, reader.nextInt());
            System.out.println("ID_COMANDA:");
            stmt.setInt(3, reader.nextInt());
            System.out.println("ID_USER:");
            stmt.setInt(4, reader.nextInt());
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            if (stmt != null) {
                stmt.close();
                System.out.println("Insert done!");
            }
        }
    }
    public static void stergereProdus(Connection con, String dbName)
            throws SQLException {
        int counter = 0;
        Scanner reader = new Scanner(System.in);
        PreparedStatement stmt = null;
        String query = "DELETE FROM " + dbName + ".PRODUSE_MV WHERE ID=?";
        try {
            stmt = con.prepareStatement(query);
            System.out.println("ID_PRODUS:");
            stmt.setInt(1, reader.nextInt());
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            if (stmt != null) {
                stmt.close();
                System.out.println("Delete done!");
            }
        }
    }
    public static void updateUser(Connection con, String dbName)
            throws SQLException {
        int ID = 0;
        Scanner reader = new Scanner(System.in);
        PreparedStatement stmt = null;
        String query = "UPDATE  " + dbName + ".USERS_MV SET NUME=?,PRENUME=?,MAIL=?,ADRESA=? WHERE ID=?";
        try {
            stmt = con.prepareStatement(query);

            System.out.println("ID_USER:");
            ID=reader.nextInt();
            System.out.println("NUME NOU:");
            String nume=reader.next();
            System.out.println("PRENUME NOU:");
            String prenume=reader.next();
            System.out.println("MAIL NOU:");
            String mail=reader.next();
            System.out.println("ADRESA NOUA:");
            String adresa=reader.next();
            stmt.setString(1, nume);
            stmt.setString(2, prenume);
            stmt.setString(3, mail);
            stmt.setString(4, adresa);
            stmt.setInt(5, ID);
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            if (stmt != null) {
                stmt.close();
                System.out.println("Update done!");
            }
        }
    }

    public static void Interfata123(Connection con, String dbName) {
        Scanner reader = new Scanner(System.in);
        int n = 0;
        while (true) {
            System.out.println("\nYour options are:\n\t1.Afisare utilizatori." +
                    "\n\t2.Afisare angajati." +
                    "\n\t3.Afisare categorii." +
                    "\n\t4.Afisare functii." +
                    "\n\t5.Afisare comenzi." +
                    "\n\t6.Afisare angajatii unui magazin." +
                    "\n\t7.Exportati database-ul." +
                    "\n\t8.Introducere comanda" +
                    "\n\t9.Stergere produs" +
                    "\n\t10.Update user" +
                    "\n\t11.Exit.\n");
            do {
                if (n < 1 || n > 11)
                    System.out.println("\nBetween 1 and 11 pls.");
                n = reader.nextInt();
            } while (n < 1 || n > 11);
            switch (n) {
                case 1:
                    try {
                        viewUSERS(con, dbName);
                    } catch (SQLException e) {
                        e.printStackTrace();
                    }
                    break;
                case 2:
                    try {
                        viewANGAJATI(con, dbName);
                    } catch (SQLException e) {
                        e.printStackTrace();
                    }
                    break;
                case 3:
                    try {
                        viewCATEGORII(con, dbName);
                    } catch (SQLException e) {
                        e.printStackTrace();
                    }
                    break;
                case 4:
                    try {
                        viewFUNCTII(con, dbName);
                    } catch (SQLException e) {
                        e.printStackTrace();
                    }
                    break;
                case 5:
                    try {
                        viewComenzi(con, dbName);
                    } catch (SQLException e) {
                        e.printStackTrace();
                    }
                    break;
                case 6:
                    try {
                        viewAngajati_magazin(con, dbName);
                    } catch (SQLException e) {
                        e.printStackTrace();
                    }
                    break;
                case 7:
                    try {
                        exportDatabase(con, dbName);
                    } catch (SQLException e) {
                        e.printStackTrace();
                    }
                    break;
                case 8:
                    try {
                        introducereComanda(con, dbName);
                    } catch (SQLException e) {
                        e.printStackTrace();
                    }
                    break;
                case 9:
                    try {
                        stergereProdus(con, dbName);
                    } catch (SQLException e) {
                        e.printStackTrace();
                    }
                    break;
                case 10:
                    try {
                        updateUser(con, dbName);
                    } catch (SQLException e) {
                        e.printStackTrace();
                    }
                    break;
                case 11:
                    System.out.println("Bye bye");
                    System.exit(0);
                    break;
            }
        }
    }
}