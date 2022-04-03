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
	Connection conn;
	
	public ResidentPortal(Connection conn, Reader input) throws IOException, ExitException, MenuException, SQLException {
		this.conn = conn;
		try (
			PreparedStatement checkResident = conn.prepareStatement("select * from renter_info where person_id = ?");
		) {
			System.out.println("---------------");
			System.out.println("Resident Portal");
			System.out.println("---------------\n");

			// Get resident ID
			int resId = -1;
			while (resId == -1) {
				resId = residentLogin(input);
			}

			checkResident.setInt(1, resId);
			ResultSet residentEntry = checkResident.executeQuery();
			if (!residentEntry.next()) {
				// Result Set is empty
				System.out.println("Resident " + resId + " is not a current resident. Please talk to NUMA for assistance");
				throw new MenuException();
			}

			// Retrieve resident-relevant data
			System.out.println("[1] My Info");
			System.out.println("[2] Make Payment");
			System.out.println("[3] View Apartment Details");
			System.out.println("[4] Modify Lease");
			int mainChoice = super.portal(input, 3);
			
			switch (mainChoice) {
				case 1: resInfo(); break;
				case 2: makePayment(); break;
				case 3: viewAptDetails(resId); break;
				case 4: modifyLease(); break;
			}
		}
	}

	// Check that the resident is in the portal and retrieve all information relevant to the resident or simply store the user ID
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

	// View person info and add payments
	public void resInfo() throws SQLException {
		try (
			Statement getInfo = conn.prepareStatement("");
		) {

		}

	}

	// Show all payments that need to be made and some details
	public void makePayment() {
	}

	// Read only of apartment details
	public void viewAptDetails(int resId) throws SQLException {
		try (
			Statement getApt = conn.prepareStatement("");
		) {

		}
	}

	// Actions to add/remove person/pet and extend lease
	public void modifyLease() {
	}
}
