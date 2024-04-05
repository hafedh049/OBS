package Account;

import com.mysql.cj.xdevapi.DbDoc;

public class SavingsAccount extends BankAccount {
	private double interestRate;
	private double minimumBalance;
	private double withdrawalLimit;

	public double getInterestRate() {
		return interestRate;
	}

	public void setInterestRate(double interestRate) {
		this.interestRate = interestRate;
	}

	public double getMinimumBalance() {
		return minimumBalance;
	}

	public void setMinimumBalance(double minimumBalance) {
		this.minimumBalance = minimumBalance;
	}

	public double getWithdrawalLimit() {
		return withdrawalLimit;
	}

	public void setWithdrawalLimit(int withdrawalLimit) {
		this.withdrawalLimit = withdrawalLimit;
	}

	public SavingsAccount(DbDoc json) {
		super(json);
		this.interestRate = Double.parseDouble(json.get("interestrate").toString());
		this.minimumBalance = Double.parseDouble(json.get("minimumbalance").toString());
		this.withdrawalLimit = Double.parseDouble(json.get("withdrawlimit").toString());
	}

}
