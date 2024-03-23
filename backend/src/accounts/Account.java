package accounts;

import enums.Currency;

public abstract class Account {
    protected String accountNumber;
    protected String accountBankID;
    protected String accountType;
    protected double accountBalance;
    protected String accountOwner;
    protected String accountStatus;
    protected double accountOverdraftLimit;
    protected Currency accountCurrency;

    public Account(String accountNumber, String accountType, double accountBalance, String accountOwner,
            String accountStatus, double accountOverdraftLimit, Currency accountCurrency, String accountBankID) {
        this.accountNumber = accountNumber;
        this.accountType = accountType;
        this.accountBalance = accountBalance;
        this.accountOwner = accountOwner;
        this.accountStatus = accountStatus;
        this.accountOverdraftLimit = accountOverdraftLimit;
        this.accountCurrency = accountCurrency;
        this.accountBankID = accountBankID;
    }

}