package GUI;

import java.sql.ResultSet;
import java.util.UUID;

import java.io.IOException;
import com.sun.net.httpserver.HttpHandler;
import com.mysql.cj.xdevapi.DbDoc;
import com.mysql.cj.xdevapi.JsonParser;
import com.sun.net.httpserver.HttpExchange;
import java.io.OutputStream;
import java.io.InputStream;

import Database.DatabaseHelper;

public class SignUp implements HttpHandler {

    @Override
    public void handle(HttpExchange exchange) throws IOException {
        exchange.getResponseHeaders().set("Content-Type", "application/json");
        exchange.sendResponseHeaders(200, 0);
        final InputStream requestBody = exchange.getRequestBody();
        final String request = new String(requestBody.readAllBytes());

        final DbDoc json = JsonParser.parseDoc(request);

        String response = "";

        try {
            final ResultSet resultSet = DatabaseHelper.statement
                    .executeQuery("SELECT * FROM USERS WHERE USERNAME = " + json.get("username")
                            + " AND PASSWORD = " + json.get("password") + ";");
            if (resultSet.next()) {
                response = "{\"data\":\"Username already exists\"}";
            } else {
                DatabaseHelper.statement
                        .execute("INSERT INTO USERS VALUES ('"
                                + UUID.randomUUID().toString()
                                + "'," + json.get("username")
                                + ", " + json.get("password") + ", " + json.get("email") + ", " + json.get("role")
                                + ")");

                response = "{\"data\":\"Signed up successfully!\"}";
            }
        } catch (Exception e) {
            System.out.println(e);
        }

        final OutputStream responseBody = exchange.getResponseBody();

        responseBody.write(response.getBytes());

        responseBody.close();
    }
}