package Bank;

import Database.DatabaseHelper;
import Exceptions.MaxBalance;
import Exceptions.MaxWithdraw;

public class SavingsAccount extends BankAccount {
	float rate = .05f;
	double maxWithLimit;

	public SavingsAccount(String accountHolderName, double balance, String accountType, String accountBankID,
			String accountHolderID,
			boolean isActive, double maxWithLimit) {
		super(accountHolderName, balance, accountType, accountBankID,
				accountHolderID, isActive);
		this.maxWithLimit = maxWithLimit;
	}

	public double getNetBalance() {
		double netBalance = balance + balance * rate;
		return netBalance;
	}

	@Override
	public void withdraw(double amount) throws MaxWithdraw, MaxBalance, Exception {
		if (amount < maxWithLimit)
			super.withdraw(amount);
		else
			throw new MaxWithdraw("Maximum Withdraw Limit Exceed");
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
								maxWithLimit, null));
	}
}
