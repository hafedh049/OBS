package User;

import com.mysql.cj.xdevapi.DbDoc;

import Bank.Bank;
import Database.DatabaseHelper;

public class Admin extends User {
        public Admin(DbDoc json) {
                super(json.get("USERID"), json, password, email, "ADMIN");
        }

        public void addBank(Bank bank) throws Exception {
                DatabaseHelper.statement
                                .executeQuery(
                                                String.format(
                                                                "INSERT INTO BANKS(BANKID,BANKNAME,BANKADDRESS) VALUES('%s','%s','%s');",
                                                                bank.getBankID(), bank.getBankID(), bank.getBankName(),
                                                                bank.getBankAddress()));
        }

        public void deleteBank(String bankID) throws Exception {
                DatabaseHelper.statement.executeQuery(String.format("DELETE FROM BANKS WHERE BANKID = '%s';", bankID));
        }

        public void updateBank(Bank bank) throws Exception {
                DatabaseHelper.statement
                                .executeQuery(String.format(
                                                "UPDATE BANKS SET BANKNAME = '%s',BANKNAME = '%s' WHERE BANKID = %s;",
                                                bank.getBankName(), bank.getBankAddress(), bank.getBankID()));
        }

        public void addClient(Client client) throws Exception {
                DatabaseHelper.statement
                                .executeQuery(
                                                String.format(
                                                                "INSERT INTO USERS VALUES('%s','%s','%s','%s','CLIENT');",
                                                                client.userID, client.username, client.password,
                                                                client.email));

        }

        public void deleteClient(String clientID) throws Exception {
                DatabaseHelper.statement
                                .executeQuery(String.format("DELETE FROM USERS WHERE USERID = '%s';", clientID));

        }

        public void updateClient(Client client) throws Exception {
                DatabaseHelper.statement
                                .executeQuery(
                                                String.format(
                                                                "UPDATE USERS SET USERNAME = '%s',EMAIL = '%s',PASSWORD = '%s' WHERE USERID = %s;",
                                                                client.username, client.email, client.password,
                                                                client.userID));

        }

        public void addAgent(Agent agent) throws Exception {
                DatabaseHelper.statement
                                .executeQuery(
                                                String.format(
                                                                "INSERT INTO USERS VALUES('%s','%s','%s','%s','AGENT');",
                                                                agent.userID, agent.username, agent.password,
                                                                agent.email));

        }

        public void deleteAgent(Agent agentID) throws Exception {
                DatabaseHelper.statement.executeQuery(String.format("DELETE FROM USERS WHERE USERID = '%s';", agentID));

        }

        public void updateAgent(Agent agent) throws Exception {
                DatabaseHelper.statement
                                .executeQuery(
                                                String.format(
                                                                "UPDATE USERS SET USERNAME = '%s',EMAIL = '%s',PASSWORD = '%s' WHERE USERID = %s;",
                                                                agent.username, agent.email, agent.password,
                                                                agent.userID));

        }

        // JUST FOR TESTING PURPOSES
        public void addAdmin() throws Exception {
                DatabaseHelper.statement
                                .executeQuery(
                                                String.format(
                                                                "INSERT INTO USERS VALUES('0','HAFEDH GUENICHI','norootsquach','hafedhgunichi@gmail.com','ADMIN');"));

        }

}
