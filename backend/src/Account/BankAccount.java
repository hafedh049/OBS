package Account;

import java.util.UUID;

import com.mysql.cj.xdevapi.DbDoc;

public class BankAccount {
	protected String accountBankID;
	protected String accountHolderID;
	protected String accountHolderName;
	protected String accountNumber;
	protected double balance;
	protected String accountType;
	protected String isActive;

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

	public void setActive(String isActive) {
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

	public String getIsActive() {
		return isActive;
	}

	public BankAccount(DbDoc json) {
		this.accountBankID = json.get("bankid").toString().replaceAll("\"", "");
		this.accountNumber = UUID.randomUUID().toString();
		this.accountHolderName = json.get("username").toString().replaceAll("\"", "");
		this.accountHolderID = json.get("userid").toString().replaceAll("\"", "");
		this.balance = Double.parseDouble(json.get("balance").toString());
		this.accountType = json.get("type").toString().replaceAll("\"", "");
		this.isActive = json.get("isactive").toString();
	}

}
