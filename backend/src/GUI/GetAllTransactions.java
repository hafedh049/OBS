package GUI;

import java.io.IOException;
import java.io.InputStream;

import com.sun.net.httpserver.HttpHandler;

import Database.DatabaseHelper;

import com.mysql.cj.xdevapi.DbDoc;
import com.mysql.cj.xdevapi.JsonParser;
import com.sun.net.httpserver.HttpExchange;
import java.io.OutputStream;
import java.sql.ResultSet;

public class GetAllTransactions implements HttpHandler {
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
            final InputStream requestBody = exchange.getRequestBody();

            final String request = new String(requestBody.readAllBytes());

            final DbDoc json = JsonParser.parseDoc(request);
            final ResultSet resultSet = DatabaseHelper.statement
                    .executeQuery(
                            String.format("SELECT * FROM TRANSACTIONS WHERE SENDERID = '%s' OR RECEIVERID = '%s';",
                                    json.get("senderid").toString().replaceAll("\"", ""),
                                    json.get("senderid").toString().replaceAll("\"", "")));
            while (resultSet.next()) {

                response += String.format(
                        "{\"transactionid\":\"%s\",\"senderid\":\"%s\",\"receiverid\":\"%s\",\"currencyfrom\":\"%s\",\"currencyto\":\"%s\",\"amount\":%f,\"timestamp\":\"%s\",\"description\":\"%s\",\"status\":\"%s\"},",
                        resultSet.getString("TRANSACTIONID"),
                        resultSet.getString("SENDERID"),
                        resultSet.getString("RECEIVERID"),
                        resultSet.getString("CURRENCYFROM"),
                        resultSet.getString("CURRENCYTO"),
                        resultSet.getDouble("AMOUNT"),
                        resultSet.getString("TIMESTAMP"),
                        resultSet.getString("DESCRIPTION"),
                        resultSet.getString("STATUS"));
            }
            response = replaceLast(response, ",", "") + "]}";
        } catch (Exception e) {
            e.printStackTrace();
            response = "{\"data\":\"%s\"}".formatted(e.toString());
        }

        final OutputStream responseBody = exchange.getResponseBody();

        responseBody.write(response.getBytes());

        responseBody.close();
    }

}
