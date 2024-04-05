package GUI;

import java.io.IOException;
import com.sun.net.httpserver.HttpHandler;

import Database.DatabaseHelper;

import com.sun.net.httpserver.HttpExchange;
import java.io.OutputStream;
import java.sql.ResultSet;

public class GetAllAccounts implements HttpHandler {

    @Override
    public void handle(HttpExchange exchange) throws IOException {
        exchange.getResponseHeaders().set("Content-Type", "application/json");
        exchange.sendResponseHeaders(200, 0);

        String response = "{\"data\":[";

        try {
            final ResultSet resultSet = DatabaseHelper.statement.executeQuery("SELECT * FROM ACCOUNTS;");
            while (resultSet.next()) {
                if (resultSet.getString("ACCOUNTTYPE").equals("CURRENT")) {
                    response += "{\"accountbankid\":\"%s\",\"accountholderid\":\"%s\",\"accountholdername\":\"%s\",\"accountnumber\":\"%s\",\"balance\":%.2f,\"accounttype\":\"%s\",\"isactive\":\"%s\",\"overdraftlimit\":%.2f,\"maxtranslimit\":%.2f},"
                            .formatted(
                                    resultSet.getString("ACCOUNTBANKID"),
                                    resultSet.getString("ACCOUNTHOLDERID"),
                                    resultSet.getString("ACCOUNTHOLDERNAME"),
                                    resultSet.getString("ACCOUNTNUMBER"),
                                    resultSet.getString("BALANCE"),
                                    resultSet.getString("ACCOUNTTYPE"),
                                    resultSet.getString("ISACTIVE"),
                                    resultSet.getString("OVERDRAFTLIMIT"),
                                    resultSet.getString("MAXTRANSLIMIT"));
                } else {
                    response += "{\"accountbankid\":\"%s\",\"accountholderid\":\"%s\",\"accountholdername\":\"%s\",\"accountnumber\":\"%s\",\"balance\":%.2f,\"accounttype\":\"%s\",\"isactive\":\"%s\",\"interestrate\":%.2f,\"minimumbalance\":%.2f,\"withdrawallimit\":%.2f},"
                            .formatted(
                                    resultSet.getString("ACCOUNTBANKID"),
                                    resultSet.getString("ACCOUNTHOLDERID"),
                                    resultSet.getString("ACCOUNTHOLDERNAME"),
                                    resultSet.getString("ACCOUNTNUMBER"),
                                    resultSet.getString("BALANCE"),
                                    resultSet.getString("ACCOUNTTYPE"),
                                    resultSet.getString("ISACTIVE"),
                                    resultSet.getString("INTERESTRATE"),
                                    resultSet.getString("MINIMUMBALANCE"), resultSet.getString("WITHDRAWLIMIT"));
                }
            }
            response = response.substring(0, response.length() - 1) + "]}";
        } catch (Exception e) {
            System.out.println(e);
            response = "{\"data\":\"%s\"}".formatted(e.toString());
        }

        final OutputStream responseBody = exchange.getResponseBody();

        responseBody.write(response.getBytes());

        responseBody.close();
    }

}
