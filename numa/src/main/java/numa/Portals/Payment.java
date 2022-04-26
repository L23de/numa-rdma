package numa.Portals;
import java.io.IOException;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.Types;
import java.sql.ResultSet;

import numa.Reader;
import numa.Exceptions.*;


public class Payment {
	Connection conn;
	Reader input;
	int resId;

	public Payment(Connection conn, Reader input, int resId) throws NumberFormatException, IOException, ExitException, MenuException, SQLException, TooManyTriesException {
		this.conn = conn;
		this.input = input;
		this.resId = resId;

		System.out.println("Payment Methods Accepted:\n");
		System.out.println("[1] Bank ACH Transfer");
		System.out.println("[2] Credit Card");
		System.out.println("[3] Debit Card");
		System.out.println("[4] Venmo [NEW]");
		System.out.println();
		
		// Makes sure choice is in [1,4]
		int choice = -1;
		while (!(choice >= 1 && choice <= 4)) {
			choice = input.getMenuInt("New Payment Method [1-4]: ");
		}

		try {
			switch(choice) {
				case 1: addACH(); break;
				case 2:	addCard(false); break;
				case 3: addCard(true); break;
				case 4: addVenmo(); break;
			}
			// Ask to set preferred, update procedures
			System.out.println();

			conn.commit();
		}
		catch (SQLException e) {
			System.out.println("Error adding payment: " + e);
			return;
		}
		System.out.println("Payment Method Accepted!");
	}

	public void addACH() throws IOException, ExitException, SQLException {
		System.out.println("Bank ACH Information:\n");
		String bank = input.getPrompt("Bank Name: ");
		String acct_num = input.getPrompt("Account Number [17]: ");
		String rout_num = input.getPrompt("Routing Number [9]: ");

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
		String first_name = input.getPrompt("Cardholder First Name: ");
		String last_name = input.getPrompt("Cardholder Last Name: ");
		String card_num = input.getPrompt("Card Number [19]: ");
		String exp_date = input.getPrompt("Expiration Date (MM/YYYY): ");
		String cvv = input.getPrompt("CVV [3]: ");

		// Debit specific
		try (
			CallableStatement add = this.conn.prepareCall("{call add_card(?, ?, ?, ?, ?, ?, ?)}");
		) {
			if (debit) {
				String pin;	
				pin = input.getPrompt("PIN # [4]: ");
				add.setString(7, pin);
			} else {
				add.setNull(7, Types.CHAR);
			}

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
		String handle = input.getPrompt("Venmo Handle (Include the '@'): ");

		try (
			CallableStatement add = this.conn.prepareCall("{call add_venmo(?, ?)}");
		) {
			add.setInt(1, resId);
			add.setString(2, handle);

			add.execute();
		}
	}

	// public static int getDefaultPayment(Connection conn, int resId) {
	// 	try (
	// 		PreparedStatement defaultPayment = conn.prepareStatement("select preferred_payment from renter_info where person_id = ?");
	// 	) {
	// 		defaultPayment.setInt(1, resId);
	// 		ResultSet res = defaultPayment.executeQuery();

	// 		int payId = -1;
	// 		if (res.next()) {
	// 			payId = res.getInt("preferred_payment");
	// 		}
	// 		return payId;
	// 	}
	// }
}
