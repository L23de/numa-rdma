package numa.Portals;

import java.io.IOException;

import numa.Reader;
import numa.Exceptions.*;


public class Portal {
	/**
	 * Standard interface for all the portals
	 * @return Integer of the user input's choice
	 */
	public int portal(Reader input, int maxOpts) throws IOException, ExitException, MenuException, TooManyTriesException {
		int choice = -1;
		while (choice == -1) {
			choice = input.getMenuInt("Select an option [1-" + maxOpts + "]: ");
			// Makes sure choice is within bounds
			if (!(choice >= 1 && choice <= maxOpts)) {
				choice = -1;
				System.out.println("Please try again");
			}
		}
		System.out.println();
		return choice;
	}

	/** Performed at the end of a chain of prompt events */
	public void sessionReset(Reader input) throws IOException, ExitException, MenuException {
		while (true)
			input.getMenuLine("Enter 'm' to return to the main menu or 'q' to quit the program: ");
	}
}
