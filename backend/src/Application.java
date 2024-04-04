
import Database.DatabaseHelper;
import GUI.ForgetPassword;
import GUI.Login;
import GUI.SignUp;
import Helper.CreateUserHelper;

import java.net.InetSocketAddress;
import com.sun.net.httpserver.HttpServer;

public class Application {
	public static void main(String[] args) {
		try {
			new DatabaseHelper();
			System.out.println("Connected to database!");
			HttpServer server = HttpServer.create(new InetSocketAddress("127.0.0.1", 8000), 0);
			server.createContext("/createUser", new SignUp());
			server.createContext("/signUser", new Login());
			server.createContext("/resetPassword", new ForgetPassword());
			server.createContext("/createSavingsAccount", new CreateUserHelper());
			server.start();
			System.out.println("Server is running on port 8000");
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
