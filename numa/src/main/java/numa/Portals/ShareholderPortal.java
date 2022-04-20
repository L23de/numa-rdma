// package numa;
package numa.Portals;

import java.io.IOException;
import java.sql.Connection;
import numa.Reader;
import numa.Exceptions.*;

// May not need or copy over code from ManagementPortal
public class ShareholderPortal extends Portal {
	public ShareholderPortal(Connection conn, Reader input) throws IOException, ExitException, MenuException {
		System.out.println("------------------");
		System.out.println("Shareholder Portal");
		System.out.println("------------------\n");
		
		System.out.println("[1] Overview");
		System.out.println("[2] ");
		System.out.println("[3] ");
		int mainChoice = super.portal(input, 3);
		
		switch (mainChoice) {
			case 1: break;
			case 2: break;
			case 3: break;
		}

		super.sessionReset(input);
	}
}
