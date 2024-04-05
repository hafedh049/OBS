package Transaction;

import java.util.*;

import Database.DatabaseHelper;

public class Transaction {
    private String transactionID;
    private String from;
    private String to;
    private String currencyFrom;
    private String currencyTo;

    private double amount;
    private Date transactionDate;
    private String description;
    private String transactionState;

    public Transaction(String from, String to, double amount, Date transactionDate,
            String description, String transaction, String currencyFrom, String currencyTo) {
        this.currencyFrom = currencyFrom;
        this.currencyTo = currencyTo;
        this.transactionID = UUID.randomUUID().toString();
        this.from = from;
        this.to = to;
        this.amount = amount;
        this.transactionDate = transactionDate;
        this.description = description;
        this.transactionState = transaction;
    }

    public String getCurrencyFrom() {
        return currencyFrom;
    }

    public void setCurrencyFrom(String currencyFrom) {
        this.currencyFrom = currencyFrom;
    }

    public String getCurrencyTo() {
        return currencyTo;
    }

    public void setCurrencyTo(String currencyTo) {
        this.currencyTo = currencyTo;
    }

    public String getTransactionState() {
        return transactionState;
    }

    public void setTransactionState(String transactionState) {
        this.transactionState = transactionState;
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
        DatabaseHelper.statement
                .execute(String.format("INSERT INTO TRANSACTIONS VALUES('%s','%s','%s','%s','%s',%.2f,%tF,'%s');",
                        transactionID, from, to, currencyFrom, currencyTo, amount, transactionDate, description));
    }

    public void deleteTransaction() throws Exception {
        DatabaseHelper.statement
                .execute(String.format("DELETE FROM TRANSACTIONS WHERE TRANSACTIONID = '%s';", transactionID));
    }
}
