package Account;

import java.util.UUID;

public class BankAccount {
	protected String accountBankID;
	protected String accountHolderID;
	protected String accountHolderName;
	protected String accountNumber;
	protected double balance;
	protected String accountType;
	protected boolean isActive;

	public void setAccountBankID(String accountBankID) {
		this.accountBankID = accountBankID;
	}

	public void setAccountHolderID(String accountHolderID) {
		this.accountHolderID = accountHolderID;
	}

	public void setAccountHolderName(String accountHolderName) {
		this.accountHolderName = accountHolderName;
	}

	public void setAccountNumber(String accountNumber) {
		this.accountNumber = accountNumber;
	}

	public void setBalance(double balance) {
		this.balance = balance;
	}

	public void setAccountType(String accountType) {
		this.accountType = accountType;
	}

	public void setActive(boolean isActive) {
		this.isActive = isActive;
	}

	public String getAccountBankID() {
		return accountBankID;
	}

	public String getAccountHolderID() {
		return accountHolderID;
	}

	public String getAccountNumber() {
		return accountNumber;
	}

	public String getAccountHolderName() {
		return accountHolderName;
	}

	public double getBalance() {
		return balance;
	}

	public String getAccountType() {
		return accountType;
	}

	public boolean getIsActive() {
		return isActive;
	}

	public BankAccount(String accountHolderName, double balance, String accountType, String accountBankID,
			String accountHolderID,
			boolean isActive) {
		this.accountNumber = UUID.randomUUID().toString();
		this.accountHolderName = accountHolderName;
		this.balance = balance;
		this.accountType = accountType;
		this.isActive = isActive;
	}

}
