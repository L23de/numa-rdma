package numa;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;

import numa.Exceptions.*;

/**
 * Enhanced version of Java's BufferedReader
 * Reader with various parsing methods
 */
public class Reader extends BufferedReader {
	public Reader() {
		super(new InputStreamReader(System.in));
	}

	/** Used for menu input (Navigating between portals and subportals) */ 
	public String getMenuLine(String prompt) throws IOException, ExitException, MenuException {
		System.out.print(prompt);
		String input = super.readLine().toLowerCase();
		System.out.println();
		if (input.equals("q") || input.equals("'q'")) {
			System.out.println();
			throw new ExitException();
		}
		else if (input.equals("m") || input.equals("'m'")) {
			System.out.println();
			throw new MenuException();
		}
		return input;
	}

	/** Used for menu input with integer values */
	public int getMenuInt(String prompt) throws IOException, ExitException, MenuException {
		while (true) {
			String input = this.getMenuLine(prompt);
			System.out.println();
			try {
				return Integer.parseInt(input);
			} catch (NumberFormatException e) {
				System.out.println("Invalid input. Try again");
			}
		}
	}

	/** Used for non-menu inputs */
	public String getPrompt(String prompt) throws IOException, ExitException {
		System.out.print(prompt);
		String input = super.readLine();
		System.out.println();
		if (input.equals("q") || input.equals("'q'")) {
			throw new ExitException();
		}
		return input;
	}

	/** Used for non-menu inputs that allows validation */
	public String getPrompt(String prompt, Validate validation) throws IOException, ExitException {
		while (true) {
			System.out.print(prompt);
			String input = super.readLine();
			System.out.println();
			if (input.equals("q") || input.equals("'q'")) {
				throw new ExitException();
			}
			Validated res = validation.validate(input);
			if (res.errMsg.equals("")) {
				return input;
			}
			System.out.println(res.errMsg + "\n");
		}
	}

	/** Used for multi-action prompts that allow adding to the database */
	public int getAddPrompt(String prompt) throws IOException, ExitException, MenuException {
		String input = this.getMenuLine(prompt);
		if (input.equals("a") || input.equals("'a'")) {
			return 0;
		}
		try {
			return Integer.parseInt(input);
		} catch (NumberFormatException e) {
			throw new NumberFormatException();
		}
	}
}
