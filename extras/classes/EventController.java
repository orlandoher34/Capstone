/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package servlet;

import beans.CalendarHandler;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


@WebServlet(name = "EventController", urlPatterns = {"/EventController"})
public class EventController extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
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
        
        CalendarHandler.CalendarEvent event = new CalendarHandler.CalendarEvent(task, start, end, roomNumber);
        CalendarHandler.eventList.add(event);
        PrintWriter out = response.getWriter();
        try {
            out.println(CalendarHandler.getEvents());
        } finally {
            out.close();
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processPOSTRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
