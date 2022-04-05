package numa.Portals;
import java.io.IOException;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.SQLException;

import numa.Reader;
import numa.Exceptions.*;

public class Payment {
	Connection conn;
	Reader input;
	int resId;

	public Payment(Connection conn, Reader input, int resId) throws NumberFormatException, IOException, ExitException, MenuException {
		this.conn = conn;
		this.input = input;
		this.resId = resId;

		System.out.println("Payment Methods Accepted:\n");
		System.out.println("[1] Bank ACH Transfer");
		System.out.println("[2] Credit Card");
		System.out.println("[3] Debit Card");
		System.out.println("[4] Venmo [NEW]");
		
		// Makes sure choice is in [1,4]
		int choice = -1;
		while (!(choice >= 1 && choice <= 4)) {
			System.out.print("New Payment Method [1-4]: ");
			try {
				choice = input.getMenuInt();
			} catch (NumberFormatException e) {
				System.out.println("Please try again");
			}
		}

		try {
			switch(choice) {
				case 1: addACH();
				case 2:	addCard(false);
				case 3: addCard(true);
				case 4: addVenmo();
				default:
			}
		}
		catch (SQLException e) {
			System.out.println("Error adding payment: " + e);
			return;
		}

		System.out.println("Payment Method Accepted!");
	}

	public void addACH() throws IOException, ExitException, SQLException {
		System.out.println("Bank ACH Information:\n");
		System.out.print("Bank Name: ");
		String bank = input.getPrompt();
		System.out.print("Account Number: ");
		String acct_num = input.getPrompt();
		System.out.print("Routing Number: ");
		String rout_num = input.getPrompt();

		try (
			CallableStatement add = this.conn.prepareCall("{call add_ach(?, ?, ?, ?)}");
		) {
			add.setInt(1, resId);
			add.setString(2, acct_num);
			add.setString(3, rout_num);
			add.setString(4, bank);

			add.execute();
		}
	}

	public void addCard(Boolean debit) throws IOException, ExitException, SQLException {
		if (debit) System.out.println("Debit Card Information"); else System.out.println("Credit Card Information");
		System.out.print("Cardholder First Name: ");
		String first_name = input.getPrompt();
		System.out.print("Cardholder Last Name: ");
		String last_name = input.getPrompt();
		System.out.print("Card Number: ");
		String card_num = input.getPrompt();
		System.out.print("Expiration Date (MM/YYYY): ");
		String exp_date = input.getPrompt();
		System.out.print("CVV: ");
		String cvv = input.getPrompt();

		// Debit specific
		String pin = null;
		if (debit) {
			System.out.print("PIN #: ");
			pin = input.getPrompt();

			try (
				CallableStatement add = this.conn.prepareCall("{call add_card(?, ?, ?, ?, ?, ?, ?)}");
			) {
				add.setInt(1, resId);
				add.setString(2, first_name);
				add.setString(3, last_name);
				add.setString(4, card_num);
				add.setString(5, exp_date);
				add.setString(6, cvv);
				add.setString(7, pin);

				add.execute();
			}
		}

		// Credit specific
		try (
			CallableStatement add = this.conn.prepareCall("{call add_card(?, ?, ?, ?, ?, ?)}");
		) {
			add.setInt(1, resId);
			add.setString(2, first_name);
			add.setString(3, last_name);
			add.setString(4, card_num);
			add.setString(5, exp_date);
			add.setString(6, cvv);

			add.execute();
		}
	}

	public void addVenmo() throws IOException, ExitException, SQLException {
		System.out.print("Venmo Handle (Include the '@'): ");
		String handle = input.getPrompt();

		try (
			CallableStatement add = this.conn.prepareCall("{call add_venmo(?, ?)}");
		) {
			add.setInt(1, resId);
			add.setString(2, handle);

			add.execute();
		}
	}
}