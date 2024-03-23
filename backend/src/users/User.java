package users;

public abstract class User {
    protected String id;
    protected String username;
    protected String email;
    protected String password;

    public User(String id, String username, String email, String password) {
        this.id = id;
        this.username = username;
        this.email = email;
        this.password = password;
    }

    abstract void signIn();

    abstract void signUp();

    abstract void signOut();

    abstract void resetPassword();
}