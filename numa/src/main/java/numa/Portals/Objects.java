package numa.Portals;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.text.DecimalFormat;
import java.text.DecimalFormatSymbols;
import java.text.SimpleDateFormat;
import java.util.Locale;

import numa.Reader;
import numa.Exceptions.*;

interface Objects {
	final String BOLD_ON = "\033[1m";
	final String BOLD_OFF = "\033[0m";

	public String toString();
}

class Lease implements Objects {
	int prop_id;
	String street_name;
	String apt;
	String city;
	String state;
	String zip;
	Timestamp start_date;
	int term_length;
	int rent_amount;

	public Lease(int prop_id, String street_name, String apt, String city, String state, String zip, Timestamp start_date, int term_length, int rent_amount) {
		this.prop_id = prop_id;
		this.street_name = street_name;
		this.apt = apt;
		this.city = city;
		this.state = state;
		this.zip = zip;
		this.start_date = start_date;
		this.term_length = term_length;
		this.rent_amount = rent_amount;
	}

	public String toString() {
		String outStr = String.format(
			"Address:\n" +
			"%s\n" +
			"Apt %s\n" +
			"%s, %s %s\n" +
			"Lease Start: %s\n" +
			"Lease Term Length: %d\n" +
			"Rent: $%d",
			street_name, apt, city, state, zip, new SimpleDateFormat("MM/dd/yyyy").format(start_date), term_length, rent_amount
		);
		return outStr;
	}
}

class Property implements Objects {
	int prop_id;
	String street;
	String city;
	String state;
	String zip;

	public Property(int prop_id, String street, String city, String state, String zip) {
		this.prop_id = prop_id;
		this.street = street;
		this.city = city;
		this.state = state;
		this.zip = zip;
	}

	public String toString() {
		String outStr = String.format(
			"%s %s, %s, %s",
			street, city, state, zip
		);
		return outStr;
	}
}

class Apartment implements Objects {
	int prop_id;
	String apt;
	int square_footage;
	int bed_count;
	float bath_count;
	int rent;

	DecimalFormatSymbols otherSymbols = new DecimalFormatSymbols(Locale.US);
	// Define the maximum number of decimals (number of symbols #)
	DecimalFormat df = new DecimalFormat("#.#", otherSymbols);


	// DecimalFormat df = new DecimalFormat("#.#", new DecimalFormatSymbols(Locale.US));

	public Apartment(int prop_id, String apt, int square_footage, int bed_count, float bath_count, int rent) {
		this.prop_id = prop_id;
		this.apt = apt;
		this.square_footage = square_footage;
		this.bed_count = bed_count;
		this.bath_count = bath_count;
		this.rent = rent;
	}

	public String toString() {
		String outStr = String.format(
			"Apartment %s\n" +
			"Square Footage: %d ft\n" +
			"Beds: %d\n" +
			"Baths: %s\n" +
			"Rent: $%d",
			apt, square_footage, bed_count, df.format(bath_count), rent
		);
		return outStr;
	}
}

class Amenity implements Objects {
	String amenity;
	int cost;

	public Amenity(String amenity, int cost) {
		this.amenity = amenity;
		this.cost = cost;
	}

	public String toString() {
		String outStr = String.format(
			"%s: $%d",
			amenity, cost
		);
		return outStr;
	}
}


class Venmo implements Objects {
	int payment_id;
	String handle;

	public Venmo(int id, String handle) {
		this.payment_id = id;
		this.handle = handle;
	}

	public String toString() {
		String out = String.format(
			"Handle: %s",
			handle
		);
		return out;
	}
}

class ACH implements Objects {
	int payment_id;
	String acct_num;
	String rout_num;
	String bank_name;

	public ACH(int id, String acct_num, String rout_num, String bank_name) {
		this.payment_id = id;
		this.acct_num = acct_num;
		this.rout_num = rout_num;
		this.bank_name = bank_name;
	}

	public String toString() {
		String out = String.format(
			"%s\n" +
			"\tAccount Number: %s\n" +
			"\tRouting Number: %s",
			bank_name, acct_num, rout_num
		);
		return out;
	}
}

