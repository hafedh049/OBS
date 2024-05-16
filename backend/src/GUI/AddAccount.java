package GUI;

import com.mysql.cj.xdevapi.DbDoc;
import com.mysql.cj.xdevapi.JsonParser;

import java.io.IOException;
import com.sun.net.httpserver.HttpHandler;

import Account.CurrentAccount;
import Account.SavingsAccount;
import User.Client;

import com.sun.net.httpserver.HttpExchange;
import java.io.OutputStream;
import java.io.InputStream;

public class AddAccount implements HttpHandler {

    @Override
    public void handle(HttpExchange exchange) throws IOException {
        exchange.getResponseHeaders().set("Content-Type", "application/json");
        exchange.sendResponseHeaders(200, 0);

        final InputStream requestBody = exchange.getRequestBody();

        final String request = new String(requestBody.readAllBytes());

        final DbDoc json = JsonParser.parseDoc(request);

        String response = "";

        try {
            if (json.get("type").toString().equals("\"CURRENT\"")) {
                Client.addAccount(new CurrentAccount(json));
            } else {
                Client.addAccount(new SavingsAccount(json));
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