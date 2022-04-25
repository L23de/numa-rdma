package numa.Exceptions;

public class TooManyTriesException extends Exception {
	public TooManyTriesException() {
		super("Too many attempts. Returning to the main menu...");
	}
}
