package User;

import com.mysql.cj.xdevapi.DbDoc;

import Database.DatabaseHelper;
import Transaction.Transaction;

public class Agent extends User {

    public Agent(DbDoc json) {
        super(json);
    }

    public void updateTransactionState(Transaction transaction) throws Exception {
        DatabaseHelper.statement
                .execute(String.format("UPDATE TRANSACTIONS SET STATE='%s' WHERE TRANSACTIONID = '%s';",
                        transaction.getTransactionState(), transaction.getTransactionID()));

    }

}
