package User;

import com.mysql.cj.xdevapi.DbDoc;

import Account.CurrentAccount;
import Account.SavingsAccount;
import Database.DatabaseHelper;

public class Client extends User {
        public Client(DbDoc json) {
                super(json);
        }

        final public static void addAccount(CurrentAccount account) throws Exception {
                DatabaseHelper.statement
                                .execute(String.format(
                                                "INSERT INTO ACCOUNTS VALUES('%s','%s','%s','%s','%.2f','%s','%s','%.2f','%.2',NULL,NULL,NULL);",
                                                account.getAccountBankID(),
                                                account.getAccountHolderID(),
                                                account.getAccountNumber(),
                                                account.getAccountHolderName(),
                                                account.getBalance(),
                                                account.getAccountType(),
                                                account.getIsActive(),
                                                account.getOverdraftLimit(),
                                                account.getMaxTransLimit()));
        }

        final public static void updateAccount(CurrentAccount account) throws Exception {
                DatabaseHelper.statement
                                .execute(String.format("UPDATE ACCOUNTS SET" +
                                                "ACCOUNTHOLDERNAME='%s'," +
                                                "BALANCE='%.2f'," +
                                                "ACCOUNTTYPE='%s'," +
                                                "ISACTIVE='%s'," +
                                                "OVERDRAFTLIMIT='%.2f'," +
                                                "MAXTRANSLIMIT='%.2f'," +
                                                "WHERE ACCOUNTNUMBER = %s;",
                                                account.getAccountHolderName(), account.getBalance(),
                                                account.getAccountType(), account.getIsActive(),
                                                account.getOverdraftLimit(),
                                                account.getMaxTransLimit()));
        }

        final public static void addAccount(SavingsAccount account) throws Exception {
                DatabaseHelper.statement
                                .execute(String.format(
                                                "INSERT INTO ACCOUNTS VALUES('%s','%s','%s','%s','%.2f','%s','%s',NULL,NULL,'%.2f','%.2f','%.2f');",
                                                account.getAccountBankID(),
                                                account.getAccountHolderID(),
                                                account.getAccountNumber(),
                                                account.getAccountHolderName(),
                                                account.getBalance(),
                                                account.getAccountType(),
                                                account.getIsActive(),
                                                account.getInterestRate(),
                                                account.getMinimumBalance(),
                                                account.getWithdrawalLimit()));
        }

        final public void updateAccount(SavingsAccount account) throws Exception {
                DatabaseHelper.statement
                                .execute(String.format("UPDATE ACCOUNTS SET" +
                                                "ACCOUNTHOLDERNAME='%s'," +
                                                "BALANCE='%.2f'," +
                                                "ACCOUNTTYPE='%s'," +
                                                "ISACTIVE='%s'," +
                                                "INTERESTRATE='%.2f'," +
                                                "MINIMUMBALANCE='%.2f'," +
                                                "WITHDRAWLIMIT = %.2f WHERE ACCOUNTNUMBER = %s;",
                                                account.getAccountHolderName(), account.getBalance(),
                                                account.getAccountType(), account.getIsActive(),
                                                account.getInterestRate(),
                                                account.getMinimumBalance(),
                                                account.getWithdrawalLimit()));
        }

        final public void removeAccount(String accountID) throws Exception {
                DatabaseHelper.statement
                                .execute(String.format(
                                                "DELETE FROM ACCOUNTS WHERE ACCOUNTNUMBER = '%s';", accountID));
        }

}