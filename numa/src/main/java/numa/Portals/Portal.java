package numa.Portals;

import java.io.IOException;

import numa.Reader;
import numa.Exceptions.*;

public class Portal {
	/**
	 * Standard interface for all the portals
	 * @return Integer of the user input's choice
	 */
	public int portal(Reader input, int maxOpts) throws IOException, ExitException, MenuException {
		int choice = -1;
		while (choice == -1) {
			System.out.print("\nSelect an option [1-" + maxOpts + "]: ");
			try {
				choice = input.getMenuInt();
				// Makes sure choice is within bounds
				if (!(choice >= 1 && choice <= maxOpts)) {
					choice = -1;
					System.out.println("Please try again");
				}
			} finally {}
		}
		return choice;
	}
}
