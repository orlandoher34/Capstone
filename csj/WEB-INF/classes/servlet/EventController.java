/**
This java servlet is what is called from the Admin page and the read-only page.
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


@WebServlet(name = "EventController", urlPatterns = {"/EventController"})
public class EventController extends HttpServlet {

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
        PrintWriter out = response.getWriter();
        try {
            out.println(CalendarHandler.getEvents());
        } finally {
            out.close();
        }
    }
    
	//This gets the parameters from the Admin page to be inserted into the MySQL table 
	
    protected void processPOSTRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String task = request.getParameter("task");
        
        String startYear = request.getParameter("startYear");
        String startMonth = request.getParameter("startMonth");
        String startDay = request.getParameter("startDay");
        String startHour = request.getParameter("startHour");
        String startMinute = request.getParameter("startMinute");
        String startSecond = request.getParameter("startSecond");
        String start = CalendarHandler.formatTime(startYear, startMonth, 
                startDay, startHour, startMinute, startSecond);
        
        String endYear = request.getParameter("endYear");
        String endMonth = request.getParameter("endMonth");
        String endDay = request.getParameter("endDay");
        String endHour = request.getParameter("endHour");
        String endMinute = request.getParameter("endMinute");
        String endSecond = request.getParameter("endSecond");
        String end = CalendarHandler.formatTime(endYear, endMonth, 
                endDay, endHour, endMinute, endSecond);
        String roomNumber = request.getParameter("roomNumber");
        
        ReservationRecord record = new ReservationRecord(task, startYear, startMonth, startDay, startHour, startMinute, startSecond, 
                endYear, endMonth, endDay, endHour, endMinute, endSecond, roomNumber);
        
        try {
            insertRecordIntoTable(record);
        } catch (SQLException ex) {
            Logger.getLogger(EventController.class.getName()).log(Level.SEVERE, null, ex);
        }
        CalendarHandler.CalendarEvent event = new CalendarHandler.CalendarEvent(task, start, end, roomNumber);
        CalendarHandler.eventList.add(event);
        PrintWriter out = response.getWriter();
        try {
            out.println(CalendarHandler.getEvents());
        } finally {
            out.close();
        }
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

	// This calls the reservationrecord method from the calendarhandler
	
	public static void main(String[] argv) {
                CalendarHandler.ReservationRecord record = new CalendarHandler.ReservationRecord("1","2","3","4",
                "5","6","7","8","9","10","11","12","13","14");
                
		try {
                 
                    insertRecordIntoTable(record);

		} catch (Exception e) {

			System.out.println(e.getMessage());

		}

	}

// This creates the reservation table if the table is not yet created on the test env
	
        private static void createReservationTable(){
            
            String queryStr = "CREATE TABLE IF NOT EXISTS reservation(" +
                "task varchar(200)," +
                "startYear varchar(10)," +
                "startMonth varchar(10)," +
                "startDay varchar(10)," +
                "startHour varchar(10)," +
                "startMinute varchar(10)," +
                "startSecond varchar(10)," +
                "endYear varchar(10)," +
                "endMonth varchar(10)," +
                "endDay varchar(10)," +
                "endHour varchar(10)," +
                "endMinute varchar(10)," +
                "endSecond varchar(10)," +
                "roomNumber varchar(100)" + ");";
            
            Connection dbConnection = getDBConnection();
            
            try {
            PreparedStatement preparedStatement = dbConnection.prepareStatement(queryStr);
            preparedStatement.execute();
            } catch(SQLException e) {
                e.printStackTrace();
            } finally {
                try {
                    dbConnection.close();
                } catch (SQLException ex) {
                    Logger.getLogger(EventController.class.getName()).log(Level.SEVERE, null, ex);
                }
            }
        }

		// This is what inserts the data into the MySQL reservation table by executing the insert SQL statement
		
	private static void insertRecordIntoTable(CalendarHandler.ReservationRecord record) throws SQLException {

                if(!tableCreated) {
                    tableCreated = true;
                    createReservationTable();
                }
		Connection dbConnection = null;
		PreparedStatement preparedStatement = null;
                

		String insertTableSQL = "INSERT INTO reservation"
				+ "(task, startYear, startMonth, startDay, startHour, startMinute, startSecond, endYear, endMonth, endDay, endHour, endMinute, endSecond, roomNumber) VALUES"
				+ "(?,?,?,?,?,?,?,?,?,?,?,?,?,?)";

		try {
			dbConnection = getDBConnection();
			preparedStatement = dbConnection.prepareStatement(insertTableSQL);

                        preparedStatement.setString(1, record.getTask());
                        preparedStatement.setString(2, record.getStartYear());
                        preparedStatement.setString(3, record.getStartMonth());
                        preparedStatement.setString(4, record.getStartDay());
                        preparedStatement.setString(5, record.getStartHour());
                        preparedStatement.setString(6, record.getStartMinute());
                        preparedStatement.setString(7, record.getStartSecond());
                        preparedStatement.setString(8, record.getEndYear());
                        preparedStatement.setString(9, record.getEndMonth());
                        preparedStatement.setString(10, record.getEndDay());
                        preparedStatement.setString(11, record.getEndHour());
                        preparedStatement.setString(12, record.getEndMinute());
                        preparedStatement.setString(13, record.getEndSecond());
                        preparedStatement.setString(14, record.getRoomNumber());	

			preparedStatement.executeUpdate();

			System.out.println("Record is inserted into DBUSER table!");

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