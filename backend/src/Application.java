
import Database.DatabaseHelper;
import GUI.Login;

public class Application {
	public static void main(String[] args) {
		try {
			final DatabaseHelper $ = new DatabaseHelper();
			System.out.println("Connected to database!");
			Login.login("admin", "admin");
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
