package numa;

import java.sql.DriverManager;
import java.util.ArrayList;
import java.util.List;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.io.IOException;
import java.sql.Connection;

public class NUMA {
	final static String DB_URL = "jdbc:oracle:thin:@edgar1.cse.lehigh.edu:1521:cse241";

	public static void main (String[] args) throws IOException {
		boolean connected = false;

		do {
			try {
				Reader input = new Reader();
				String[] loginInfo = getLogin(input);

				// Try logging in and creating a prepared statement
				try (
					Connection conn = DriverManager.getConnection(DB_URL, loginInfo[0], loginInfo[1]); 
					PreparedStatement query = conn.prepareStatement("select capacity, count(id) as count from takes natural join (select * from section natural join classroom) where year=? and semester=? and course_id=? and sec_id=? group by capacity");
					Statement getYearOpts = conn.createStatement();
					) {
					connected = true;
					System.out.println("Connected\n");
					
					// Fetch all valid year options so it's cached (Year list is small enough)
					ResultSet yearOptsRes = getYearOpts.executeQuery("select distinct year from section");
					List<String> yearOpts = new ArrayList<String>();
					while (yearOptsRes.next()) {
						yearOpts.add(yearOptsRes.getString(1));
					}
					yearOptsRes.close();

					// Verify and get parameters of the query from the user
					Parameters params = new Parameters();

					// Will refetch parameters if user inputs bad parameters instead of exiting
					while (true) {
						try {
							params.getParams(conn, input, yearOpts);
							break;
						} catch (BadParamException e) {
							System.out.println(e.getMessage());
						}
					}

					input.close(); // Close Reader object (No more input is needed)

					query.setInt(1, params.year);
					query.setString(2, params.sem);
					query.setInt(3, params.courseId);
					query.setInt(4, params.secId);

					// Should only have one occurrence
					ResultSet res = query.executeQuery();
					int[] capacityCount = new int[2];
						// capacityCount[0] = Capacity of classroom
						// capacityCount[1] = Enrollment of section
					while (res.next()) {
						capacityCount[0] = res.getInt(1);
						capacityCount[1] = res.getInt(2);
					}
					res.close();

					System.out.printf("Capacity is %d | Enrollment is %d\n", capacityCount[0], capacityCount[1]);

					int difference = capacityCount[0] - capacityCount[1];
					if (difference == 0) {
						System.out.printf("There are no open seats\n");
					} else if (difference > 0) {
						System.out.printf("There are %d open seat(s)\n", difference);
					} else {
						System.out.printf("There are %d students without seats\n", Math.abs(difference));
					}
				}
				catch (SQLException e) {
					// Specific exception for bad user/pass combo
					if (e.getErrorCode() == 1017) {
						System.out.println("Login denied. Please try again\n");
					} else {
						System.out.println("SQLException: " + e);
					}
				}
				catch (IOException e) {
					System.out.println("IOException: " + e);
				} catch (ExitException e) {
					System.out.println("\nExiting...");
				}

			} catch (IOException e) {
				System.out.println("IOException: " + e);
			}
		} while (!connected);
	}

	/** 
	 * Returns user login information
	 * @return User ID and password
	 */
	public static String[] getLogin(Reader reader) throws IOException {
		System.out.print("Enter Oracle User ID: ");
		String id = reader.readLine();
		System.out.print("Enter Oracle Password: ");
		String passwd = reader.readLine();
		return new String[]{id, passwd};
	}
}