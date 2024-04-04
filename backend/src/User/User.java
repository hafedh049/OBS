package User;

import com.mysql.cj.xdevapi.DbDoc;

public abstract class User {
    protected String userID;
    protected String username;
    protected String password;
    protected String email;
    protected String role;

    public User(DbDoc json) {
        this.userID = json.get("userid").toString().replaceAll("\"", "");
        this.username = json.get("username").toString().replaceAll("\"", "");
        this.password = json.get("password").toString().replaceAll("\"", "");
        this.email = json.get("email").toString().replaceAll("\"", "");
        this.role = json.get("role").toString().replaceAll("\"", "");
    }
}
