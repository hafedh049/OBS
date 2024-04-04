package Bank;

import java.util.UUID;

import com.mysql.cj.xdevapi.DbDoc;

public final class Bank {
	private final String bankID;
	private String bankName;
	private String bankAddress;

	public Bank(DbDoc json) {
		this.bankID = UUID.randomUUID().toString();
		this.bankName = json.get("bankname").toString().replaceAll("\"", "");
		this.bankAddress = json.get("bankaddress").toString().replaceAll("\"", "");
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
