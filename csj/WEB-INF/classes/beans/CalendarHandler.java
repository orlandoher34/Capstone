/**
This java servlet is what intializes the array to display events in the calendar.
*/

package beans;

import com.sun.corba.se.impl.orbutil.ObjectWriter;
import java.util.ArrayList;

public class CalendarHandler {
    public static ArrayList<CalendarEvent> eventList;
    public static boolean initialized = false;

/**
This java servlet is what intializes the array to display events in the calendar.
*/

    private static void loadEvents() {
        eventList = new ArrayList<CalendarEvent>();
        eventList.add(new CalendarEvent("Task 1", "2015-05-26T01:00:00", "2015-05-26T03:00:00", "1"));
        eventList.add(new CalendarEvent("Task 2", "2015-04-09T06:00:00", "2015-04-09T09:00:00", "2"));
        eventList.add(new CalendarEvent("Task 3", "2015-04-12T01:00:00", "2015-04-12T04:00:00", "3"));
        eventList.add(new CalendarEvent("Task 4", "2015-04-19T06:00:00", "2015-04-19T09:00:00", "4"));
    }

//Retreieves event list and will call to initializer if an array does not exist.

    public static String getEvents() {
        if(!initialized){
            loadEvents();
            initialized = true;
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

//This method will remove an event

    public static void removeTask(String task) {
        if(eventList == null || eventList.isEmpty()) return;
        int index = 0, indexToRemove = -1;
        CalendarEvent eventToRemove = null;
        for(CalendarEvent event : eventList) {
            index ++;
            if(event.getTask().equals(task)) {
                indexToRemove = index;
                eventToRemove = event;
                break;
            }
        }
        if(eventToRemove != null) {
            eventList.remove(eventToRemove);
        }
    }
     
// used to assign the value of the X parameter to the X field so that it is called by th EventController
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
        
        public String getTask() {
            return this.task;
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
    
// used to format time to pass as string like "2015-04-19T06:00:00"
    public static String formatTime(String year, String month, String day,
            String hour, String minute, String sec){
        return year + "-" + month + "-" + day + "T" + hour + ":"
                + minute + ":" + sec;
    }
   // used to assign the value of the X parameter to the X field so that it is called by the EventController and inserted to SQL DB 
     public static class ReservationRecord{
            
            private String task;
            private String startYear;
            private String startMonth;
            private String startDay;
            private String startHour;
            private String startMinute;
            private String startSecond;
            private String endYear;
            private String endMonth;
            private String endDay;
            private String endHour;
            private String endMinute;
            private String endSecond;
            private String roomNumber;

        public String getTask() {
            return task;
        }

        public String getStartYear() {
            return startYear;
        }

        public String getStartMonth() {
            return startMonth;
        }

        public String getStartDay() {
            return startDay;
        }

        public String getStartHour() {
            return startHour;
        }

        public String getStartMinute() {
            return startMinute;
        }

        public String getStartSecond() {
            return startSecond;
        }

        public String getEndYear() {
            return endYear;
        }

        public String getEndMonth() {
            return endMonth;
        }

        public String getEndDay() {
            return endDay;
        }

        public String getEndHour() {
            return endHour;
        }

        public String getEndMinute() {
            return endMinute;
        }

        public String getEndSecond() {
            return endSecond;
        }

        public String getRoomNumber() {
            return roomNumber;
        }


        public void setTask(String task) {
            this.task = task;
        }

        public void setStartYear(String startYear) {
            this.startYear = startYear;
        }

        public void setStartMonth(String startMonth) {
            this.startMonth = startMonth;
        }

        public void setStartDay(String startDay) {
            this.startDay = startDay;
        }

        public void setStartHour(String startHour) {
            this.startHour = startHour;
        }

        public void setStartMinute(String startMinute) {
            this.startMinute = startMinute;
        }

        public void setStartSecond(String startSecond) {
            this.startSecond = startSecond;
        }

        public void setEndYear(String endYear) {
            this.endYear = endYear;
        }

        public void setEndMonth(String endMonth) {
            this.endMonth = endMonth;
        }

        public void setEndDay(String endDay) {
            this.endDay = endDay;
        }

        public void setEndHour(String endHour) {
            this.endHour = endHour;
        }

        public void setEndMinute(String endMinute) {
            this.endMinute = endMinute;
        }

        public void setEndSecond(String endSecond) {
            this.endSecond = endSecond;
        }

        public void setRoomNumber(String roomNumber) {
            this.roomNumber = roomNumber;
        }

            
            public ReservationRecord() {
                
            }
            
            public ReservationRecord( String task,
            String startYear,
            String startMonth,
            String startDay,
            String startHour,
            String startMinute,
            String startSecond,
            String endYear,
            String endMonth,
            String endDay,
            String endHour,
            String endMinute,
            String endSecond,
            String roomNumber) {
                this.task = task;
                this.startYear = startYear;
                this.startMonth = startMonth;
                this.startDay = startDay;
                this.startHour = startHour;
                this.startMinute = startMinute;
                this.startSecond = startSecond;
                this.endYear = endYear;
                this.endMonth = endMonth;
                this.endDay = endDay;
                this.endHour = endHour;
                this.endMinute = endMinute;
                this.endSecond = endSecond;
                this.roomNumber = roomNumber;
                
            }
               
        }
		

       // used to print/remove events
    public static void main(String[] args){
        System.out.println(getEvents());
        removeTask("Task 1");
        System.out.println(getEvents());
    }
    
}