package numa.Exceptions;

/**
 * Custom exception for handling erroneous user-inputted parameters
 */
public class BadParamException extends Exception {
	public BadParamException(String err) {
		super(err);
	}
}
