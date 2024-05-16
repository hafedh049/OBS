package GUI;

import java.io.IOException;
import com.sun.net.httpserver.HttpHandler;

import Database.DatabaseHelper;

import com.sun.net.httpserver.HttpExchange;
import java.io.OutputStream;
import java.sql.ResultSet;

public class GetAllAccounts implements HttpHandler {
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
            final ResultSet resultSet = DatabaseHelper.statement.executeQuery("SELECT * FROM ACCOUNTS;");
            while (resultSet.next()) {
                if (resultSet.getString("ACCOUNTTYPE").equals("CURRENT")) {
                    response += "{\"accountbankid\":\"%s\",\"accountholderid\":\"%s\",\"accountholdername\":\"%s\",\"accountnumber\":\"%s\",\"balance\":%.2f,\"accounttype\":\"%s\",\"isactive\":\"%s\",\"createdat\":\"%s\",\"overdraftlimit\":%.2f,\"maxtranslimit\":%.2f},"
                            .formatted(
                                    resultSet.getString("ACCOUNTBANKID"),
                                    resultSet.getString("ACCOUNTHOLDERID"),
                                    resultSet.getString("ACCOUNTHOLDERNAME"),
                                    resultSet.getString("ACCOUNTNUMBER"),
                                    resultSet.getDouble("BALANCE"),
                                    resultSet.getString("ACCOUNTTYPE"),
                                    resultSet.getString("ISACTIVE"),
                                    resultSet.getDate("CREATEDAT").toString(),
                                    resultSet.getDouble("OVERDRAFTLIMIT"),
                                    resultSet.getDouble("MAXTRANSLIMIT"));
                } else {
                    response += "{\"accountbankid\":\"%s\",\"accountholderid\":\"%s\",\"accountholdername\":\"%s\",\"accountnumber\":\"%s\",\"balance\":%.2f,\"accounttype\":\"%s\",\"isactive\":\"%s\",\"createdat\":\"%s\",\"interestrate\":%.2f,\"minimumbalance\":%.2f,\"withdrawlimit\":%f},"
                            .formatted(
                                    resultSet.getString("ACCOUNTBANKID"),
                                    resultSet.getString("ACCOUNTHOLDERID"),
                                    resultSet.getString("ACCOUNTHOLDERNAME"),
                                    resultSet.getString("ACCOUNTNUMBER"),
                                    resultSet.getDouble("BALANCE"),
                                    resultSet.getString("ACCOUNTTYPE"),
                                    resultSet.getString("ISACTIVE"),
                                    resultSet.getDate("CREATEDAT").toString(),
                                    resultSet.getDouble("INTERESTRATE"),
                                    resultSet.getDouble("MINIMUMBALANCE"), resultSet.getDouble("WITHDRAWLIMIT"));
                }
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