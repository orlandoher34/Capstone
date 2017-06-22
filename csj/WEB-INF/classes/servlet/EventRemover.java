/**
This java servlet is what is called from the Admin page to remove a meeting. 
*/

package servlet;

import beans.CalendarHandler;
import beans.CalendarHandler.ReservationRecord;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


@WebServlet(name = "EventRemover", urlPatterns = {"/EventRemover"})
public class EventRemover extends HttpServlet {
	
//Sets the MySQL connection and driver variable information for the insert/removal process.	
    
    private static final String DB_DRIVER = "com.mysql.jdbc.Driver";
        private static final String DB_CONNECTION = "jdbc:mysql://localhost:3306/CITIZEN";
	private static final String DB_USER = "dbadmin";
	private static final String DB_PASSWORD = "db123";
        private static boolean tableCreated = false;
		
//This provides the response to the Admin.jsp call to this servlet		

        protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String task = request.getParameter("task");
        PrintWriter out = response.getWriter();
            System.out.println("Task:" + task);
        try {
            out.println(CalendarHandler.getEvents());
        } finally {
            out.close();
        }
        CalendarHandler.removeTask(task);
    }	
	
    protected void processPOSTRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }
	
	// This handles the get request 
			
	  @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

	// This handles the post request 
	
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processPOSTRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }

	// This calls the deleteRecordFromTable method
	
	public static void main(String[] argv) {

                
		try {
                   
                    deleteRecordFromTable();

		} catch (Exception e) {

			System.out.println(e.getMessage());

		}

	}
	
	// This is what deletes the data from the MySQL reservation table by executing the deleterecord statement
        
	private static void deleteRecordFromTable() throws SQLException {

		Connection dbConnection = null;
		PreparedStatement preparedStatement = null;
                

		String deleteTableSQL = "DELETE RESERVATION WHERE TASK = ?";

		try {
			dbConnection = getDBConnection();
			preparedStatement = dbConnection.prepareStatement(deleteTableSQL);
			preparedStatement.setInt(1, 1001);

			preparedStatement.executeUpdate();

			System.out.println("Record has been deleted");

		} catch (SQLException e) {

			System.out.println(e.getMessage());

		} finally {

			if (preparedStatement != null) {
				preparedStatement.close();
			}

			if (dbConnection != null) {
				dbConnection.close();
			}

		}

	}

		// Sets the connection
	
	private static Connection getDBConnection() {

		Connection dbConnection = null;

		try {

			Class.forName(DB_DRIVER);

		} catch (ClassNotFoundException e) {

			System.out.println(e.getMessage());

		}

		try {

			dbConnection = DriverManager.getConnection(
                            DB_CONNECTION, DB_USER,DB_PASSWORD);
			return dbConnection;

		} catch (SQLException e) {

			System.out.println(e.getMessage());

		}

		return dbConnection;

	}

}