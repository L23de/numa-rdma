package numa.Portals;

import java.sql.Timestamp;
import java.text.DecimalFormat;
import java.text.DecimalFormatSymbols;
import java.util.Locale;

class Lease {
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
			street_name, apt, city, state, zip, start_date, term_length, rent_amount
		);
		return outStr;
	}
}

class Property {
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

class Apartment {
	String apt;
	int square_footage;
	int bed_count;
	float bath_count;
	int rent;

	DecimalFormat df = new DecimalFormat("#.#", new DecimalFormatSymbols(Locale.US));

	public Apartment(String apt, int square_footage, int bed_count, float bath_count, int rent) {
		this.apt = apt;
		this.square_footage = square_footage;
		this.bed_count = bed_count;
		this.bath_count = bath_count;
		this.rent = rent;
	}

	public String toString(Boolean detail) {
		String outStr = String.format(
			"Apartment: %s\n",
			apt
		);
		if (detail) {
			outStr += String.format(
				"Square Footage: %d ft\n" +
				"Beds: %d\n" +
				"Baths: %f\n" +
				"Rent: %d",
				square_footage, bed_count, df.format(bath_count), rent
			);
		}
		return outStr;
	}
}

class Amenity {
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