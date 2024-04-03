package User;

public abstract class User {
    protected String userID;
    protected String username;
    protected String password;
    protected String email;
    protected String type;

    public User(String userID, String username, String password, String email, String type) {
        this.userID = userID;
        this.username = username;
        this.password = password;
        this.email = email;
        this.type = type;
    }
}
