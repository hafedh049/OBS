package User;

public class Agent extends User {

    public Agent(String userID, String username, String password, String email) {
        super(userID, username, password, email, "AGENT");
    }

}
