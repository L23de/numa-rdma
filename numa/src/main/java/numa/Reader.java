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
	int MAX_TRIES = 5;

	public Reader() {
		super(new InputStreamReader(System.in));
	}

	/** 
	 * Used for menu input (Navigating between portals and subportals) 
	 * Allows for immediate quitting and main menu jump
	 */ 
	public String getMenuLine(String prompt) throws IOException, ExitException, MenuException {
		System.out.print(prompt);
		String input = super.readLine().toLowerCase();
		System.out.println();
		if (input.equals("q") || input.equals("'q'")) {
			throw new ExitException();
		}
		else if (input.equals("m") || input.equals("'m'")) {
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
		return input;
	}

	/** Used for non-menu inputs that allows for input validation */
	public String getPrompt(String prompt, Validate validation) throws IOException, ExitException, MenuException {
		int i = 0;
		while (i++ < MAX_TRIES) {
			System.out.print(prompt);
			String input = super.readLine();
			System.out.println();
			Validated res = validation.validate(input);
			if (res.valid) {
				return res.validated;
			}
			System.out.println(res.errMsg);
		}
		System.out.println("Too many attempts. Returning to the main menu...");
		throw new MenuException();
	}
}
