package Account;

public class CurrentAccount extends BankAccount {
	private double overdraftLimit;
	private int maxTransLimit;

	public double getOverdraftLimit() {
		return overdraftLimit;
	}

	public void setOverdraftLimit(double overdraftLimit) {
		this.overdraftLimit = overdraftLimit;
	}

	public int getMaxTransLimit() {
		return maxTransLimit;
	}

	public void setMaxTransLimit(int maxTransLimit) {
		this.maxTransLimit = maxTransLimit;
	}

	public CurrentAccount(String accountHolderName, double balance, String accountType,
			String openedDate, boolean isActive, String tradeLicenseNumber, String accountBankID,
			String accountHolderID, double overdraftLimit, int maxTransLimit) throws Exception {
		super(accountHolderName, balance, accountType, accountBankID,
				accountHolderID, isActive);
		this.overdraftLimit = overdraftLimit;
		this.maxTransLimit = maxTransLimit;
	}

}
