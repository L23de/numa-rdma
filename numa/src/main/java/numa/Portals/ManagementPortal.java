// package numa.Portals;

// import java.io.IOException;
// import java.lang.reflect.Array;
// import java.sql.CallableStatement;
// import java.sql.Connection;
// import java.sql.PreparedStatement;
// import java.sql.ResultSet;
// import java.sql.SQLException;
// import java.sql.Statement;
// import java.sql.Types;
// import java.util.ArrayList;

// import javax.naming.spi.DirStateFactory.Result;

// import numa.Reader;
// import numa.Exceptions.*;


// public class ManagementPortal extends Portal {
// 	final String BOLD_ON = "\033[1m";
// 	final String BOLD_OFF = "\033[0m";

// 	Reader input;
// 	Connection conn;

// 	public ManagementPortal(Connection conn, Reader input) throws IOException, ExitException, MenuException, SQLException {
// 		this.input = input;
// 		this.conn = conn;

// 		System.out.println("-----------------");
// 		System.out.println("Management Portal");
// 		System.out.println("-----------------\n");

// 		// Get management login
// 		// if (!getManagerLogin()) {
// 		// 	return;
// 		// }
		
// 		System.out.println("[1] Properties");
// 		System.out.println("[2] People");
// 		System.out.println("[3] Lease");
// 		System.out.println("[4] Visit Registration");
// 		System.out.println("[5] Change PIN");
// 		System.out.println();
// 		int mainChoice = super.portal(input, 5);

// 		switch (mainChoice) {
// 			case 1: properties(); break;
// 			case 2: people(); break;
// 			case 3: lease(); break;
// 			case 4: visits(); break;
// 			case 5: changePIN(); break;
// 		}
		
// 		super.sessionReset(input);
// 	}

// 	private Boolean getManagerLogin() throws SQLException, IOException, ExitException, MenuException {
// 		try (
// 			PreparedStatement checkPIN = conn.prepareStatement("select * from admin where pin = ?");
// 		) {
// 			int pin = input.getMenuInt("Manager PIN: ");
// 			System.out.println();

// 			checkPIN.setInt(1, pin);
// 			ResultSet dbPIN = checkPIN.executeQuery();
// 			if (dbPIN.next()) {
// 				return true;
// 			}

// 			System.out.println("Incorrect PIN");
// 			return false;
// 		}
// 	}

// 	private void properties() throws SQLException, IOException, ExitException, MenuException {
// 		try (
// 			Statement getProp = conn.createStatement();
// 		) {
// 			ResultSet propRes = getProp.executeQuery("select * from property");
// 			ArrayList<Property> props = new ArrayList<Property>();

// 			System.out.println(BOLD_ON + "Properties:" + BOLD_OFF);
// 			int counter = 0;

// 			while (propRes.next()) {
// 				int id = propRes.getInt("id");
// 				String street = propRes.getString("street_name");
// 				String city = propRes.getString("city");
// 				String state = propRes.getString("state");
// 				String zip = propRes.getString("zipcode");

// 				Property tmp = new Property(id, street, city, state, zip);
// 				props.add(tmp);
// 				System.out.format(
// 					"[%d] %s\n",
// 					++counter, tmp.toString() 
// 				);
// 			}
// 			System.out.println();


// 			int propId = -1;
// 			while (true) {
// 				String prompt = String.format(
// 					"View apartments under a property [1-%s], 'a' to add a property, 'm' to menu or 'q' to quit: ", 
// 					counter
// 				);
// 				propId = input.getAddPrompt(prompt);
// 				if (propId >= 0 && propId <= counter) {
// 					break;
// 				}
// 				System.out.println("Invalid input. Try again\n");
// 			}
// 			System.out.println();
				
// 			try (
// 				PreparedStatement getApts = conn.prepareStatement("select * from apartment where prop_id = ?");
// 			) {
// 				System.out.format(
// 					"%s%s Apartments:%s\n",
// 					BOLD_ON,
// 					props.get(counter - 1).toString(),
// 					BOLD_OFF
// 				);

