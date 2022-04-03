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

	// Used for menu input (Navigating between portals and subportals)
	public String getMenuLine() throws IOException, ExitException, MenuException {
		String input = super.readLine().toLowerCase();
		if (input.equals("q") || input.equals("'q'")) {
			throw new ExitException();
		}
		else if (input.equals("m") || input.equals("'m'")) {
			throw new MenuException();
		}
		return input;
	}

	// Used for menu input with integer values
	public int getMenuInt() throws IOException, ExitException, MenuException, NumberFormatException {
		String input = this.getMenuLine();
		try {
			return Integer.parseInt(input);
		} catch (NumberFormatException e) {
			throw new NumberFormatException();
		}
	}

	// Same as getMenuInt() but allows custom error message
	public int getMenuInt(String errMsg) throws IOException, ExitException, MenuException {
		String input = this.getMenuLine();
		try {
			return Integer.parseInt(input);
		} 
		catch (NumberFormatException e) {
			System.out.println(errMsg + "\n");
		}
		return -1;
	}

	// Used for non-menu inputs
	public String getPrompt() throws IOException, ExitException {
		String input = super.readLine();
		if (input.equals("q") || input.equals("'q'")) {
			throw new ExitException();
		}
		return input;
	}

	// Used for non-menu inputs that allows validation
	public String getPrompt(Validate validation) throws IOException, ExitException {
		while (true) {
			String input = super.readLine();
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
}
