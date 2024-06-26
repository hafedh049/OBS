package GUI;

import java.sql.ResultSet;

import com.mysql.cj.xdevapi.DbDoc;
import com.mysql.cj.xdevapi.JsonParser;

import Database.DatabaseHelper;

import java.io.IOException;
import com.sun.net.httpserver.HttpHandler;
import com.sun.net.httpserver.HttpExchange;
import java.io.OutputStream;
import java.io.InputStream;

public class ForgetPassword implements HttpHandler {

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
                    .executeQuery("SELECT * FROM USERS WHERE EMAIL = " + json.get("email") + ";");
            if (resultSet.next()) {
                DatabaseHelper.statement
                        .execute("UPDATE USERS SET PASSWORD = " + json.get("password") + " WHERE EMAIL = "
                                + json.get("email") + ";");
                response = "{\"data\":\"Password changed successfully\"}";
            } else {
                response = "{\"data\":\"E-mail not found\"}";
            }
        } catch (Exception e) {
            System.out.println(e);
            response = "{\"data\":\"%s\"}".formatted(e.toString());
        }

        final OutputStream responseBody = exchange.getResponseBody();

        responseBody.write(response.getBytes());

        responseBody.close();
    }
}
