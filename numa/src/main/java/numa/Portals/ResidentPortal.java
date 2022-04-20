package numa.Portals;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;
import java.util.ArrayList;

import numa.Reader;
import numa.Exceptions.*;

public class ResidentPortal extends Portal {
	final String BOLD_ON = "\033[1m";
	final String BOLD_OFF = "\033[0m";

	Reader input;
	Connection conn;
	int resId = -1;
	
	public ResidentPortal(Connection conn, Reader input) throws IOException, ExitException, MenuException, SQLException {
		this.input = input;
		this.conn = conn;
		
		try (
			PreparedStatement checkResident = conn.prepareStatement("select * from renter_info where person_id = ?");
		) {
			System.out.println("\n---------------");
			System.out.println("Resident Portal");
			System.out.println("---------------\n");

			// Get resident ID
			while (resId == -1) {
				resId = residentLogin();
			}

			checkResident.setInt(1, resId);
			ResultSet residentEntry = checkResident.executeQuery();

			if (!residentEntry.next()) {
				// Result Set is empty
				System.out.println("Resident " + resId + " is not a current resident. Please talk to NUMA for assistance");
				super.sessionReset(input);
			}
			
			System.out.println("[1] My Info");
			System.out.println("[2] Make Payment");
			System.out.println("[3] My Lease Details");
			System.out.println();
			int mainChoice = super.portal(input, 3);
			
			switch (mainChoice) {
				case 1: resInfo(); break;
				case 2: makePayment(); break;
				case 3: viewAptDetails(); break;
			}

			super.sessionReset(input);
		}
	}

	/** Check that the resident is in the portal and retrieve all information relevant to the resident or simply store the user ID */ 
	public int residentLogin() throws IOException, ExitException, MenuException {
		int resId = input.getMenuInt("Resident ID: ");
		return resId;
	}

	/** View person info and add payments */
	public void resInfo() throws SQLException, NumberFormatException, IOException, ExitException, MenuException {
		try (
			Statement getInfo = conn.createStatement();
			PreparedStatement getVenmo = conn.prepareStatement("select payment_method.id, handle from payment_method join venmo on venmo_id = venmo.id where person_id = ?");
			PreparedStatement getACH = conn.prepareStatement("select payment_method.id, bank_name, acct_num, routing_num from payment_method join ach on ach_id = ach.id where person_id = ?");
			PreparedStatement getCard = conn.prepareStatement("select payment_method.id, first_name, last_name, card_num, exp_date, cvv, pin from payment_method join pay_card on card_id = pay_card.id where person_id = ?");

		) {
			// resInfo should only have one entry, because of PK constraints and residentLogin() already checks that resId exists in the renter_info table
			ResultSet resInfo = getInfo.executeQuery(
				"select * from  renter_info join person on person.id = renter_info.person_id where id = " + resId
			);
			resInfo.next();
			String ssn = resInfo.getString("SSN");
			int preferred_payment = resInfo.getInt("preferred_payment");
			String first_name = resInfo.getString("first_name");
			String last_name = resInfo.getString("last_name");
			int age = resInfo.getInt("age");
			String phone_number = resInfo.getString("phone_number");
			String email = resInfo.getString("email");
			int credit_score = resInfo.getInt("credit_score");

			// Reformat SSN
			ssn = "***-**-" + ssn.substring(7);

			String infoOut = String.format(
				"Hi, %s %s!\n" + 
				"NUMA Resident ID: %d\n" +
				"SSN: %s\n" +
				"Age: %d\n" +
				"Phone Number: %s\n" +
				"Email: %s\n" +
				"Credit Score on File: %d\n",
				first_name, last_name, resId, ssn, age, phone_number, email, credit_score
			);

			// Also show payment info
			getVenmo.setInt(1, resId);
			getACH.setInt(1, resId);
			getCard.setInt(1, resId);

			ResultSet venmoInfo = getVenmo.executeQuery();
			ResultSet achInfo = getACH.executeQuery();
			ResultSet cardInfo = getCard.executeQuery();

			String venmoOut = "";
			String achOut = "";
			String cardOut = "";

			while (venmoInfo.next()) {
				int payment_id = venmoInfo.getInt("id");
				String handle = venmoInfo.getString("handle");
				Venmo acc = new Venmo(payment_id, handle);
				venmoOut += "- " + acc.toString();
				if (payment_id == preferred_payment) {
					venmoOut += "*";
				}
				venmoOut += "\n";
			}

			while (achInfo.next()) {
				int payment_id = achInfo.getInt("id");
				String bank = achInfo.getString("bank_name");
				String acct = achInfo.getString("acct_num");
				String rout = achInfo.getString("routing_num");
				ACH acc = new ACH(payment_id, acct, rout, bank);
				achOut += "- " + acc.toString();
				if (payment_id == preferred_payment) {
					achOut += "*";
				}
				achOut += "\n";
			}

			while (cardInfo.next()) {
				int payment_id = cardInfo.getInt("id");
				String first = cardInfo.getString("first_name");
				String last = cardInfo.getString("last_name");
				String card_num = cardInfo.getString("card_num");
				String exp = cardInfo.getString("exp_date");
				String cvv = cardInfo.getString("cvv");
				String pin = cardInfo.getString("pin");

				Card acc = new Card(payment_id, first, last, card_num, exp, cvv, pin);
				cardOut += "- " + acc.toString();
				if (payment_id == preferred_payment) {
					cardOut += "*";
				}
				cardOut += "\n";
			}

			System.out.println(infoOut);

			if (venmoOut != "") {
				System.out.println(BOLD_ON + "Venmo" + BOLD_OFF);
				System.out.println(venmoOut);
			}

			if (achOut != "") {
				System.out.println(BOLD_ON + "Bank ACH Transfers" + BOLD_OFF);
				System.out.println(achOut);
			}
			
			if (cardOut != "") {
				System.out.println(BOLD_ON + "Payment Cards" + BOLD_OFF);
				System.out.println(cardOut);
			}

			String yn = input.getPrompt("Do you need to add a new payment? [Y/n]: ");
			if (yn.equals("")) yn = "y";
			System.out.println();

			switch(yn.toLowerCase()) {
				case "y": new Payment(conn, input, resId); break;
				default: return;
			}
		}
	}

