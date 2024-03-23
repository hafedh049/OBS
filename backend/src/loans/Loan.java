package loans;

import java.util.Date;

import enums.LoanStatus;

public class Loan {
    private String loanID;
    private String loanBorrowerID;
    private double loanAmount;
    private int loanTerm;
    private Date loanStartDate;
    private Date loanEndDate;
    private LoanStatus loanStatus;

    public Loan(String loanID, String loanBorrowerID, double loanAmount, int loanTerm, Date loanStartDate,
            Date loanEndDate, LoanStatus loanStatus) {
        this.loanID = loanID;
        this.loanBorrowerID = loanBorrowerID;
        this.loanAmount = loanAmount;
        this.loanTerm = loanTerm;
        this.loanStartDate = loanStartDate;
        this.loanEndDate = loanEndDate;
        this.loanStatus = loanStatus;
    }
}
