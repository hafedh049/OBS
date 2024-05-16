package Database;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.Statement;

public class DatabaseHelper {
        final private String url = "jdbc:mysql://localhost:3306/java";
        final private String username = "root";
        final private String password = "";

        final private Connection connection;

        public static Statement statement;

        public DatabaseHelper() throws Exception {
                this.connection = DriverManager.getConnection(url, username, password);
                statement = connection.createStatement();
                statement.execute("CREATE TABLE IF NOT EXISTS BANKS (\r\n" +
                                "    BANKID VARCHAR(50),\r\n" +
                                "    BANKNAME VARCHAR(100),\r\n" +
                                "    BANKADDRESS VARCHAR(255),\r\n" +
                                "    PRIMARY KEY (BANKID, BANKNAME, BANKADDRESS)\r\n" +
                                ");");
                statement.execute("CREATE TABLE IF NOT EXISTS USERS (\r\n" +
                                "    USERID VARCHAR(255) ,\r\n" +
                                "    USERNAME VARCHAR(50),\r\n" +
                                "    PASSWORD VARCHAR(255),\r\n" +
                                "    EMAIL VARCHAR(100),\r\n" +
                                "    ROLE VARCHAR(100),\r\n" +
                                "    BANKID VARCHAR(100) REFERENCES BANKS(BANKID),\r\n" +
                                "    PRIMARY KEY (USERID,USERNAME,EMAIL,PASSWORD)\r\n" +
                                ");");

                statement.execute("CREATE TABLE IF NOT EXISTS TRANSACTIONS (\r\n" +
                                "TRANSACTIONID VARCHAR(255) PRIMARY KEY,\r\n" +
                                "SENDERID VARCHAR(255)REFERENCES ACCOUNT(ACCOUNTNUMBER),\r\n" +
                                "RECEIVERID VARCHAR(255)REFERENCES ACCOUNT(ACCOUNTNUMBER),\r\n" +
                                "CURRENCYFROM VARCHAR(255),\r\n" +
                                "CURRENCYTO VARCHAR(255),\r\n" +
                                "AMOUNT DOUBLE,\r\n" +
                                "TIMESTAMP VARCHAR(100),\r\n" +
                                "DESCRIPTION TEXT,\r\n" +
                                "STATUS TEXT\r\n" +
                                ");");

                statement.execute("CREATE TABLE IF NOT EXISTS ACCOUNTS (" +
                                "ACCOUNTBANKID VARCHAR(255) REFERENCES BANKS(BANKID)," +
                                "ACCOUNTHOLDERID VARCHAR(255) REFERENCES USERS(USERID)," +
                                "ACCOUNTNUMBER VARCHAR(255), " +
                                "ACCOUNTHOLDERNAME VARCHAR(255), " +
                                "BALANCE DOUBLE, " +
                                "ACCOUNTTYPE VARCHAR(255), " +
                                "ISACTIVE VARCHAR(255), " +
                                "OVERDRAFTLIMIT DOUBLE, " +
                                "MAXTRANSLIMIT DOUBLE, " +
                                "INTERESTRATE DOUBLE, " +
                                "MINIMUMBALANCE DOUBLE, " +
                                "WITHDRAWLIMIT DOUBLE," +
                                "CREATEDAT VARCHAR(100)," +
                                "PRIMARY KEY(ACCOUNTBANKID,ACCOUNTHOLDERID,ACCOUNTNUMBER)" +
                                ");");
        }
}
