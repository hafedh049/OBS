package GUI;

import java.io.IOException;
import com.sun.net.httpserver.HttpHandler;

import Database.DatabaseHelper;

import com.sun.net.httpserver.HttpExchange;
import java.io.OutputStream;
import java.sql.ResultSet;

public class GetAllUsers implements HttpHandler {
    public String replaceLast(String original, String searchString, String replacement) {
        int lastIndex = original.lastIndexOf(searchString);
        if (lastIndex == -1) {
            // If the search string is not found, return the original string unchanged
            return original;
        }
        String prefix = original.substring(0, lastIndex);
        String suffix = original.substring(lastIndex + searchString.length());
        return prefix + replacement + suffix;
    }

    @Override
    public void handle(HttpExchange exchange) throws IOException {
        exchange.getResponseHeaders().set("Content-Type", "application/json");
        exchange.sendResponseHeaders(200, 0);

        String response = "{\"data\":[";

        try {
            final ResultSet resultSet = DatabaseHelper.statement.executeQuery("SELECT * FROM USERS;");
            while (resultSet.next()) {
                response += "{\"userid\":\"%s\",\"username\":\"%s\",\"password\":\"%s\",\"email\":\"%s\",\"role\":\"%s\"},"
                        .formatted(
                                resultSet.getString("userid"),
                                resultSet.getString("username"), resultSet.getString("password"),
                                resultSet.getString("email"),
                                resultSet.getString("role"));
            }
            response = replaceLast(response, ",", "") + "]}";
        } catch (Exception e) {
            System.out.println(e);
            response = "{\"data\":\"%s\"}".formatted(e.toString());
        }

        final OutputStream responseBody = exchange.getResponseBody();

        responseBody.write(response.getBytes());

        responseBody.close();
    }

}
