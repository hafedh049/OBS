package Helper;

import java.io.IOException;
import com.sun.net.httpserver.HttpHandler;
import com.mysql.cj.xdevapi.DbDoc;
import com.mysql.cj.xdevapi.JsonParser;
import com.sun.net.httpserver.HttpExchange;
import java.io.OutputStream;
import java.io.InputStream;

public class CreateUserHelper implements HttpHandler {
    @Override
    public void handle(HttpExchange exchange) throws IOException {

        exchange.getResponseHeaders().set("Content-Type", "application/json");
        exchange.sendResponseHeaders(200, 0);

        final InputStream requestBody = exchange.getRequestBody();
        final String request = new String(requestBody.readAllBytes());

        final DbDoc json = JsonParser.parseDoc(request);

        System.out.println(json.getOrDefault("voice", null));

        final OutputStream responseBody = exchange.getResponseBody();
        final String response = "Hello from Java HTTP Server!";

        responseBody.write(response.getBytes());

        responseBody.close();
    }
}
