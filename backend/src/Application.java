
import Database.DatabaseHelper;
import GUI.AddAccount;
import GUI.AddBank;
import GUI.AddUser;
import GUI.DeleteBank;
import GUI.DeleteUser;
import GUI.ForgetPassword;
import GUI.GetAllAccounts;
import GUI.GetAllBanks;
import GUI.GetAllUsers;
import GUI.Login;
import GUI.SignUp;
import GUI.UpdateBank;
import GUI.UpdateUser;

import java.net.InetSocketAddress;
import com.sun.net.httpserver.HttpServer;

public class Application {
	public static void main(String[] args) {
		try {
			new DatabaseHelper();
			System.out.println("Connected to database!");
			final HttpServer server = HttpServer.create(new InetSocketAddress("127.0.0.1", 8000), 0);
			server.createContext("/createUser", new SignUp());
			server.createContext("/signUser", new Login());
			server.createContext("/resetPassword", new ForgetPassword());
			server.createContext("/addBank", new AddBank());
			server.createContext("/updateBank", new UpdateBank());
			server.createContext("/deleteBank", new DeleteBank());
			server.createContext("/getAllBanks", new GetAllBanks());
			server.createContext("/addUser", new AddUser());
			server.createContext("/updateUser", new UpdateUser());
			server.createContext("/deleteUser", new DeleteUser());
			server.createContext("/getAllUsers", new GetAllUsers());
			server.createContext("/addAccount", new AddAccount());
			server.createContext("/getAllAccounts", new GetAllAccounts());
			server.start();
			System.out.println("Server is running on port 8000");
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
