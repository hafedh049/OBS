package Database;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.Statement;

public class DatabaseHelper {
    final private String url = "jdbc:mysql://localhost:3306/backend";
    final private String username = "root";
    final private String password = "";

    final private Connection connection;

    public static Statement statement;

    public DatabaseHelper() throws Exception {
        this.connection = DriverManager.getConnection(url, username, password);
        statement = connection.createStatement();
        statement.execute("CREATE TABLE IF NOT EXISTS BANKS (\r\n" + //
                "    BANKID VARCHAR(50),\r\n" + //
                "    BANKNAME VARCHAR(100),\r\n" + //
                "    BANKADDRESS VARCHAR(255),\r\n" + //
                "    BANKBRANCHES INT,\r\n" + //
                "    BANKCUSTOMERS INT,\r\n" + //
                "    PRIMARY KEY (BANKID, BANKNAME, BANKADDRESS)\r\n" + //
                ");");
        statement.execute("CREATE TABLE IF NOT EXISTS USERS (\r\n" + //
                "    USERID INT AUTO_INCREMENT,\r\n" + //
                "    USERNAME VARCHAR(50) UNIQUE,\r\n" + //
                "    PASSWORD VARCHAR(255),\r\n" + //
                "    EMAIL VARCHAR(100) UNIQUE,\r\n" + //
                "    PRIMARY KEY (USERID,USERNAME,EMAIL,PASSWORD)\r\n" + //
                ");");
    }
}
