package accounts;

import enums.Currency;

public class SavingsAccount extends Account {

    public SavingsAccount(String accountNumber, String accountType, double accountBalance, String accountOwner,
            String accountStatus, double accountOverdraftLimit, Currency accountCurrency, String accountBankID) {
        super(accountNumber, accountType, accountBalance, accountOwner, accountStatus, accountOverdraftLimit,
                accountCurrency, accountBankID);
    }
}
