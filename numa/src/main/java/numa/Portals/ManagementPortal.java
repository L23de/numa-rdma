package numa.Portals;

import java.io.IOException;
import java.sql.Connection;
import numa.Reader;
import numa.Exceptions.*;

public class ManagementPortal extends Portal {
	public ManagementPortal(Connection conn, Reader input) throws IOException, ExitException, MenuException {
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
		int mainChoice = super.portal(input, 4);

		switch (mainChoice) {
			case 1: properties(); break;
			case 2: tenants(); break;
			case 3: lease(); break;
			case 4: visits(); break;
		}
	}

	public Boolean getManagerLogin() {
		return true;
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
