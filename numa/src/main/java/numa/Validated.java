package numa;

public class Validated {
	String validated;
	String errMsg;
	boolean valid;

	public Validated(String validated, String errMsg, boolean valid) {
		this.validated = validated;
		this.errMsg = errMsg;
		this.valid = valid;
	}
}

interface Validate {
	/**
	 * Validation function format
	 * Returns true on proper validation and false otherwise
	 * public boolean validateX();
	 */
	public Validated validate(String input);
}