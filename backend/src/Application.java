
import Database.DatabaseHelper;
import GUI.AddBank;
import GUI.AddUser;
import GUI.ForgetPassword;
import GUI.GetAllBanks;
import GUI.GetAllUsers;
import GUI.Login;
import GUI.SignUp;

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
			server.createContext("/addBank", new AddBank());
			server.createContext("/addUser", new AddUser());
			server.createContext("/getAllBanks", new GetAllBanks());
			server.createContext("/getAllUsers", new GetAllUsers());
			server.start();
			System.out.println("Server is running on port 8000");
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
