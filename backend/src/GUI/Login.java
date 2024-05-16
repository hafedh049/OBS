package GUI;

import java.sql.ResultSet;

import Database.DatabaseHelper;

import java.io.IOException;
import com.sun.net.httpserver.HttpHandler;
import com.mysql.cj.xdevapi.DbDoc;
import com.mysql.cj.xdevapi.JsonParser;
import com.sun.net.httpserver.HttpExchange;
import java.io.OutputStream;
import java.io.InputStream;

public class Login implements HttpHandler {

	@Override
	public void handle(HttpExchange exchange) throws IOException {
		exchange.getResponseHeaders().set("Content-Type", "application/json");
		exchange.sendResponseHeaders(200, 0);
		final InputStream requestBody = exchange.getRequestBody();
		final String request = new String(requestBody.readAllBytes());

		final DbDoc json = JsonParser.parseDoc(request);

		String response = "";

		try {
			final ResultSet resultSet = DatabaseHelper.statement.executeQuery(String.format(
					"SELECT * FROM USERS WHERE USERNAME = %s;", json.get("username").toString()));
			if (!resultSet.next()) {
				response = "{\"data\":\"Username is incorrect!\"}";
			} else {
				resultSet.beforeFirst();

				response = "{\"data\":\"Password is incorrect!\"}";

				while (resultSet.next()) {
					if (resultSet.getString("PASSWORD")
							.equals(json.get("password").toString().replaceAll("\"", ""))) {
						response = "{\"data\":{\"userid\":\"%s\",\"bankid\":\"%s\",\"username\":\"%s\",\"email\":\"%s\",\"password\":\"%s\",\"role\":\"%s\"}}"
								.formatted(resultSet.getString("userid"), resultSet.getString("bankid"),
										resultSet.getString("username"),
										resultSet.getString("email"), resultSet.getString("password"),
										resultSet.getString("role"));
					}
				}

			}
		} catch (Exception e) {
			System.out.println(e);
		}

		final OutputStream responseBody = exchange.getResponseBody();

		responseBody.write(response.getBytes());

		responseBody.close();
	}
}