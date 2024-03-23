package http;

import java.io.IOException;
import java.net.URI;
import java.net.URISyntaxException;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpRequest.BodyPublishers;
import java.net.http.HttpResponse;
import java.net.http.HttpResponse.BodyHandlers;

import com.google.gson.Gson;

public class HttpHelper {
    public static String postRequest(String uri, String body) {
        Gson gson = new Gson();
        try {
            HttpRequest request = HttpRequest.newBuilder().uri(new URI(uri))
                    .POST(BodyPublishers.ofString(body)).build();
            System.out.println(request.bodyPublisher());
            return gson.toJson(request.bodyPublisher());
        } catch (URISyntaxException e) {
            e.printStackTrace();
            return null;
        }
    }

    public static String getRequest(String uri) {
        Gson gson = new Gson();
        try {
            HttpRequest request = HttpRequest.newBuilder().uri(new URI(uri))
                    .GET().build();
            HttpClient client = HttpClient.newHttpClient();
            HttpResponse response = client.send(request, BodyHandlers.ofString());
            System.out.println(response.body());
            return gson.toJson(response.body());
        } catch (URISyntaxException e) {
            e.printStackTrace();
            return null;
        } catch (IOException e) {
            e.printStackTrace();
        } catch (InterruptedException e) {
            e.printStackTrace();
        }
        return null;
    }
}