// 				getApts.setInt(1, propId);
// 				ResultSet aptRes = getApts.executeQuery();
// 				ArrayList<Apartment> aptList = new ArrayList<Apartment>();

// 				counter = 0;

// 				while (aptRes.next()) {
// 					int prop_id = aptRes.getInt("prop_id");
// 					String apt = aptRes.getString("apt");
// 					int square_footage = aptRes.getInt("square_footage");
// 					int bed_count = aptRes.getInt("bed_count");
// 					float bath_count = aptRes.getFloat("bath_count");
// 					int rent = aptRes.getInt("rent");

// 					Apartment tmp = new Apartment(prop_id, apt, square_footage, bed_count, bath_count, rent);
// 					aptList.add(tmp);
// 					System.out.format(
// 						"[%d] %s\n",
// 						++counter, 
// 						aptList.get(counter - 1).apt
// 					);
// 				}
// 				System.out.println();

// 				int aptIndex = -1;
// 				while (true) {
// 					String prompt = String.format(
// 					"View apartment details [1-%d], 'a' to add apartments, 'm' to menu or 'q' to quit: ",
// 					counter
// 				);
// 					aptIndex = input.getAddPrompt(prompt);
// 					if (aptIndex >= 0 && aptIndex <= counter) {
// 						break;
// 					}
// 					System.out.println("Invalid input. Try again\n");
// 				}
// 				System.out.println();

// 				System.out.println(aptList.get(aptIndex - 1).toString());
// 				System.out.println();
// 			}


// 		}
// 	}

// 	private void people() throws IOException, ExitException, MenuException, SQLException {
// 		System.out.println("Search by:");
// 		System.out.println("[1] Name");
// 		System.out.println("[2] ID");
// 		int choice = -1;
// 		while (choice == -1) {
// 			choice = input.getMenuInt("Option [1-2]: ");
// 			if (choice == 1 || choice == 2) break;
// 		}

// 		String sqlPrefix = String.format(
// 			"select " +
// 			"person.id as id, first_name, last_name, ssn, age, phone_number, email, credit_score, apt " +
// 			"from " +
// 			"(((person left outer join renter_info on renter_info.person_id = person.id) " + 
// 			"natural left outer join person_on_lease) " +
// 			"left outer join lease on lease_id = lease.id)" + 
// 			"natural left outer join apartment "
// 		);

// 		switch (choice) {
// 			case 1: Person.searchName(sqlPrefix, conn, input, true); break;
// 			case 2: Person.searchId(sqlPrefix, conn, input); break;

// 		}
// 	}

// 	private void lease() throws IOException, ExitException, SQLException, MenuException {
// 		System.out.println("New Lease Registration:");
// 		System.out.println();
// 		String first = input.getPrompt("First Name: ");
// 		first = first.substring(0, 1) + first.substring(1);
// 		Person person = checkPersonExists(first);

// 		// If a new person needs to be registered in the database
// 		if (person.id == -1) {
// 			String last = input.getPrompt("Last Name: ");
// 			last = last.substring(0, 1) + last.substring(1);
// 			int age = input.getMenuInt("Age: ");
// 			String phone_number = input.getPrompt("Phone Number (###-###-####): ");
// 			String email = input.getPrompt("Email: ");
// 			int credit_score = input.getMenuInt("Credit Score: ");
			
// 			person = new Person(-1, first, last, null, age, phone_number, email, credit_score);
// 		}
// 		person.ssn = input.getPrompt("Social Security Number (###-##-####): ");
		
// 		if (person.id == -1) {
// 			try (
// 				PreparedStatement addPerson = conn.prepareStatement(
// 					"insert into person(first_name, last_name, age, phone_number, email, credit_score) values(?, ?, ?, ?, ?, ?)"
// 				);
// 				Statement getResId = conn.createStatement();
// 			) {
// 				addPerson.setString(1, person.first_name);
// 				addPerson.setString(2, person.last_name);
// 				addPerson.setInt(3, person.age);
// 				addPerson.setString(4, person.phone_num);
// 				addPerson.setString(5, person.email);
// 				addPerson.setInt(6, person.credit_score);
	
