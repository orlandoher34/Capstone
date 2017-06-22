/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package beans;

import com.sun.corba.se.impl.orbutil.ObjectWriter;
import java.util.ArrayList;

public class CalendarHandler {
    public static ArrayList<CalendarEvent> eventList;
    
    private static void loadEvents() {
        eventList = new ArrayList<CalendarEvent>();
        eventList.add(new CalendarEvent("Task 1", "2016-04-09T01:00:00", "2016-04-09T04:00:00", "1"));
        eventList.add(new CalendarEvent("Task 2", "2016-04-09T06:00:00", "2016-04-09T09:00:00", "2"));
        eventList.add(new CalendarEvent("Task 3", "2016-04-12T01:00:00", "2016-04-12T04:00:00", "4"));
        eventList.add(new CalendarEvent("Task 4", "2016-04-19T06:00:00", "2016-04-19T09:00:00", "3"));
    }
    
    public static String getEvents() {
        if(eventList == null){
            loadEvents();
        }
        String output = "[";
        for(int i = 0; i < eventList.size(); i++) {
            if(i != 0){
                output += ",";
            }
            output += eventList.get(i).toString();
        }
        output += "]";
        return output;
    }
     
    
    public static class CalendarEvent {
        private String start;
        private String end;
        private String roomNumber;
        private String task;
        private String id;
        private static int idCounter = 0;
        public CalendarEvent(String task, String start, String end, String roomNumber){
            this.end = end;
            this.start = start;
            this.roomNumber = roomNumber;
            this.task = task;
            this.id = String.valueOf(idCounter++);
        }
        
        @Override
        public String toString(){
            return "{" 
                    + "\"id\":" + "\"" + id + "\"" + ","
                    + "\"text\":" + "\"" + task + "\"" + ","
                    + "\"start\":" + "\"" + start + "\"" + ","
                    + "\"end\":" + "\"" + end + "\"" + ","
                    + "\"resource\":" + "\"" + roomNumber + "\"" 
                    + "}";
                    
        }

    }
    
    public static String formatTime(String year, String month, String day,
            String hour, String minute, String sec){
        return year + "-" + month + "-" + day + "T" + hour + ":"
                + minute + ":" + sec;
    }
    
    public static void main(String[] args){
        System.out.println(getEvents());
    }
    
}
