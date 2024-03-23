package database_helpers;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;

public class DatabaseHelper {
    void load() {
        try {
            // Class.forName("com.mysql.cj.jdbc.Driver");
            final Connection con = DriverManager.getConnection(
                    "jdbc:mysql://localhost:3306/test", "root", "");
            Statement stmt = con.createStatement();
            ResultSet rs = stmt.executeQuery("select * from user_details;");
            while (rs.next())
                System.out.println(rs.getRow());
            con.close();
        } catch (Exception e) {
            System.out.println(e);
        }

    }
}
