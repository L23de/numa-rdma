package numa;

import java.io.IOException;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

/** Used to house parameters for the PreparedStatement */
public class Parameters {
	int year;
	String sem;
	int courseId;
	int secId;

	/** Default constructor */
	public Parameters() {}

	/** Used to retrieve parameters from the user */
	public void getParams(Connection conn, Reader reader, List<String> yearOpts) throws IOException, BadParamException, SQLException, ExitException {
		System.out.println("Input data on the section whose classroom capacity you wish to check (Enter 'q' at any time to quit)");
		System.out.print("Year (YYYY): ");
		int year = readYear(reader, yearOpts);
		System.out.print("Semester (String): ");
		String sem = readSemester(reader);
		System.out.print("Course ID (3-digit Integer): ");
		int courseId = readCourse(reader, conn, year, sem);
		System.out.print("Section ID (Integer): ");
		int secId = readSection(reader, conn, year, sem, courseId);

		this.year = year;
		this.sem = sem;
		this.courseId = courseId;
		this.secId = secId;
	}


	/* =========================
	 * Verification Algorithms
	 * ========================= */

	/**
	 * Verifies that the user input is a valid year in the YYYY format
	 * @return Integer form of the year
	 */
	int readYear(Reader reader, List<String> yearOpts) throws IOException, BadParamException, ExitException {
		String year = reader.getLine();
		if (year.length() != 4) {
			throw new BadParamException("Year not in YYYY format\n");
		}
		if (!yearOpts.contains(year)) {
			throw new BadParamException("Year not in database\n");
		}

		return Integer.valueOf(year);
	}

	/**
	 * Verifies that the user input is a valid semester
	 * @return User inputted year that abides by what the database has (Tolerates casing)
	 */
	String readSemester(Reader reader) throws IOException, BadParamException, ExitException {
		String sem = reader.getLine().toLowerCase();
		List<String> validOptions = new ArrayList<String>(4);
		validOptions.add("fall");
		validOptions.add("summer");
		validOptions.add("spring");
		validOptions.add("winter");

		if (!validOptions.contains(sem)) {
			throw new BadParamException("Please enter a valid option: Fall, Summer, Spring, Winter\n");
		}

		// Capitalize the first character
		sem = sem.substring(0, 1).toUpperCase() + sem.substring(1);
		return sem;
	}

	/**
	 * Verifies that the user input is a valid course ID in that particular semester
	 * @return Integer form of the course ID
	 */
	int readCourse(Reader reader, Connection conn, int year, String sem) throws IOException, BadParamException, SQLException, ExitException {
		String course = reader.getLine();
		if (course.length() != 3) {
			throw new BadParamException("Course ID should be a 3-digit number\n");
		}

		try {
			int courseId = Integer.valueOf(course);
			Statement checkCourse = conn.createStatement();
			String checkCourseQuery = String.format("select * from section where year=%d and semester='%s' and course_id=%d", year, sem, courseId);
			ResultSet checkCourseRes = checkCourse.executeQuery(checkCourseQuery);
			if (!checkCourseRes.next()) {
				String errorMsg = String.format("Course ID %d was not offered in the %s %d semester\n", courseId, sem, year);
				throw new BadParamException(errorMsg);
			}

			return courseId;

		} catch (NumberFormatException e) {
			throw new BadParamException("Course ID should only contain integers 0-9\n");
		}
	}

	/**
	 * Verifies that the user input is a valid section ID for the course in that particular semester
	 * @return Integer form of the section ID
	 */
	int readSection(Reader reader, Connection conn, int year, String sem, int courseId) throws IOException, BadParamException, SQLException, ExitException {
		String sec = reader.getLine();

		try {
			int secId = Integer.valueOf(sec);
			Statement checkSection = conn.createStatement();
			String checkSectionQuery = String.format("select * from section where year=%d and semester='%s' and course_id=%d and sec_id=%d", year, sem, courseId, secId);
			ResultSet checkSectionRes = checkSection.executeQuery(checkSectionQuery);
			if (!checkSectionRes.next()) {
				String errorMsg = String.format("Section %d did not exist for course with ID %d in the %s %d semester\n", secId, courseId, sem, year);
				throw new BadParamException(errorMsg);
			}

			return secId;

		} catch (NumberFormatException e) {
			throw new BadParamException("Section ID should only contain integers 0-9\n");
		}
	}

	/**
	 * Helper method to print out the parameters entered
	 */
	void printParameters() {
		System.out.printf("Year: %d\nSemester: %s\nCourse ID: %d\nSection ID: %d\n", year, sem, courseId, secId);
	}
}
