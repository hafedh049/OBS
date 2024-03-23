package users;

public class Admin extends User {

    public Admin(String id, String username, String email, String password) {
        super(id, username, email, password);
    }

    @Override
    public String toString() {
        return super.toString();
    }

    @Override
    protected void finalize() {

    }

    @Override
    void resetPassword() {

    }

    @Override
    void signIn() {

    }

    @Override
    void signOut() {

    }

    @Override
    void signUp() {

    }

}
