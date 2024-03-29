package Bank;

import Database.DatabaseHelper;

public class StudentAccount extends SavingsAccount {
	String institutionName;

	public StudentAccount(String accountHolderName, double balance, String accountType, String accountBankID,
			String accountHolderID,
			boolean isActive, String institutionName) {
		super(accountHolderName, balance, accountType, accountBankID,
				accountHolderID, isActive, 10000D);
		min_balance = 10D;
		this.institutionName = institutionName;
	}

	@Override
	public void addAccount() throws Exception {
		DatabaseHelper.statement
				.executeQuery(
						String.format(
								"INSERT INTO ACCOUNTS(ACCOUNTNUMBER,ACCOUNTHOLDERID,ACCOUNTHOLDERNAME,ACCOUNTBANKID,ACCOUNTTYPE,"
										+ "BALANCE,ISACTIVE,TRADELICENSENUMBER,MAXWITHDRAWLIMIT,INSTITUTIONNAME)"
										+ " VALUES('%s','%s','%s','%s','%s','%s','%f','%b','%f','%s')",
								accountNumber,
								accountHolderID, accountHolderName, accountBankID, accountType, balance, isActive,
								maxWithLimit, institutionName));
	}
}