class Card implements Objects {
	int payment_id;
	String first_name;
	String last_name;
	String card_num;
	String exp_date;
	String cvv;
	String pin;
	Boolean isCredit;

	public Card(int id, String first_name, String last_name, String card_num, String exp_date, String cvv, String pin) {
		this.payment_id = id;
		this.first_name = first_name;
		this.last_name = last_name;
		this.card_num = card_num;
		this.exp_date = exp_date;
		this.cvv = cvv;
		this.pin = pin;

		isCredit = pin == null ? true : false;
	}

	public String toString() {
		String type = isCredit ? "Credit" : "Debit";
		String out = "";

		out += String.format(
			"%s Ending in %s\n" +
			"\tCardholder First Name: %s\n" +
			"\tCardholder Last Name: %s\n" +
			"\tExpiration Date: %s\n" +
			"\tCVV: %s",
			type, card_num.substring(15), first_name, last_name, exp_date, cvv
		);

		if (!isCredit) out += String.format("\n\tPIN: %s", pin);
		return out;
	}
}

class Person implements Objects {
	int id;
	String first_name;
	String last_name;
	String ssn;
	int age;
	String phone_num;
	String email;
	int credit_score;

	public Person(boolean valid) {
		this.id = -1;
	}

	public Person(int id, String first, String last, String ssn, int age, String phone_num, String email, int credit_score) {
		this.id = id;
		this.first_name = first;
		this.last_name = last;
		this.ssn = ssn;
		this.age = age;
		this.phone_num = phone_num;
		this.email = email;
		this.credit_score = credit_score;
	}

	public String toString() {
		String outStr = String.format(
			"%s%s %s%s\n" +
			"NUMA Resident ID: %d\n" +
			"SSN: %s\n" +
			"Age: %d\n" +
			"Phone Number: %s\n" +
			"Email: %s\n" +
			"Credit Score on File: %d",
			BOLD_ON, first_name, last_name, BOLD_OFF, id, ssn, age, phone_num, email, credit_score
		);
		return outStr;
	}

	public static void searchName(String prefix, Connection conn, Reader input, boolean verbose) throws SQLException, IOException, ExitException {
		prefix += "where first_name = ? or last_name = ?";
		try (
			PreparedStatement searchName = conn.prepareStatement(prefix);
		) {
			String name = input.getPrompt("First or Last Name: ");
			name = name.substring(0, 1).toUpperCase() + name.substring(1);
			System.out.println();
			searchName.setString(1, name);
			searchName.setString(2, name);

			ResultSet people = searchName.executeQuery();
			while (people.next()) {
				int id = people.getInt("id");
				String first = people.getString("first_name");
				String last = people.getString("last_name");
				String ssn = people.getString("ssn");
				int age = people.getInt("age");
				String phone_num = people.getString("phone_number");
				String email = people.getString("email");
				int credit_score = people.getInt("credit_score");
				String apt = people.getString("apt");

				Person tmp = new Person(id, first, last, ssn, age, phone_num, email, credit_score);

				System.out.println(tmp.toString());
				if (apt != null) {
					System.out.format("Apartment Leased: %s\n", apt);
				}
				System.out.println();
			}
		}
	}

	public static void searchId(String prefix, Connection conn, Reader input) throws IOException, ExitException, MenuException, SQLException, TooManyTriesException {
		prefix += "where person.id = ?";
		try (
			PreparedStatement searchName = conn.prepareStatement(prefix);
		) {
			int id = input.getMenuInt("Person ID: ");
			searchName.setInt(1, id);

			ResultSet people = searchName.executeQuery();
			while (people.next()) {
				String first = people.getString("first_name");
				String last = people.getString("last_name");
				String ssn = people.getString("ssn");
				int age = people.getInt("age");
				String phone_num = people.getString("phone_number");
				String email = people.getString("email");
				int credit_score = people.getInt("credit_score");
				String apt = people.getString("apt");

				Person tmp = new Person(id, first, last, ssn, age, phone_num, email, credit_score);

				System.out.println(tmp.toString());
				if (apt != null) {
					System.out.format("Apartment Leased: %s\n", apt);
				}
				System.out.println();
			}
		}
	}
}