package cards;

import java.time.LocalDate;

public class Card {
    private String cardNumber;
    private String cardType;
    private LocalDate cardexpirationDate;
    private String cardCVV;
    private String cardOwner;

    public Card(String cardNumber, String cardType, LocalDate expirationDate, String CVV, String owner) {
        this.cardNumber = cardNumber;
        this.cardType = cardType;
        this.cardexpirationDate = expirationDate;
        this.cardCVV = CVV;
        this.cardOwner = owner;
    }

    public void makePayment(double amount, String merchant) {
        // Logic to process a payment using this card
    }

    public void viewTransactions() {
        // Logic to retrieve and display transactions made with this card
    }

    public void reportLostCard() {
        // Logic to report the card as lost or stolen
    }
}
