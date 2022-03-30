package numa;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;

/**
 * Enhanced version of Java's BufferedReader
 * Helps with parsing any special commands (like quitting) before normal execution
 */
public class Reader extends BufferedReader {
	public Reader() {
		super(new InputStreamReader(System.in));
	}

	public String getLine() throws IOException, ExitException {
		String input = super.readLine();
		if (input.equals("q") || input.equals("'q'")) {
			throw new ExitException();
		}
		return input;
	}
}
