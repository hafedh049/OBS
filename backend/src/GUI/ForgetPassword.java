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

    public static void resetPassword(String email, String newPassword) throws Exception {
        final ResultSet resultSet = DatabaseHelper.statement
                .executeQuery("SELECT * FROM USERS WHERE EMAIL = '" + email + "'");
        if (resultSet.next()) {
            DatabaseHelper.statement
                    .execute("UPDATE USERS SET PASSWORD = '" + newPassword + "' WHERE EMAIL = '" + email + "'");
            System.out.println("Mot de passe réinitialisé avec succès pour l'utilisateur avec l'email : " + email);
        } else {
            System.out.println("L'email spécifié n'existe pas dans la base de données.");
        }
    }

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
                        .execute("UPDATE USERS SET PASSWORD = " + json.get("email") + " WHERE EMAIL = "
                                + json.get("email") + ";");
                response = "{\"data\":\"Password change successfully\"}";
            } else {
                response = "{\"data\":\"E-mail not found\"}";
            }
        } catch (Exception e) {
            System.out.println(e);
        }

        final OutputStream responseBody = exchange.getResponseBody();

        responseBody.write(response.getBytes());

        responseBody.close();
    }
}
