package Account;

import com.mysql.cj.xdevapi.DbDoc;

public class CurrentAccount extends BankAccount {
	private double overdraftLimit;
	private double maxTransLimit;

	public double getOverdraftLimit() {
		return overdraftLimit;
	}

	public void setOverdraftLimit(double overdraftLimit) {
		this.overdraftLimit = overdraftLimit;
	}

	public double getMaxTransLimit() {
		return maxTransLimit;
	}

	public void setMaxTransLimit(double maxTransLimit) {
		this.maxTransLimit = maxTransLimit;
	}

	public CurrentAccount(DbDoc json) {
		super(json);
		this.overdraftLimit = Double.parseDouble(json.get("overdraftlimit").toString());
		this.maxTransLimit = Double.parseDouble(json.get("maxtranslimit").toString());
	}

}
