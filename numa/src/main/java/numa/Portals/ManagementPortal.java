package numa.Portals;

import java.io.IOException;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;
import java.sql.Types;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;

import numa.Reader;
import numa.Exceptions.*;

public class ManagementPortal extends Portal {
	final String BOLD_ON = "\033[1m";
	final String BOLD_OFF = "\033[0m";

	Reader input;
	Connection conn;

	public ManagementPortal(Connection conn, Reader input) throws IOException, ExitException, MenuException, SQLException, TooManyTriesException {
		this.input = input;
		this.conn = conn;

		System.out.println("-----------------");
		System.out.println("Management Portal");
		System.out.println("-----------------\n");

		// Get management login
		if (!getManagerLogin()) {
			return;
		}
		
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

	private Boolean getManagerLogin() throws SQLException, IOException, ExitException, MenuException, TooManyTriesException {
		try (
			PreparedStatement checkPIN = conn.prepareStatement("select * from admin where pin = ?");
		) {
			int pin = input.getMenuInt("Manager PIN: ");
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

	private void properties() throws SQLException, IOException, ExitException, MenuException {
		try (
			Statement getProp = conn.createStatement();
		) {
			ResultSet propRes = getProp.executeQuery("select * from property");
			ArrayList<Property> props = new ArrayList<Property>();

			String outStr = "";
			int counter = 0;

			while (propRes.next()) {
				int id = propRes.getInt("id");
				String street = propRes.getString("street_name");
				String city = propRes.getString("city");
				String state = propRes.getString("state");
				String zip = propRes.getString("zipcode");

				Property tmp = new Property(id, street, city, state, zip);
				props.add(tmp);
				outStr += String.format(
					"[%d] %s\n",
					++counter, tmp.toString() 
				);
			}

			if (outStr == "") {
				String choice = input.getMenuLine("No Properties in NUMA yet. Would you like to add one? [y/n]: ");
				switch(choice) {
					case "y": 
						// TODO: Bulk apartment add
					case "n": throw new MenuException();
					default: throw new MenuException("Invalid Option");
				}

			} else {
				System.out.println(BOLD_ON + "Properties:" + BOLD_OFF);
				System.out.println(outStr);
				
				while(true) {

					String prompt = String.format(
						"View apartments under a property [1-%s], 'a' to add a property, 'm' to menu or 'q' to quit: ", 
						counter
					);
					String action = input.getPrompt(prompt).toLowerCase().replaceAll("\\s+","");

					try (
						PreparedStatement getApts = conn.prepareStatement("select * from apartment where prop_id = ?");
					) {
						int propId = Integer.parseInt(action);
						getApts.setInt(1, propId);
						ResultSet aptRes = getApts.executeQuery();
						ArrayList<Apartment> aptList = new ArrayList<Apartment>();

						
						System.out.format(
							"%s%s Apartments:%s\n",
							BOLD_ON,
							props.get(counter - 1).toString(),
							BOLD_OFF
						);
							
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
							prompt = String.format(
								"View apartment details [1-%d], 'a' to add apartments, 'm' to menu or 'q' to quit: ",
								counter
							);
							try {
								String choice = input.getPrompt(prompt);
								aptIndex = Integer.parseInt(choice);
								if (aptIndex > 0 && aptIndex <= counter) {
									// Show apt specific info
									System.out.println(aptList.get(aptIndex - 1).toString());
									break;
								} else {
									System.out.println("Invalid input. Try again\n");
								}
							} catch (NumberFormatException e) {
								switch (action) {
									case "m": throw new MenuException();
									case "q": throw new ExitException();
									default: 
										System.out.println("Invalid input. Try again\n");
								}
							}
						}
						System.out.println();
						break;

					} catch (NumberFormatException e ) {
						switch (action) {
							// "a": // Bulk add properties
							case "m": throw new MenuException();
							case "q": throw new ExitException();
							default: 
							System.out.println("Invalid input. Try again\n");
						}
						}
				}
			}
		}
	}

	private void people() throws IOException, ExitException, MenuException, SQLException, TooManyTriesException {
		System.out.println("Search by:");
		System.out.println("[1] Name");
		System.out.println("[2] ID");
		int choice = -1;
		while (choice == -1) {
			choice = input.getMenuInt("Option [1-2]: ");
			if (choice == 1 || choice == 2) break;
		}

		switch (choice) {
			case 1: Person.searchName(conn, input, true); break;
			case 2: Person.searchId(conn, input); break;
		}
	}

	private void lease() throws IOException, ExitException, SQLException, MenuException, TooManyTriesException {
		System.out.println("[1] New Lease Registration");
		System.out.println("[2] Modify Existing Lease Term");
		System.out.println();

		int choice = -1;
		while (choice == -1) {
			choice = input.getMenuInt("Option [1-2]: ");
			if (choice == 1 || choice == 2) break;
		}

		switch (choice) {
			case 1: leaseReg(); break;
			case 2: modifyTerm(); break;
		}
	}

	private void modifyTerm() throws IOException, ExitException, MenuException, TooManyTriesException, SQLException {
		System.out.println("Modify Term Length:");
		System.out.println();
		boolean valid = false;

		while (!valid) {
			try (
				PreparedStatement getLeaseBasics = conn.prepareStatement("select street_name, apt, city, state, zipcode, start_date, ADD_MONTHS(start_date, term_length) as end_date, term_length from lease join property on lease.prop_id = property.id where lease.id = ?");
				PreparedStatement modifyLength = conn.prepareStatement("UPDATE lease SET term_length = ? WHERE id = ?");
			) {
				int lid = input.getMenuInt("Lease ID: ");
				getLeaseBasics.setInt(1, lid);
				ResultSet leaseDetails = getLeaseBasics.executeQuery();

				if (leaseDetails.next()) {
					valid = true;
					String street = leaseDetails.getString("street_name");
					String apt = leaseDetails.getString("apt");
					String city = leaseDetails.getString("city");
					String state = leaseDetails.getString("state");
					String zip = leaseDetails.getString("zipcode");
					Timestamp start = leaseDetails.getTimestamp("start_date");
					Timestamp end = leaseDetails.getTimestamp("end_date");
					int length = leaseDetails.getInt("term_length");

					SimpleDateFormat dateFmt = new SimpleDateFormat("MM/dd/yyyy");
					int monthDiffNow = getMonths(start, new Date());

					System.out.format("Modify Lease %d:\n", lid);
					System.out.format("%s %s %s %s %s\n(%d Month Lease: %s - %s)", street, apt, city, state, zip, length, dateFmt.format(start), dateFmt.format(end));
					System.out.println();

					int change = input.getMenuInt("# of months to change to: ");
					while (change <= monthDiffNow) {
						System.out.println("Invalid input, # of months must be greater than " + monthDiffNow);
					}

					modifyLength.setInt(1, change);
					modifyLength.setInt(2, lid);
					modifyLength.execute();

					conn.commit();

					System.out.println("Successfully modified lease");
				} else {
					System.out.println("Invalid lease ID. Please try again");
				}
			}
		}
	}

	private void leaseReg() throws IOException, ExitException, SQLException, MenuException, TooManyTriesException {
		System.out.println("New Lease Registration:");
		System.out.println();
		String first = input.getPrompt("First Name: ");
		first = first.substring(0, 1) + first.substring(1);
		Person person = checkPersonExists(first, true);

		// If a new person needs to be registered in the database
		if (person.id == -1) {
			person = addPerson(first);
		}

		String ssn = input.getPrompt("Social Security Number (###-##-####): ");
		
		System.out.println("Lease Info: ");
		int propId = input.getMenuInt("Property ID: ");
		String apt = input.getPrompt("Apartment: ");
		int term_length = input.getMenuInt("Term Length: ");

		try (
			CallableStatement add = this.conn.prepareCall("{call sign_lease(?, ?, ?, ?, ?, ?)}");
		) {
			add.setInt(1, person.id);
			add.setInt(2, propId);
			add.setString(3, apt);
			add.setInt(4, term_length);
			add.setString(5, ssn);
			add.registerOutParameter(6, Types.INTEGER);

			
			add.execute();
			conn.commit();
			int ret = add.getInt(6);

			if (ret == -2) {
				System.out.format("Apt %s does not exist\n", apt);
				return;
			} else if (ret == -1) {
				System.out.format("Apt %s is already under another lease, registration failed\n", apt);
				return;
			}
		}

		System.out.format("Lease for Apt %s successfully signed to %s %s [PID: %d]\n", apt, person.first_name, person.last_name, person.id);
		System.out.println("Please inform the tenant to setup payment details EOD in the Resident Portal");
	}

	private void visits() throws IOException, SQLException, ExitException, MenuException, TooManyTriesException {
		System.out.println("New Visit Registration");
		System.out.println();
		String first = input.getPrompt("First Name: ");
		first = first.substring(0, 1) + first.substring(1);
		Person person = checkPersonExists(first, false);

		if (person.id == -1) {
			person = addPerson(first);
		}

		try (
			PreparedStatement registerVisit = conn.prepareStatement("INSERT into visited(person_id, date_visited, prop_id, apt) VALUES(?, CURRENT_TIMESTAMP, ?, ?)");
		) {
			int pid = input.getMenuInt("Property ID: ");
			String apt = input.getPrompt("Apartment: ");
			
			registerVisit.setInt(1, person.id);
			registerVisit.setInt(2, pid);
			registerVisit.setString(3, apt);

			registerVisit.execute();
			conn.commit();

			System.out.println("Successfully registered visit");
		} catch (SQLException e) {
			System.out.println(e);
			// System.out.println("Error registering visit. Person has been added to records. Please try registering the visit again");
		}
	}

	private Person addPerson(String firstName) throws SQLException, IOException, MenuException, ExitException, TooManyTriesException {
		try (
			PreparedStatement addPerson = conn.prepareStatement(
				"insert into person(first_name, last_name, age, phone_number, email, credit_score) values(?, ?, ?, ?, ?, ?)"
			);
			Statement getResId = conn.createStatement();
		) {
			String last = input.getPrompt("Last Name: ");
			last = last.substring(0, 1) + last.substring(1);
			int age = input.getMenuInt("Age: ");
			String phone_number = input.getPrompt("Phone Number (###-###-####): ");
			String email = input.getPrompt("Email: ");
			int credit_score = input.getMenuInt("Credit Score: ");
			Person person = new Person(-1, firstName, last, null, age, phone_number, email, credit_score);
			
			addPerson.setString(1, firstName);
			addPerson.setString(2, last);
			addPerson.setInt(3, age);
			addPerson.setString(4, phone_number);
			addPerson.setString(5, email);
			addPerson.setInt(6, credit_score);

			addPerson.execute();
			conn.commit();
			ResultSet res = getResId.executeQuery("select max(id) as id from person");
			if (res.next()) person.id = res.getInt("id");
			return person;
		}
	}

	private void changePIN() throws IOException, ExitException, MenuException, SQLException, TooManyTriesException {
		boolean accepted = false;
			while (!accepted) {
			int pin = input.getMenuInt("New PIN: ");
			int confirm = input.getMenuInt("Confirm new PIN: ");
			if (pin == confirm) {
				accepted = true;
				try (
					PreparedStatement update = conn.prepareStatement("update admin set pin = ?");
				) {
					update.setInt(1, pin);
					update.executeUpdate();
				}
			}
		}
		System.out.println("PIN Updated");
		conn.commit();
	}

	private Person checkPersonExists(String first_name, Boolean renter) throws SQLException, IOException, ExitException, MenuException, TooManyTriesException {
		try (
			PreparedStatement checkRenter = conn.prepareStatement(
				"select id, first_name, last_name, age, ssn, phone_number, email, credit_score from person left outer join renter_info on person.id = renter_info.person_id where person_id is null and first_name = ?"
			);

			PreparedStatement checkPerson = conn.prepareStatement("select id, first_name, last_name, age, ssn, phone_number, email, credit_score from person left outer join renter_info on person.id = renter_info.person_id where first_name = ?");
		) {

			ResultSet people = null;
			if (!renter) {
				checkPerson.setString(1, first_name);
				people = checkPerson.executeQuery();
			} else {
				checkRenter.setString(1, first_name);
				people = checkRenter.executeQuery();
			}

			ArrayList<Person> matchedPeople = new ArrayList<Person>();
			int counter = 0;

			String outStr = "";
			
			while (people.next()) {
				int id = people.getInt("id");
				String last_name = people.getString("last_name");
				int age = people.getInt("age");
				String ssn = people.getString("ssn");
				String phone_num = people.getString("phone_number");
				String email = people.getString("email");
				int credit_score = people.getInt("credit_score");

				Person tmp = new Person(id, first_name, last_name, ssn, age, phone_num, email, credit_score);
				matchedPeople.add(tmp);

				outStr += String.format(
					"[%d] %s %s [NUMA ID: %d, Age: %d]\n",
					++counter, first_name, last_name, id, age
				);
			}

			if (!outStr.equals("")) {
				System.out.format("People associated with NUMA with first name '%s':\n\n", first_name);
				System.out.println(outStr);
				System.out.println();
				int choice = input.getMenuInt("Input the associated option number to pre-fill registration data or enter '-1' to skip: ");
				if (choice == -1) return new Person(false);
				System.out.println();
				System.out.println("Data imported");
				return matchedPeople.get(choice - 1);
			}
		}
		return new Person(false);
	}
}
