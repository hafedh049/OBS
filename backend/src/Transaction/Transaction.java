package Transaction;

import java.time.Instant;
import java.util.*;

import com.mysql.cj.xdevapi.DbDoc;

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

    public Transaction(DbDoc json) {
        this.currencyFrom = json.get("currencyfrom").toString().replaceAll("\"", "");
        this.currencyTo = json.get("currencyto").toString().replaceAll("\"", "");
        this.transactionID = UUID.randomUUID().toString();
        this.from = json.get("senderid").toString().replaceAll("\"", "");
        this.to = json.get("receiverid").toString().replaceAll("\"", "");
        this.amount = Double.parseDouble(json.get("amount").toString().replaceAll("\"", ""));
        this.transactionDate = Date.from(Instant.now());
        this.description = json.get("description").toString().replaceAll("\"", "");
        this.transactionState = json.get("state").toString().replaceAll("\"", "");
    }

    public void setFrom(String from) {
        this.from = from;
    }

    public String getTo() {
        return to;
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

}
