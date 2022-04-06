package numa.Portals;

import java.sql.Timestamp;
import java.util.ArrayList;

public class Lease {
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
			"Rent: $%d\n",
			street_name, apt, city, state, zip, start_date, term_length, rent_amount
		);
		return outStr;
	}

	public String toString(ArrayList<Amenity> amenities) {
		String outStr = this.toString();
		outStr += "Amenities:\n";
		for (Amenity prop: amenities) {
			outStr += prop.toString();
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
			" - %s: $%d\n",
			amenity, cost
		);
		return outStr;
	}
}