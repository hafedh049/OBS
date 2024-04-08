package GUI;

import com.mysql.cj.xdevapi.DbDoc;
import com.mysql.cj.xdevapi.JsonParser;

import java.io.IOException;
import com.sun.net.httpserver.HttpHandler;

import Transaction.Transaction;
import User.Client;

import com.sun.net.httpserver.HttpExchange;
import java.io.OutputStream;
import java.io.InputStream;

public class Deposit implements HttpHandler {

    @Override
    public void handle(HttpExchange exchange) throws IOException {
        exchange.getResponseHeaders().set("Content-Type", "application/json");
        exchange.sendResponseHeaders(200, 0);

        final InputStream requestBody = exchange.getRequestBody();

        final String request = new String(requestBody.readAllBytes());

        final DbDoc json = JsonParser.parseDoc(request);

        String response = "";

        try {
            Client.deposit(new Transaction(json));
        } catch (Exception e) {
            System.out.println(e);
            response = "{\"data\":\"%s\"}".formatted(e.toString());
        }

        final OutputStream responseBody = exchange.getResponseBody();

        responseBody.write(response.getBytes());

        responseBody.close();
    }

}
