package GUI;

import java.sql.ResultSet;
import java.util.UUID;

import Database.DatabaseHelper;

public class SignUp {
    public static void signUp(String username, String email, String password) throws Exception {
        final ResultSet resultSet = DatabaseHelper.statement
                .executeQuery("SELECT USERNAME, PASSWORD FROM USERS WHERE USERNAME = '" + username + "'"
                        + " AND PASSWORD = '" + password + "'");
        if (resultSet.next()) {
            System.out.println("Username already exists!");
            return;
        } else {
            DatabaseHelper.statement
                    .execute("INSERT INTO USERS (ID,USERNAME, EMAIL, PASSWORD) VALUES ('" + UUID.randomUUID().toString()
                            + "','" + username
                            + "', '" + email + "', '" + password + "')");
            System.out.println("Sign up successful!");
        }
    }
}
