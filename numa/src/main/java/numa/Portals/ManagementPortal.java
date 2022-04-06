package numa.Portals;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

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
		if (!getManagerLogin()) {
			return;
		}
		
		System.out.println("[1] Properties");
		System.out.println("[2] Tenants");
		System.out.println("[3] Lease");
		System.out.println("[4] Visit Registration");
		System.out.println("[5] Change PIN");
		int mainChoice = super.portal(input, 5);

		switch (mainChoice) {
			case 1: properties(); break;
			case 2: tenants(); break;
			case 3: lease(); break;
			case 4: visits(); break;
		}
		
		super.sessionReset(input);
	}

	public Boolean getManagerLogin() throws SQLException, NumberFormatException, IOException, ExitException, MenuException {
		try (
			PreparedStatement checkPIN = conn.prepareStatement("select * from admin where pin = ?");
		) {
			System.out.print("Manager PIN: ");
			int pin = input.getMenuInt();
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

	public void properties() {

	}

	public void tenants() {

	}

	public void lease() {

	}

	public void visits() {
		
	}
}
