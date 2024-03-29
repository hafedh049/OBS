package Bank;

import java.util.UUID;

import Database.DatabaseHelper;

public class Bank {
	private final String bankID;
	private final String bankName;
	private final String bankAddress;
	private final int bankBranches;
	private final int bankCustomers;

	public Bank(String name, String address, int branches, int customers) {
		this.bankID = UUID.randomUUID().toString();
		this.bankName = name;
		this.bankAddress = address;
		this.bankBranches = branches;
		this.bankCustomers = customers;
	}

	public void addBank() throws Exception {
		DatabaseHelper.statement
				.execute(String.format("INSERT INTO BANKS VALUES('%d','%s','%s','%d','%d')",
						bankID, bankName, bankAddress,
						bankBranches, bankCustomers));
	}

	public void removeBank() throws Exception {
		DatabaseHelper.statement
				.execute(
						String.format(
								"DELETE FROM BANKS WHERE UPPER(BANKNAME) = UPPER('%s') AND UPPER(BANKADDRESS) = UPPER('%s')",
								bankName, bankAddress));
	}
}
