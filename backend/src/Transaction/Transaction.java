package Transaction;

import java.util.Date;

public class Transaction {
    private int transactionID;
    private int userID;
    private double amount;
    private Date transactionDate;
    private String description;

    public Transaction(int transactionID, int userID, double amount, Date transactionDate, String description) {
        this.transactionID = transactionID;
        this.userID = userID;
        this.amount = amount;
        this.transactionDate = transactionDate;
        this.description = description;
    }

    public int getTransactionID() {
        return transactionID;
    }

    public void setTransactionID(int transactionID) {
        this.transactionID = transactionID;
    }

    public int getUserID() {
        return userID;
    }

    public void setUserID(int userID) {
        this.userID = userID;
    }

    public double getAmount() {
        return amount;
    }

    public void setAmount(double amount) {
        this.amount = amount;
    }

    public Date getTransactionDate() {
        return transactionDate;
    }

    public void setTransactionDate(Date transactionDate) {
        this.transactionDate = transactionDate;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

}
