package numa.Portals;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import numa.Reader;
import numa.Exceptions.*;

public class ResidentPortal extends Portal {
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
				resId = residentLogin(input);
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
			System.out.println("[3] View Apartment Details");
			System.out.println("[4] Modify Lease");
			int mainChoice = super.portal(input, 4);
			
			switch (mainChoice) {
				case 1: resInfo(); break;
				case 2: makePayment(); break;
				case 3: viewAptDetails(); break;
				case 4: modifyLease(); break;
			}

			super.sessionReset(input);
		}
	}

	/** Check that the resident is in the portal and retrieve all information relevant to the resident or simply store the user ID */ 
	public int residentLogin(Reader input) throws IOException, ExitException, MenuException {
		System.out.print("Resident ID: ");
		try {
			int resId = input.getMenuInt();
			return resId;
		} catch (NumberFormatException e) {
			System.out.println("Try again with a numeric value\n");
		}
		return -1;
	}

	/** View person info and add payments */
	public void resInfo() throws SQLException, NumberFormatException, IOException, ExitException, MenuException {
		try (
			Statement getInfo = conn.createStatement();
			Statement getPay = conn.createStatement();
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
				"Credit Score on File: %d\n"
				, first_name, last_name, resId, ssn, age, phone_number, email, credit_score
			);

			// Also show payment info
			// ResultSet payInfo = getPay.executeQuery(
			// 	"select "
			// );

			String payOut = String.format("");

			System.out.println(infoOut);
			System.out.println(payOut);

			System.out.print("Do you need to add a new payment? [Y/N]: ");
			String yn = input.getPrompt();

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
			Statement getApt = conn.prepareStatement("");
		) {

		}
	}

	/** Actions to add/remove person/pet and extend lease */ 
	public void modifyLease() {
	}
}
