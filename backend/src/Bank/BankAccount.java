package Bank;

import java.util.UUID;

import Database.DatabaseHelper;
import Exceptions.MaxBalance;
import Exceptions.MaxWithdraw;

public abstract class BankAccount {
	protected String accountBankID;
	protected String accountHolderID;
	protected String accountNumber;
	protected String accountHolderName;
	protected double balance;
	protected double min_balance;
	protected String accountType;
	protected boolean isActive;

	public BankAccount(String accountHolderName, double balance, String accountType, String accountBankID,
			String accountHolderID,
			boolean isActive) {
		this.accountNumber = UUID.randomUUID().toString();
		this.accountHolderName = accountHolderName;
		this.balance = balance;
		this.accountType = accountType;
		this.isActive = isActive;
		this.min_balance = 10D;
	}

	public void deposit(double ammount) throws Exception {
		DatabaseHelper.statement
				.execute("UPDATE ACCOUNTS SET BALANCE =" + (balance + ammount) + ";");
	}

	public void withdraw(double ammount) throws MaxWithdraw, MaxBalance, Exception {
		if ((balance - ammount) >= min_balance && ammount < balance) {
			DatabaseHelper.statement
					.execute("UPDATE ACCOUNTS SET BALANCE =" + (balance - ammount) + ";");

		} else
			throw new MaxBalance("Insufficient Balance");
	}

	public abstract void addAccount() throws Exception;
}
