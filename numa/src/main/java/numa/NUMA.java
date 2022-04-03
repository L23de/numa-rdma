package numa;

import java.sql.DriverManager;
import java.util.ArrayList;
import java.util.List;
import java.util.Scanner;

import io.github.cdimascio.dotenv.Dotenv;
import numa.Portals.*;
import numa.Exceptions.*;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.sql.Connection;
public class NUMA {
	final static boolean DEV = true;

	public static void main (String[] args) throws IOException {
		boolean connected = false;

		// Re-prompts whenever user is not connected
		do {
			try (
				Reader input = new Reader();
			) {
				String[] loginInfo = new String[2];
				Dotenv dotenv = Dotenv.load();
				String DB_URL = dotenv.get("DB_URL");
				if (DEV) {
					String USER = dotenv.get("USERNAME");
					String PASS = dotenv.get("PASSWORD");
					loginInfo[0] = USER;
					loginInfo[1] = PASS;
				} else {
					loginInfo = getLogin(input);
				}

				// Try logging in and creating a prepared statement
				try (
					Connection conn = DriverManager.getConnection(DB_URL, loginInfo[0], loginInfo[1]);
				) {
					connected = true;
					System.out.println("Connected\n");

					while (true) {
						System.out.println("============================================");
						System.out.println("Northside Uncommons Management of Apartments");
						System.out.println("============================================");
						System.out.println("Enter 'm' to return here and 'q' to quit the program at any time\n");
						System.out.println("[1] Resident Portal");
						System.out.println("[2] Management Portal");
						System.out.println("[3] Shareholder Disclosures\n");

						System.out.print("Portal #: ");
						try {
							String portalChoice = input.getMenuLine();
							System.out.println();
							
							switch(portalChoice) {
							case "1":
								new ResidentPortal(conn, input);
								break;
							case "2":
								new ManagementPortal(conn, input);
								break;
							case "3":
								new ShareholderPortal(conn, input);
								break;
							default:
								System.out.println("Invalid input, please only enter numbers 1 - 3\n");
							}

						}
						catch (MenuException e) {
							// Do nothing
						}
						System.out.println("Returning to the main menu...\n");
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
				} 
				catch (ExitException e) {
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