package numa.Exceptions;

public class MenuException extends Exception {
	public MenuException() {
		super("Returning to the main menu...");
	}

	public MenuException(String string) {
		super(string + "\n\nReturning to the main menu...");
	}
}
