package Account;

public class SavingsAccount extends BankAccount {
	private double interestRate;
	private double minimumBalance;
	private int withdrawalLimit;

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

	public int getWithdrawalLimit() {
		return withdrawalLimit;
	}

	public void setWithdrawalLimit(int withdrawalLimit) {
		this.withdrawalLimit = withdrawalLimit;
	}

	public SavingsAccount(String accountHolderName, double balance, String accountType, String accountBankID,
			String accountHolderID,
			boolean isActive, double maxWithLimit, double interestRate, double minimumBalance, int withdrawalLimit) {
		super(accountHolderName, balance, accountType, accountBankID,
				accountHolderID, isActive);
		this.interestRate = interestRate;
		this.minimumBalance = minimumBalance;
		this.withdrawalLimit = withdrawalLimit;
	}

}
