package GUI;

import java.sql.ResultSet;

import Database.DatabaseHelper;

public class ForgetPassword {

    public static void resetPassword(String email, String newPassword) throws Exception {
        final ResultSet resultSet = DatabaseHelper.statement
                .executeQuery("SELECT * FROM USERS WHERE EMAIL = '" + email + "'");
        if (resultSet.next()) {
            DatabaseHelper.statement
                    .execute("UPDATE USERS SET PASSWORD = '" + newPassword + "' WHERE EMAIL = '" + email + "'");
            System.out.println("Mot de passe réinitialisé avec succès pour l'utilisateur avec l'email : " + email);
        } else {
            System.out.println("L'email spécifié n'existe pas dans la base de données.");
        }
    }
}
