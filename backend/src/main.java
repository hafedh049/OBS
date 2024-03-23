import http.HttpHelper;

class Main {

    public static void main(String[] args) {
        System.out.println(HttpHelper.getRequest("https://dummy.restapiexample.com/api/v1/employees"));
    }
}