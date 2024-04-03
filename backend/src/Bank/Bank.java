package Bank;

import java.util.UUID;

import Database.DatabaseHelper;

public class Bank {
	private final String bankID;
	private String bankName;
	private String bankAddress;

	public Bank(String name, String address, int branches, int customers) {
		this.bankID = UUID.randomUUID().toString();
		this.bankName = name;
		this.bankAddress = address;
	}

	public void addBank() throws Exception {
		DatabaseHelper.statement
				.execute(String.format("INSERT INTO BANKS VALUES('%s','%s','%s');",
						bankID, bankName, bankAddress));
	}

	public void updateBank() throws Exception {
		DatabaseHelper.statement
				.execute(String.format("UPDATE BANKS SET BANKNAME='%s',BANKADDRESS='%s';",
						bankName, bankAddress));
	}

	public void removeBank() throws Exception {
		DatabaseHelper.statement
				.execute(
						String.format(
								"DELETE FROM BANKS WHERE UPPER(BANKNAME) = UPPER('%s') AND UPPER(BANKADDRESS) = UPPER('%s');",
								bankName, bankAddress));
	}

	public void setBankName(String bankName) {
		this.bankName = bankName;
	}

	public void setBankAddress(String bankAddress) {
		this.bankAddress = bankAddress;
	}

	public String getBankID() {
		return bankID;
	}

	public String getBankName() {
		return bankName;
	}

	public String getBankAddress() {
		return bankAddress;
	}
}
