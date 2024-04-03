package Transaction;

import java.util.*;

import Database.DatabaseHelper;

public class Transaction {
    private String transactionID;
    private String from;
    private String to;
    private double amount;
    private Date transactionDate;
    private String description;

    public Transaction(String from, String to, double amount, Date transactionDate,
            String description) {
        this.transactionID = UUID.randomUUID().toString();
        this.from = from;
        this.to = to;
        this.amount = amount;
        this.transactionDate = transactionDate;
        this.description = description;
    }

    public String getTransactionID() {
        return transactionID;
    }

    public void setTransactionID(String transactionID) {
        this.transactionID = transactionID;
    }

    public String getFrom() {
        return from;
    }

    public void setTo(String to) {
        this.to = to;
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

    public void makeTransaction() throws Exception {
        DatabaseHelper.statement.execute(String.format("INSERT INTO TRANSACTIONS VALUES('%s','%s','%s',%.2f,%tF,'%s');",
                transactionID, from, to, amount, transactionDate, description));
    }

    public void deleteTransaction() throws Exception {
        DatabaseHelper.statement
                .execute(String.format("DELETE FROM TRANSACTIONS WHERE TRANSACTIONID = %s;", transactionID));
    }
}
