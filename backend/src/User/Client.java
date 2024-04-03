package User;

import Account.CurrentAccount;
import Account.SavingsAccount;
import Database.DatabaseHelper;

public class Client extends User {
    public Client(String userID, String username, String password, String email) {
        super(userID, username, password, email, "CLIENT");
    }

    public void addAccount(CurrentAccount account) throws Exception {
        DatabaseHelper.statement
                .execute(String.format(
                        "INSERT INTO ACCOUNTS VALUES('%s','%s','%s','%s','%.2f','%s','%b','%.2f','%d','%.2f','%.2f','%d',);",
                        account.getAccountBankID(),
                        account.getAccountHolderID(),
                        account.getAccountNumber(),
                        account.getAccountHolderName(),
                        account.getBalance(),
                        account.getAccountType(),
                        account.getIsActive(),
                        account.getOverdraftLimit(),
                        account.getMaxTransLimit(),
                        null,
                        null,
                        null));
    }

    public void updateAccount(CurrentAccount account) throws Exception {
        DatabaseHelper.statement
                .execute(String.format("UPDATE ACCOUNTS SET" +
                        "ACCOUNTHOLDERNAME='%s'," +
                        "BALANCE='%.2f'," +
                        "ACCOUNTTYPE='%s'," +
                        "ISACTIVE='%b'," +
                        "OVERDRAFTLIMIT='%.2f'," +
                        "MAXTRANSLIMIT='%d'," +
                        "INTERESTRATE='%.2f'," +
                        "MINIMUMBALANCE='%.2f'," +
                        "WITHDRAWLIMIT WHERE ACCOUNTNUMBER = %s;", account.getAccountHolderName(), account.getBalance(),
                        account.getAccountType(), account.getIsActive(), account.getOverdraftLimit(),
                        account.getMaxTransLimit(), null, null, null));
    }

    public void addAccount(SavingsAccount account) throws Exception {
        DatabaseHelper.statement
                .execute(String.format(
                        "INSERT INTO ACCOUNTS VALUES('%s','%s','%s','%s','%.2f','%s','%b','%.2f','%d','%.2f','%.2f','%d',);",
                        account.getAccountBankID(),
                        account.getAccountHolderID(),
                        account.getAccountNumber(),
                        account.getAccountHolderName(),
                        account.getBalance(),
                        account.getAccountType(),
                        account.getIsActive(),
                        null,
                        null,
                        account.getInterestRate(),
                        account.getMinimumBalance(),
                        account.getWithdrawalLimit()));
    }

    public void updateAccount(SavingsAccount account) throws Exception {
        DatabaseHelper.statement
                .execute(String.format("UPDATE ACCOUNTS SET" +
                        "ACCOUNTHOLDERNAME='%s'," +
                        "BALANCE='%.2f'," +
                        "ACCOUNTTYPE='%s'," +
                        "ISACTIVE='%b'," +
                        "OVERDRAFTLIMIT='%.2f'," +
                        "MAXTRANSLIMIT='%d'," +
                        "INTERESTRATE='%.2f'," +
                        "MINIMUMBALANCE='%.2f'," +
                        "WITHDRAWLIMIT WHERE ACCOUNTNUMBER = %s;", account.getAccountHolderName(), account.getBalance(),
                        account.getAccountType(), account.getIsActive(), null,
                        null, account.getInterestRate(),
                        account.getMinimumBalance(),
                        account.getWithdrawalLimit()));
    }

    public void removeAccount(String accountID) throws Exception {
        DatabaseHelper.statement
                .execute(String.format(
                        "DELETE FROM BANKACCOUNTS WHERE ACCOUNTNUMBER = '%s';", accountID));
    }

}