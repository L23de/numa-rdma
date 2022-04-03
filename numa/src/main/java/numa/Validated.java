package numa;

public class Validated {
	String validated;
	String errMsg;

	public Validated(String validated, String errMsg) {
		this.validated = validated;
		this.errMsg = errMsg;
	}
}

interface Validate {
	public Validated validate(String input);
}
