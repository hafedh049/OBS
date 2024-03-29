package Bank;

import Database.DatabaseHelper;

public class CurrentAccount extends BankAccount {

	public CurrentAccount(String accountHolderName, double balance, String accountType,
			String openedDate, boolean isActive, String tradeLicenseNumber, String accountBankID,
			String accountHolderID) throws Exception {
		super(accountHolderName, balance, accountType, accountBankID,
				accountHolderID, isActive);
		if (balance < 5000)
			throw new Exception("Insufficient Balance");
	}

	@Override
	public void addAccount() throws Exception {
		DatabaseHelper.statement
				.execute(
						String.format(
								"INSERT INTO ACCOUNTS(ACCOUNTNUMBER,ACCOUNTHOLDERID,ACCOUNTHOLDERNAME,ACCOUNTBANKID,ACCOUNTTYPE,"
										+ "BALANCE,ISACTIVE,TRADELICENSENUMBER,MAXWITHDRAWLIMIT,INSTITUTIONNAME)"
										+ " VALUES('%s','%s','%s','%s','%s','%s','%f','%b','%f','%s')",
								accountNumber,
								accountHolderID, accountHolderName, accountBankID, accountType, balance, isActive,
								null, null));
	}

}
