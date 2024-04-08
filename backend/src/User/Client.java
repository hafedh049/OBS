package User;

import com.mysql.cj.xdevapi.DbDoc;

import Account.CurrentAccount;
import Account.SavingsAccount;
import Database.DatabaseHelper;
import Transaction.Transaction;

public class Client extends User {
        public Client(DbDoc json) {
                super(json);
        }

        final public static void addAccount(CurrentAccount account) throws Exception {
                DatabaseHelper.statement
                                .execute(String.format(
                                                "INSERT INTO ACCOUNTS VALUES('%s','%s','%s','%s',%.2f,'CURRENT','%s',%.2f,%.2f,NULL,NULL,NULL,'%s');",
                                                account.getAccountBankID(),
                                                account.getAccountHolderID(),
                                                account.getAccountNumber(),
                                                account.getAccountHolderName(),
                                                account.getBalance(),
                                                account.getIsActive(),
                                                account.getOverdraftLimit(),
                                                account.getMaxTransLimit(),
                                                account.getCreateAt().toString()));
        }

        final public static void updateAccount(CurrentAccount account) throws Exception {
                DatabaseHelper.statement
                                .execute(String.format("UPDATE ACCOUNTS SET" +
                                                "ACCOUNTHOLDERNAME='%s'," +
                                                "BALANCE=%.2f," +
                                                "ACCOUNTTYPE='%s'," +
                                                "ISACTIVE='%s'," +
                                                "OVERDRAFTLIMIT=%.2f," +
                                                "MAXTRANSLIMIT=%.2f," +
                                                "WHERE ACCOUNTNUMBER = '%s';",
                                                account.getAccountHolderName(), account.getBalance(),
                                                account.getAccountType(), account.getIsActive(),
                                                account.getOverdraftLimit(),
                                                account.getMaxTransLimit()));
        }

        final public static void addAccount(SavingsAccount account) throws Exception {
                DatabaseHelper.statement
                                .execute(String.format(
                                                "INSERT INTO ACCOUNTS VALUES('%s','%s','%s','%s',%.2f,'SAVINGS','%s',NULL,NULL,%.2f,%.2f,%.2f,'%s');",
                                                account.getAccountBankID(),
                                                account.getAccountHolderID(),
                                                account.getAccountNumber(),
                                                account.getAccountHolderName(),
                                                account.getBalance(),
                                                account.getIsActive(),
                                                account.getInterestRate(),
                                                account.getMinimumBalance(),
                                                account.getWithdrawalLimit(),
                                                account.getCreateAt().toString()));
        }

        final public static void updateAccount(SavingsAccount account) throws Exception {
                DatabaseHelper.statement
                                .execute(String.format("UPDATE ACCOUNTS SET" +
                                                "ACCOUNTHOLDERNAME='%s'," +
                                                "BALANCE=%.2f," +
                                                "ACCOUNTTYPE='%s'," +
                                                "ISACTIVE='%s'," +
                                                "INTERESTRATE=%.2f," +
                                                "MINIMUMBALANCE=%.2f," +
                                                "WITHDRAWLIMIT = %.2f WHERE ACCOUNTNUMBER = '%s';",
                                                account.getAccountHolderName(), account.getBalance(),
                                                account.getAccountType(), account.getIsActive(),
                                                account.getInterestRate(),
                                                account.getMinimumBalance(),
                                                account.getWithdrawalLimit()));
        }

        final public static void removeAccount(String accountID) throws Exception {
                DatabaseHelper.statement
                                .execute(String.format(
                                                "DELETE FROM ACCOUNTS WHERE ACCOUNTNUMBER = '%s';", accountID));
        }

        public static void deposit(Transaction trans) throws Exception {
                DatabaseHelper.statement.execute(
                                "INSERT INTO TRANSACTIONS (transactionid, senderid, receivedid, currencyfrom, currencyto, amount, timestamp, description, status) VALUES ('%s', '%s', '%s', '%s', '%s', %.2f, '%s', '%s', '%s');"
                                                .formatted(trans.getTransactionID(), trans.getFrom(), trans.getTo(),
                                                                trans.getCurrencyFrom(),
                                                                trans.getTo(),
                                                                trans.getAmount(), trans.getTransactionDate(),
                                                                trans.getDescription(),
                                                                trans.getTransactionState()));
        }

        public static void withdraw(Transaction trans) throws Exception {
                DatabaseHelper.statement.execute(
                                "INSERT INTO TRANSACTIONS (transactionid, senderid, receivedid, currencyfrom, currencyto, amount, timestamp, description, status) VALUES ('%s', '%s', 'WITHDRAW', 'WITHDRAW', '%s', %.2f, '%s', '%s', 'CONFIRMED');"
                                                .formatted(trans.getTransactionID(), trans.getFrom(),
                                                                trans.getCurrencyFrom(),
                                                                trans.getAmount(), trans.getTransactionDate(),
                                                                trans.getDescription()));
        }

}