// 				addPerson.executeUpdate();
// 				ResultSet res = getResId.executeQuery("select max(id) as id from person");
// 				if (res.next()) person.id = res.getInt("id");
// 			}
// 		}
		
// 		System.out.println("Lease Info: ");
// 		int propId = input.getMenuInt("Property ID: ");
// 		String apt = input.getPrompt("Apartment: ");
// 		int term_length = input.getMenuInt("Term Length: ");

// 		try (
// 			CallableStatement add = this.conn.prepareCall("{call sign_lease(?, ?, ?, ?, ?, ?, ?)}");
// 		) {
// 			add.setInt(1, person.id);
// 			add.setInt(2, propId);
// 			add.setString(3, apt);
// 			add.setInt(4, term_length);
// 			add.registerOutParameter(5, Types.INTEGER);
// 			add.registerOutParameter(6, Types.INTEGER);
// 			add.registerOutParameter(7, Types.INTEGER);

			
// 			add.execute();
// 			System.out.println("executed");
// 			int ret = add.getInt(5);
// 			int amt = add.getInt(6);
// 			int valid = add.getInt(7);
// 			System.out.format("Ret: %d\nAmt: %d\nValid: %d\n", ret, amt, valid);

// 			if (ret == -2) {
// 				System.out.format("Apt %s does not exist\n", apt);
// 				return;
// 			} else if (ret == -1) {
// 				System.out.format("Apt %s is already under another lease, registration failed\n", apt);
// 				return;
// 			}
// 		}

// 		conn.commit();
// 		System.out.format("Lease for Apt %s successfully signed to %s %s\n", apt, person.first_name, person.last_name);
// 	}

// 	private void visits() {
		
// 	}

// 	private void changePIN() throws IOException, ExitException, MenuException, SQLException {
// 		boolean accepted = false;
// 			while (!accepted) {
// 			int pin = input.getMenuInt("New PIN: ");
// 			int confirm = input.getMenuInt("Confirm new PIN: ");
// 			if (pin == confirm) {
// 				accepted = true;
// 				try (
// 					PreparedStatement update = conn.prepareStatement("update admin set pin = ?");
// 				) {
// 					update.setInt(1, pin);
// 					update.executeUpdate();
// 				}
// 			}
// 		}
// 		System.out.println("PIN Updated");
// 		conn.commit();
// 	}

// 	private Person checkPersonExists(String first_name) throws SQLException, IOException, ExitException, MenuException {
// 		try (
// 			PreparedStatement checkFirst = conn.prepareStatement(
// 				"select id, first_name, last_name, age, ssn, phone_number, email, credit_score from person left outer join renter_info on person.id = renter_info.person_id where person_id is null and first_name = ?"
// 			);
// 		) {
// 			checkFirst.setString(1, first_name);
// 			ResultSet people = checkFirst.executeQuery();
// 			ArrayList<Person> matchedPeople = new ArrayList<Person>();
// 			int counter = 0;

// 			String outStr = "";
			
// 			while (people.next()) {
// 				int id = people.getInt("id");
// 				String last_name = people.getString("last_name");
// 				int age = people.getInt("age");
// 				String ssn = people.getString("ssn");
// 				String phone_num = people.getString("phone_number");
// 				String email = people.getString("email");
// 				int credit_score = people.getInt("credit_score");

// 				Person tmp = new Person(id, first_name, last_name, ssn, age, phone_num, email, credit_score);
// 				matchedPeople.add(tmp);

// 				outStr += String.format(
// 					"[%d] %s %s [NUMA ID: %d, Age: %d]\n",
// 					++counter, first_name, last_name, id, age
// 				);
// 			}

// 			if (!outStr.equals("")) {
// 				System.out.format("People associated with NUMA with first name '%s':\n\n", first_name);
// 				System.out.println(outStr);
// 				System.out.println();
// 				int choice = input.getMenuInt("Input the associated option number to pre-fill registration data or enter '-1' to skip: ");
// 				if (choice == -1) return new Person(false);
// 				System.out.println();
// 				System.out.println("Data imported");
// 				return matchedPeople.get(choice - 1);
// 			}
// 		}
// 		return new Person(false);
// 	}
// }
