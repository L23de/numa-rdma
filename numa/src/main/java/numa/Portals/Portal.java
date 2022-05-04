package numa.Portals;

import java.io.IOException;
import java.sql.SQLException;
import java.util.Date;
import java.util.Calendar;
import java.util.GregorianCalendar;

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

	public int getMonths(Date start, Date end) throws SQLException {
		Calendar startTime = new GregorianCalendar();
		Calendar endTime = new GregorianCalendar();

		startTime.setTime(start);
		endTime.setTime(end);

		int yearDiff = endTime.get(Calendar.YEAR) - startTime.get(Calendar.YEAR);
		int monthDiff = endTime.get(Calendar.MONTH) - startTime.get(Calendar.MONTH);

		return yearDiff * 12 + monthDiff;
	}
}
