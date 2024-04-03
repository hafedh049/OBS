
import Database.DatabaseHelper;
import Helper.CreateUserHelper;

import java.net.InetSocketAddress;
import com.sun.net.httpserver.HttpServer;

public class Application {
	public static void main(String[] args) {
		try {
			new DatabaseHelper();
			System.out.println("Connected to database!");
			HttpServer server = HttpServer.create(new InetSocketAddress(8000), 0);
			server.createContext("/createUser", new CreateUserHelper());
			server.createContext("/signUser", new CreateUserHelper());
			server.createContext("/createCurrentAccount", new CreateUserHelper());
			server.createContext("/createSavingsAccount", new CreateUserHelper());
			server.start();
			System.out.println("Server is running on port 8000");
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