	/** Show all payments that need to be made and some details */ 
	public void makePayment() {
	}

	/** Read only of apartment details */ 
	public void viewAptDetails() throws SQLException {
		try (
			PreparedStatement getApts = conn.prepareStatement(
				"select prop_id, street_name, apt, city, state, zipcode, start_date, term_length, rent_amount from (person_on_lease join lease on person_on_lease.lease_id = lease.id) join property on prop_id = property.id where person_id = ?"
			);
			PreparedStatement getPropAmenities = conn.prepareStatement(
				"select amenity, cost from prop_amenity where prop_id = ?"
			);
			PreparedStatement getAptAmenities = conn.prepareStatement(
				"select amenity, cost from apt_amenity where prop_id = ? and apt = ?"
			);
		) {

			getApts.setInt(1, resId);
			ResultSet leased_apts = getApts.executeQuery();
			ArrayList<Lease> leased = new ArrayList<Lease>();
			
			while (leased_apts.next()) {
				int prop_id = leased_apts.getInt("prop_id");
				String street_name = leased_apts.getString("street_name");
				String apt = leased_apts.getString("apt");
				String city = leased_apts.getString("city");
				String state = leased_apts.getString("state");
				String zip = leased_apts.getString("zipcode");
				Timestamp start_date = leased_apts.getTimestamp("start_date");
				int term_length = leased_apts.getInt("term_length");
				int rent_amount = leased_apts.getInt("rent_amount");


				Lease newLease = new Lease(prop_id, street_name, apt, city, state, zip, start_date, term_length, rent_amount);
				leased.add(newLease);
			}

			for (Lease lease : leased) {
				System.out.println(lease.toString());

				// Get property amenities
				getPropAmenities.setInt(1, lease.prop_id);
				ResultSet propAmen = getPropAmenities.executeQuery();

				// Get apartment amenities
				getAptAmenities.setInt(1, lease.prop_id);
				getAptAmenities.setString(2, lease.apt);
				ResultSet aptAmen = getAptAmenities.executeQuery();
				
				boolean hasAmenities = true;
				System.out.println("Amenities:");

				while (propAmen.next()) {
					hasAmenities = true;
					String name = propAmen.getString("amenity");
					int cost = propAmen.getInt("cost");
					Amenity tmp = new Amenity(name, cost);
					System.out.println("- " + tmp.toString());
				}

				while (aptAmen.next()) {
					hasAmenities = true;
					String name = aptAmen.getString("amenity");
					int cost = aptAmen.getInt("cost");
					Amenity tmp = new Amenity(name, cost);
					System.out.println("- " + tmp.toString());
				}

				if (!hasAmenities) System.out.println("- None");
				System.out.println();
			}
		}
	}
}
