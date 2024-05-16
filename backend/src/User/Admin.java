package User;

import java.sql.ResultSet;

import com.mysql.cj.xdevapi.DbDoc;

import Bank.Bank;
import Database.DatabaseHelper;

public class Admin extends User {
        public Admin(DbDoc json) {
                super(json);
        }

        public static void addBank(Bank bank) throws Exception {
                DatabaseHelper.statement
                                .execute(
                                                String.format(
                                                                "INSERT INTO BANKS(BANKID,BANKNAME,BANKADDRESS) VALUES('%s','%s','%s');",
                                                                bank.getBankID(), bank.getBankName(),
                                                                bank.getBankAddress()));
        }

        public static void deleteBank(String bankID) throws Exception {
                DatabaseHelper.statement.execute(String.format("DELETE FROM BANKS WHERE BANKID = '%s';", bankID));
                final ResultSet result = DatabaseHelper.statement
                                .executeQuery(String.format(
                                                "SELECT ACCOUNTNUMBER FROM ACCOUNTS WHERE ACCOUNTBANKID = '%s';",
                                                bankID));

                while (result.next()) {
                        DatabaseHelper.statement
                                        .execute(String.format(
                                                        "DELETE FROM TRANSACTIONS WHERE SENDERID = '%s' OR RECEIVERID = '%s';",
                                                        result.getString("ACCOUNTNUMBER"),
                                                        result.getString("ACCOUNTNUMBER")));
                }

                DatabaseHelper.statement.execute(String.format("DELETE FROM USERS WHERE BANKID = '%s';", bankID));
                DatabaseHelper.statement
                                .execute(String.format("DELETE FROM ACCOUNTS WHERE ACCOUNTBANKID = '%s';", bankID));
        }

        public static void updateBank(Bank bank) throws Exception {
                DatabaseHelper.statement
                                .execute(String.format(
                                                "UPDATE BANKS SET BANKNAME = '%s',BANKADDRESS = '%s' WHERE BANKID = '%s';",
                                                bank.getBankName(), bank.getBankAddress(), bank.getBankID()));
        }

        public static void addClient(Client client) throws Exception {
                DatabaseHelper.statement
                                .execute(
                                                String.format(
                                                                "INSERT INTO USERS VALUES('%s','%s','%s','%s','CLIENT',NULL);",
                                                                client.userID, client.username, client.password,
                                                                client.email));

        }

        public static void deleteClient(String clientID) throws Exception {
                DatabaseHelper.statement
                                .execute(String.format("DELETE FROM USERS WHERE USERID = '%s';", clientID));

        }

        public static void updateClient(Client client) throws Exception {
                DatabaseHelper.statement
                                .execute(
                                                String.format(
                                                                "UPDATE USERS SET USERNAME = '%s',EMAIL = '%s',PASSWORD = '%s' WHERE USERID = '%s';",
                                                                client.username, client.email, client.password,
                                                                client.userID));

        }

        public static void addAgent(Agent agent) throws Exception {
                DatabaseHelper.statement
                                .execute(
                                                String.format(
                                                                "INSERT INTO USERS VALUES('%s','%s','%s','%s','AGENT','%s');",
                                                                agent.userID, agent.username, agent.password,
                                                                agent.email, agent.bankID));

        }

        public static void deleteAgent(String agentID) throws Exception {
                DatabaseHelper.statement.execute(String.format("DELETE FROM USERS WHERE USERID = '%s';", agentID));

        }

        public static void updateAgent(Agent agent) throws Exception {
                DatabaseHelper.statement
                                .execute(
                                                String.format(
                                                                "UPDATE USERS SET USERNAME = '%s',EMAIL = '%s',PASSWORD = '%s' WHERE USERID = '%s';",
                                                                agent.username, agent.email, agent.password,
                                                                agent.userID));

        }

}
