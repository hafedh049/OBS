package GUI;

import java.sql.ResultSet;

import Database.DatabaseHelper;

public class Login {

	public static void login(String username, String password) throws Exception {
		final ResultSet resultSet = DatabaseHelper.statement.executeQuery(
				"SELECT USERNAME, PASSWORD FROM USERS WHERE USERNAME = '" + username + "'");

		if (!resultSet.next()) {
			System.out.println("Username is incorrect!");
			return;
		} else {
			while (resultSet.next()) {
				if (resultSet.getString("USERNAME").equals(username)
						&& resultSet.getString("PASSWORD").equals(password)) {
					System.out.println("Login successful!");
					return;
				}
			}
			System.out.println("Password is incorrect!");
		}

	}
}