package transactions;

import java.util.Date;

import enums.Currency;
import enums.TransactionType;

public class Transaction {

    private String transactionID;
    private Date transactionTimestamp;
    private TransactionType transactionType;
    private double transactionAmount;
    private String transactionSender;
    private String transactionReceiver;
    private String transactionDescription;
    private String transactionStatus;
    private Currency transactionCurrency;
    private double transactionFee;

    public Transaction(String transactionID, Date transactionTimestamp, TransactionType transactionType,
            double transactionAmount, String transactionSender, String transactionReceiver,
            String transactionDescription, String transactionStatus, Currency transactionCurrency,
            double transactionFee) {
        this.transactionID = transactionID;
        this.transactionTimestamp = transactionTimestamp;
        this.transactionType = transactionType;
        this.transactionAmount = transactionAmount;
        this.transactionSender = transactionSender;
        this.transactionReceiver = transactionReceiver;
        this.transactionDescription = transactionDescription;
        this.transactionStatus = transactionStatus;
        this.transactionCurrency = transactionCurrency;
        this.transactionFee = transactionFee;
    }

}
