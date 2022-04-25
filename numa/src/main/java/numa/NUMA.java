package numa;

import java.sql.SQLException;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;

import io.github.cdimascio.dotenv.Dotenv;
import numa.Portals.*;
import numa.Exceptions.*;

public class NUMA {
	final static boolean DEV = true;

	public static void main (String[] args) {
		boolean connected = false;

		try (
			Reader input = new Reader();
		) {
			// Re-prompts whenever user is not connected
			do {
				String[] loginInfo = new String[2];
				Dotenv dotenv = Dotenv.load();
				String DB_URL = dotenv.get("DB_URL");

				if (DEV) {
					loginInfo[0] = dotenv.get("USERNAME");
					loginInfo[1] = dotenv.get("PASSWORD");
				} else {
					loginInfo = getLogin(input);
				}

				try (
					Connection conn = DriverManager.getConnection(DB_URL, loginInfo[0], loginInfo[1]);
				) {
					conn.setAutoCommit(false);
					connected = true;

					while (connected) {
						try {
							System.out.println("============================================");
							System.out.println("Northside Uncommons Management of Apartments");
							System.out.println("============================================");
							System.out.println("Enter 'm' to return here and 'q' to quit the program at any time\n");
							System.out.println("[1] Resident Portal");
							System.out.println("[2] Management Portal");
							System.out.println();

							boolean portalEntered = false;

							while (!portalEntered) {
								try {
									String portalChoice = input.getMenuLine("Portal #: ");

									switch (portalChoice) {
										case "1":
											new ResidentPortal(conn, input);
											portalEntered = true;
											break;
										// case "2":
										// 	new ManagementPortal(conn, input);
										// 	portalEntered = true;
										// 	break;
										default:
											System.out.println("Invalid input, please only enter numbers 1 - 2\n");
									}
								} 
								finally {}
							}

							System.out.println("Returning to the main menu...\n");
						}
						catch (SQLException e) {
							System.out.println("SQL Exception: " + e);
							System.out.println("Returning to the main menu...\n");
						}
						catch (TooManyTriesException e) {
							System.out.println(e.getMessage());
						}
						catch (MenuException e) {
							System.out.println(e.getMessage());
						}
					}
				}
				catch (SQLException e) {
					if (e.getErrorCode() == 1017) {
						System.out.println("Login denied. Please try again\n");
					} else {
						System.out.println("Failed to connect to the database. Please try again at a later time");
						throw new ExitException();
					}
				}

			} while (!connected);

		} 
		catch (IOException e) {
			System.out.println("IO Exception: " + e);
		}
		catch (ExitException e) {
			System.out.println("Exiting...");
		}
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
		System.out.println();
		return new String[]{id, passwd};
	}
}