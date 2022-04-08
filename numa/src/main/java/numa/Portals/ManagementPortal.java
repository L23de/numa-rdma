package numa.Portals;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import numa.Reader;
import numa.Exceptions.*;

public class ManagementPortal extends Portal {
	final String BOLD_ON = "\033[1m";
	final String BOLD_OFF = "\033[0m";

	Reader input;
	Connection conn;

	public ManagementPortal(Connection conn, Reader input) throws IOException, ExitException, MenuException, SQLException {
		this.input = input;
		this.conn = conn;

		System.out.println("-----------------");
		System.out.println("Management Portal");
		System.out.println("-----------------\n");

		// Get management login
		// if (!getManagerLogin()) {
		// 	return;
		// }
		
		System.out.println("[1] Properties");
		System.out.println("[2] People");
		System.out.println("[3] Lease");
		System.out.println("[4] Visit Registration");
		System.out.println("[5] Change PIN");
		System.out.println();
		int mainChoice = super.portal(input, 5);

		switch (mainChoice) {
			case 1: properties(); break;
			case 2: people(); break;
			case 3: lease(); break;
			case 4: visits(); break;
			case 5: changePIN(); break;
		}
		
		super.sessionReset(input);
	}

	private Boolean getManagerLogin() throws SQLException, NumberFormatException, IOException, ExitException, MenuException {
		try (
			PreparedStatement checkPIN = conn.prepareStatement("select * from admin where pin = ?");
		) {
			int pin = -1;
			while (pin == -1) {
				try {
					pin = input.getMenuInt("Manager PIN: ");
				} 
				catch (NumberFormatException e) {
					System.out.println("Invalid input. Please try again");
				}
			}
			System.out.println();

			checkPIN.setInt(1, pin);
			ResultSet dbPIN = checkPIN.executeQuery();
			if (dbPIN.next()) {
				return true;
			}

			System.out.println("Incorrect PIN");
			return false;
		}
	}

	private void properties() throws SQLException, NumberFormatException, IOException, ExitException, MenuException {
		try (
			Statement getProp = conn.createStatement();
		) {
			ResultSet propRes = getProp.executeQuery("select * from property");
			ArrayList<Property> props = new ArrayList<Property>();

			System.out.println(BOLD_ON + "Properties:" + BOLD_OFF);
			int counter = 0;

			while (propRes.next()) {
				int id = propRes.getInt("id");
				String street = propRes.getString("street_name");
				String city = propRes.getString("city");
				String state = propRes.getString("state");
				String zip = propRes.getString("zipcode");

				Property tmp = new Property(id, street, city, state, zip);
				props.add(tmp);
				System.out.format(
					"[%d] %s\n",
					++counter, tmp.toString() 
				);
			}
			System.out.println();


			int propId = -1;
			while (true) {
				System.out.format(
					"View apartments under a property [1-%s], 'a' to add a property, 'm' to menu or 'q' to quit: ", 
					counter
				);
				propId = input.getAddPrompt();
				if (propId >= 0 && propId <= counter) {
					break;
				}
				System.out.println("Invalid input. Try again\n");
			}
			System.out.println();
				
			try (
				PreparedStatement getApts = conn.prepareStatement("select * from apartment where prop_id = ?");
			) {
				System.out.format(
					"%s%s Apartments:%s\n",
					BOLD_ON,
					props.get(counter - 1).toString(),
					BOLD_OFF
				);

				getApts.setInt(1, propId);
				ResultSet aptRes = getApts.executeQuery();
				ArrayList<Apartment> aptList = new ArrayList<Apartment>();

				counter = 0;

				while (aptRes.next()) {
					int prop_id = aptRes.getInt("prop_id");
					String apt = aptRes.getString("apt");
					int square_footage = aptRes.getInt("square_footage");
					int bed_count = aptRes.getInt("bed_count");
					float bath_count = aptRes.getFloat("bath_count");
					int rent = aptRes.getInt("rent");

					Apartment tmp = new Apartment(prop_id, apt, square_footage, bed_count, bath_count, rent);
					aptList.add(tmp);
					System.out.format(
						"[%d] %s\n",
						++counter, 
						aptList.get(counter - 1).apt
					);
				}
				System.out.println();

				int aptIndex = -1;
				while (true) {
					System.out.format(
					"View apartment details [1-%d], 'a' to add apartments, 'm' to menu or 'q' to quit: ",
					counter
				);
					aptIndex = input.getAddPrompt();
					if (aptIndex >= 0 && aptIndex <= counter) {
						break;
					}
					System.out.println("Invalid input. Try again\n");
				}
				System.out.println();

				System.out.println(aptList.get(aptIndex - 1).toString());
				System.out.println();
			}


		}
	}

	private void people() throws NumberFormatException, IOException, ExitException, MenuException, SQLException {
		System.out.println("Search by:");
		System.out.println("[1] Name");
		System.out.println("[2] ID");
		int choice = -1;
		while (choice == -1) {
			try {
				choice = input.getMenuInt("Option [1-2]: ");
			} 
			catch (NumberFormatException e) {
				System.out.println("Invalid input. Please try again");
			}
			if (choice == 1 || choice == 2) break;
		}

		String sqlPrefix = String.format(
			"select " +
			"person.id as id, first_name, last_name, ssn, age, phone_number, email, credit_score, apt " +
			"from " +
			"(((person left outer join renter_info on renter_info.person_id = person.id) " + 
			"natural left outer join person_on_lease) " +
			"left outer join lease on lease_id = lease.id)" + 
			"natural left outer join apartment "
		);

		switch (choice) {
			case 1: Person.searchName(sqlPrefix, conn, input); break;
			case 2: Person.searchId(sqlPrefix, conn, input); break;

		}
	}

	private void lease() {

	}

	private void visits() {
		
	}

	private void changePIN() throws IOException, ExitException, MenuException, SQLException {
		boolean accepted = false;
		while (!accepted) {
			try {

				int pin = input.getMenuInt("New PIN: ");
				int confirm = input.getMenuInt("Confirm new PIN: ");
				if (pin == confirm) {
					accepted = true;
					try (
						PreparedStatement update = conn.prepareStatement("update admin set pin = ?");
						) {
							update.setInt(1, pin);
							update.executeQuery();
						}
					}
			} catch (NumberFormatException e) {
				System.out.println("Invalid input, only numeric values are allowed. Try again");
			}
		}
		System.out.println("PIN Updated");
		conn.commit();
	}
}
