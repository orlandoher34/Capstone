<!--

This is the main page of the web reservation application.
This page instantiates the DayPilot calendar API and calls the CalendarHandler and 
Event Controller servlets.

-->


<%@ page import="java.sql.*" %>
<%ResultSet resultset =null;%>
  
<html>
<head>
<center><img src="telecom.png" alt="Citizen INC." width="128" height="128"></center>
      <title>Conference Room Scheduler</title> 
		 <link rel="stylesheet" type="text/css" href="stylesheet.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.0/jquery.min.js"></script>
</head>
<body>


<nav class="topright">
  <a href="update.jsp">Access&nbsp;</a>
  <a href="home.jsp">Logout&nbsp;</a>
</nav>
<H1 ALIGN="CENTER">Citizen Inc. Admin Page</H1>
<br>
<br>
<script src="daypilot-all.min.js" type="text/javascript"></script>
<link type="text/css" rel="stylesheet" href="calendar_white.css" />

 <div class="shadow"></div>
            <div class="hideSkipLink">
            </div>
           <div class="main">

                <div style="width:160px; float:left;">
                    <div id="nav"></div>
                </div>

                <div style="margin-left: 160px;">

                    <div class="space">
                        <div class="space">
                            Time range:
                            <select id="timerange">
							    <option value="day" selected>Day</option>
                                <option value="week">Week</option>
                                <option value="month">Month</option>
                            </select>
                        </div>
			</div>
                <div id="dp"></div>
          

<!--

The Java Script below loads the calendar view from the DayPilot API. Some of the changes we modified from the API are:

*Daily/weekly/monthly view
*Three month calander view on the left side
*Default to today's view  

-->


     <script type="text/javascript">
                    var start;
                    var nav = new DayPilot.Navigator("nav");

					nav.selectMode = "day";
                    nav.showMonths = 3;
                    nav.skipMonths = 3;
				
                    nav.onTimeRangeSelected = function(args) {
					var day = args.day;
					if (dp.visibleStart() <= day && day < dp.visibleEnd()) {
                        dp.scrollTo(day, "fast");
                    }
                    else {
                        start = day.firstDayOfMonth();
                        var days = day.daysInMonth();
                        dp.startDate = start;
                        dp.days = days;
                        dp.update();
                        dp.scrollTo(day, "fast");
                    }
                    };
                    nav.init();
					 $("#timerange").change(function() {
                        switch (this.value) {
							case "day":
                               
                                 dp.startDate = nav.selectionDay;
								 nav.selectMode = "Day";
                                nav.select(nav.selectionDay);
                                dp.timeHeaders = [
                                    { groupBy: "Month", format: "MMMM yyyy" },
                                    { groupBy: "Day", format: "dddd, MMMM d"},
                                    { groupBy: "Hour", format: "h tt"}
                                ];
                                dp.scale = "Hour";
                                dp.update();
                                break;
                            case "week":
                            
                                dp.startDate = nav.selectionDay.firstDayOfWeek();
                                nav.selectMode = "Week";
                                nav.select(nav.selectionDay);
                                dp.timeHeaders = [
                                    { groupBy: "Month" },
                                    { groupBy: "Week" },
                                    { groupBy: "Cell", format: "d" }
                                ];
                                dp.scale = "Day";
                                dp.update();
                                break;
                            case "month":
                                dp.timeHeaders = [
                                    { groupBy: "Year" },
                                    { groupBy: "Quarter" },
                                    { groupBy: "Cell" }
                                ];
                                dp.scale = "Month";
				dp.startDate = nav.selectionDay.firstDayOfMonth();
                                  dp.days = 366;
                                nav.selectMode = "Month";
                                nav.select(nav.selectionDay);
                                dp.update();
                                break;
                        }
                    });
                 
                </script>
			
			
<!--

The code below is used to create a reservation as well as loading a list of existing users so that they can be selected for the reservation process. 
-->

<br>
<br>

<h1> Create New Reservation </h1>

<%
Connection con= null;
PreparedStatement ps = null;
ResultSet rs = null;
String driverName = "com.mysql.jdbc.Driver";
String url = "jdbc:mysql://localhost:3306/CITIZEN";
String user = "dbadmin";
String password = "db123";
String sql = "select * from User";
try {
Class.forName(driverName);
con = DriverManager.getConnection(url, user, password);
ps = con.prepareStatement(sql);
rs = ps.executeQuery();
%>
  

<form id="addEvent" name="scheduler" method="POST" action="/csj/EventController">
  Requested by:
  <br>
  <select name="userEmail" id="mailId">
    <br>
    <option value="select">select</option>< 
    "\\n"
    <%
    while(rs.next())
    {
    String userEmail = rs.getString("userEmail");
    %>
    <option value=<%=userEmail%>><%=userEmail%></option><
    <% 
}}

    catch(SQLException sqe)
    {
    out.println("home"+sqe);
    }
    %>

    <br>
    <br>
    <select name"blank">
      <option disabled="disabled">----</option>
    </select>
    <br>

    Event Name:
    <input type="text" name="task" id="taskName">
    <br>
    <br>

    Room:
    <select name="roomNumber" id="roomNumber">
      <option value="1">1</option>
      <option value="2">2</option>
      <option value="3">3</option>
      <option value="4">4</option>
      <option value="5">5</option>
      <option value="6">6</option>
      <option value="7">7</option>
      <option value="8">8</option>
      <option value="9">9</option>
      <option value="10">10</option>
    </select>

    <br>
    <br>

    Start Timings (YYYY)
    <select name="startYear" id="startYear">
      <option value="2017">2017</option>
      <option value="2018">2018</option>
      <option value="2019">2019</option>
      <option value="2020">2020</option>
      <option value="2021">2021</option>
      <option value="2022">2022</option>
      <option value="2023">2023</option>
      <option value="2024">2024</option>
      <option value="2025">2025</option>
      <option value="2026">2026</option>
      <option value="2027">2027</option>
      <option value="2028">2028</option>
      <option value="2029">2029</option>
      <option value="2030">2030</option>
    </select>
    (MM)
    <select name="startMonth" id="startMonth">
      <option value="01">01</option>
      <option value="02">02</option>
      <option value="03">03</option>
      <option value="04">04</option>
      <option value="05">05</option>
      <option value="06">06</option>
      <option value="07">07</option>
      <option value="08">08</option>
      <option value="09">09</option>
      <option value="10">10</option>
      <option value="11">11</option>
      <option value="12">12</option>
    </select>
    (DD)
    <select name="startDay" id="startDay">
      <option value="01">01</option>
      <option value="02">02</option>
      <option value="03">03</option>
      <option value="04">04</option>
      <option value="05">05</option>
      <option value="06">06</option>
      <option value="07">07</option>
      <option value="08">08</option>
      <option value="09">09</option>
      <option value="10">10</option>
      <option value="11">11</option>
      <option value="12">12</option>
      <option value="13">13</option>
      <option value="14">14</option>
      <option value="15">15</option>
      <option value="16">16</option>
      <option value="17">17</option>
      <option value="18">18</option>
      <option value="19">19</option>
      <option value="20">20</option>
      <option value="21">21</option>
      <option value="22">22</option>
      <option value="23">23</option>
      <option value="24">24</option>
      <option value="25">25</option>
      <option value="26">26</option>
      <option value="27">27</option>
      <option value="28">28</option>
      <option value="29">29</option>
      <option value="30">30</option>
      <option value="31">31</option>
    </select>
    (HH)
    <select name="startHour" id="startHour">
      <option value="01">01</option>
      <option value="02">02</option>
      <option value="03">03</option>
      <option value="04">04</option>
      <option value="05">05</option>
      <option value="06">06</option>
      <option value="07">07</option>
      <option value="08">08</option>
      <option value="09">09</option>
      <option value="10">10</option>
      <option value="11">11</option>
      <option value="12">12</option>
      <option value="13">13</option>
      <option value="14">14</option>
      <option value="15">15</option>
      <option value="16">16</option>
      <option value="17">17</option>
      <option value="18">18</option>
      <option value="19">19</option>
      <option value="20">20</option>
      <option value="21">21</option>
      <option value="22">22</option>
      <option value="23">23</option>
      <option value="24">24</option>
    </select>
    (MM)
    <select name="startMinute" id="startMinute">
      <option value="00">00</option>
      <option value="30">30</option>
    </select>
    (SS)
    <select name="startSecond" id="startSecond">
      <option value="00">00</option>
    </select>

    <br>
    <br>
    <br>

    End Timings:
    (YYYY)
    <select name="endYear" id="endYear">
      <option value="2017">2017</option>
      <option value="2018">2018</option>
      <option value="2019">2019</option>
      <option value="2020">2020</option>
      <option value="2021">2021</option>
      <option value="2022">2022</option>
      <option value="2023">2023</option>
      <option value="2024">2024</option>
      <option value="2025">2025</option>
      <option value="2026">2026</option>
      <option value="2027">2027</option>
      <option value="2028">2028</option>
      <option value="2029">2029</option>
      <option value="2030">2030</option>
    </select>
    (MM)
    <select name="endMonth" id="endMonth">
      <option value="01">01</option>
      <option value="02">02</option>
      <option value="03">03</option>
      <option value="04">04</option>
      <option value="05">05</option>
      <option value="06">06</option>
      <option value="07">07</option>
      <option value="08">08</option>
      <option value="09">09</option>
      <option value="10">10</option>
      <option value="11">11</option>
      <option value="12">12</option>
    </select>
    (DD)
    <select name="endDay" id="endDay">
      <option value="01">01</option>
      <option value="02">02</option>
      <option value="03">03</option>
      <option value="04">04</option>
      <option value="05">05</option>
      <option value="06">06</option>
      <option value="07">07</option>
      <option value="08">08</option>
      <option value="09">09</option>
      <option value="10">10</option>
      <option value="11">11</option>
      <option value="12">12</option>
      <option value="13">13</option>
      <option value="14">14</option>
      <option value="15">15</option>
      <option value="16">16</option>
      <option value="17">17</option>
      <option value="18">18</option>
      <option value="19">19</option>
      <option value="20">20</option>
      <option value="21">21</option>
      <option value="22">22</option>
      <option value="23">23</option>
      <option value="24">24</option>
      <option value="25">25</option>
      <option value="26">26</option>
      <option value="27">27</option>
      <option value="28">28</option>
      <option value="29">29</option>
      <option value="30">30</option>
      <option value="31">31</option>
    </select>
    (HH)
    <select name="endHour" id="endHour">
      <option value="01">01</option>
      <option value="02">02</option>
      <option value="03">03</option>
      <option value="04">04</option>
      <option value="05">05</option>
      <option value="06">06</option>
      <option value="07">07</option>
      <option value="08">08</option>
      <option value="09">09</option>
      <option value="10">10</option>
      <option value="11">11</option>
      <option value="12">12</option>
      <option value="13">13</option>
      <option value="14">14</option>
      <option value="15">15</option>
      <option value="16">16</option>
      <option value="17">17</option>
      <option value="18">18</option>
      <option value="19">19</option>
      <option value="20">20</option>
      <option value="21">21</option>
      <option value="22">22</option>
      <option value="23">23</option>
      <option value="24">24</option>
    </select>
    (MM)
    <select name="endMinute" id="endMinute">
      <option value="00">00</option>
      <option value="30">30</option>
    </select>
    (SS)
    <select name="endSecond" id="endSecond">
      <option value="00">00</option>
    </select>

    <br>
    <br>
    <br>

    <input type="submit" value="Create new meeting">
    </form>

	<!--

The Java Script below loads the calander events and creates, edits and removes appointments. Some of the changes we modified from the API are:

*Insert appointment information into SQL database
*Create e-mail when reservation is created or cancelled
*Move meeting to different time slot
*Edit meeting
*Cancel meeting

-->

<script type="text/javascript">
    

    
    var dp = loadScheduler();
    function loadScheduler() {
    var dp = new DayPilot.Scheduler("dp");
    dp.resources = [
  {"id":"1","name":"Room 1"},
  {"id":"2","name":"Room 2"},
  {"id":"3","name":"Room 3"},
  {"id":"4","name":"Room 4"},
    {"id":"5","name":"Room 5"},
  {"id":"6","name":"Room 6"},
  {"id":"7","name":"Room 7"},
  {"id":"8","name":"Room 8"},
    {"id":"9","name":"Room 9"},
  {"id":"10","name":"Room 10"},
];

  dp.treeEnabled = true;
                
                dp.heightSpec = "Max";
                dp.height = 300;
                
                dp.scale = "Hour";
                dp.startDate = nav.selectionDay;
                dp.days = DayPilot.Date.today().daysInMonth();
                dp.cellWidth = 150;
                
                dp.eventHeight = 40;
                dp.durationBarVisible = false;
                
           
                dp.treePreventParentUsage = true;
				
				 dp.onBeforeEventRender = function(args) {
                };

               dp.timeHeaders = [
                    { groupBy: "Month", format: "MMMM yyyy" },
                    { groupBy: "Day", format: "dddd, MMMM d"},
                    { groupBy: "Hour", format: "h tt"}
                ];
                dp.businessBeginsHour = 1;
                dp.businessEndsHour = 23;
                dp.businessWeekends = true;
                dp.showNonBusiness = true;
                
                dp.allowEventOverlap = false;
                dp.bubble = new DayPilot.Bubble();
	
   				dp.eventDeleteHandling = "Update";

  dp.onEventDelete = function(args) {
    if (!confirm("Do you really want to delete this event?")) {
      args.preventDefault();
    }
  };


dp.onEventDeleted = function (args) { 
var task = args.e.data.text;
DayPilot.request("/csj/EventRemover?task=" + task, 
function(req) { 
alert("Record Deleted");
 var email_id = document.getElementById('mailId').value,
			subject = "Your request to cancel the following event: " + document.getElementById('taskName').value,
			time1 = document.getElementById('startMonth').value,
			time2 = document.getElementById('startDay').value,
			time3 = document.getElementById('startYear').value,
			time4 = document.getElementById('startHour').value,
			time5 = document.getElementById('startMinute').value,
			time6 = document.getElementById('endHour').value,
			time7 = document.getElementById('endMinute').value,
			room = document.getElementById('roomNumber').value,
			blank = " ",
			dash = "-",
			place = " has been successfully processed",
			body_text = "Your cancellation request";
			window.location.href = "mailto:"+ email_id +"?subject=" + body_text + "&body=" + subject + blank + "on " + time1 + dash + time2 + dash + time3 + " in room " + room + " from " + time4 + ":" + time5 + " to " + time6 + ":" + time7 + place + ".";
}, 
args, 
function(req) { // error 
dp.message("Delete failed"); 
} 
); 
};
  
      dp.contextMenu = new DayPilot.Menu({items: [
        {text:"Edit", onClick: function(args) { dp.events.edit(args.source); } },
        {text:"Delete", onClick: function(args) { dp.events.remove(args.source); } },
        {text:"-"},
        {text:"Select", onClick: function(args) { dp.multiselect.add(args.source); } },
    ]});
   
  
    dp.heightSpec = "Max";
    dp.height = 500;
    dp.events.list = [];
    dp.eventMovingStartEndEnabled = true;
    dp.eventResizingStartEndEnabled = true;
    dp.timeRangeSelectingStartEndEnabled = true;
    dp.onBeforeResHeaderRender = function(args) {
        args.resource.bubbleHtml = "Test";
    };
    dp.onEventMove = function(args) {
    };


    dp.onEventMoved = function (args) {
        dp.message("Moved: " + args.e.text());
    };
    dp.onEventClicked = function(args) {
    };
    dp.onEventMoving = function(args) {
        if (args.e.resource() === "A" && args.resource === "B") { 
            args.left.enabled = false;
            args.right.html = "You can't move an event from Room 1 to Room B";
            args.allowed = false;
        }
        else if (args.resource === "B") {  
            while (args.start.getDayOfWeek() == 0 || args.start.getDayOfWeek() == 6) {
                args.start = args.start.addDays(1);
            }
            args.end = args.start.addDays(1); 
            args.left.enabled = false;
            args.right.html = "Events in Room 2 must start on a workday and are limited to 1 day.";
        }
        if (args.resource === "C") {
            var except = args.e.data;
            var events = dp.rows.find(args.resource).events.all();
            var start = args.start;
            var end = args.end;
            var overlaps = events.some(function(item) {
                return item.data !== except && DayPilot.Util.overlaps(item.start(), item.end(), start, end);
            });
            while (overlaps) {
                start = start.addDays(1);
                end = end.addDays(1);
                overlaps = events.some(function(item) {
                    return item.data !== except && DayPilot.Util.overlaps(item.start(), item.end(), start, end);
                });
            }
            if (args.start !== start) {
                args.start = start;
                args.end = end;
                args.left.enabled = false;
                args.right.html = "Start automatically moved to " + args.start.toString("d MMMM, yyyy");
            }
        }

    };
	
	dp.onBeforeEventRender = function(args) {
        args.data.bubbleHtml = "<div><b>" + args.data.text + "</b></div><div>Start: " + new DayPilot.Date(args.data.start).toString("M/d/yyyy") + "</div><div>End: " + new DayPilot.Date(args.data.end).toString("M/d/yyyy") + "</div>";
    };
		
    dp.onEventResize = function(args) {
    };
    
    dp.onEventResized = function (args) {
        dp.message("Resized: " + args.e.text());
    };
    dp.onEventResizing = function(args) {
    };
   
    dp.onTimeRangeSelected = function (args) {
        return;
        var name = prompt("New event name:", "New Event ");
        dp.clearSelection();
        if (!name) return;
        var e = new DayPilot.Event({
            start: args.start,
            end: args.end,
            id: DayPilot.guid(),
            resource: args.resource,
            text: name
        });
        dp.events.add(e);
        dp.message("Created");


    };
    dp.separators = [
        {color:"Red", location:"2016-03-29T00:00:00", layer: "BelowEvents"}
    ];
    dp.onEventClicked = function(args) {
        
    };
    dp.eventClickHandling = "Edit";

    dp.onEventMove = function(args) {
        if (args.ctrl) {
            var newEvent = new DayPilot.Event({
                start: args.newStart,
                end: args.newEnd,
                text: "Copy of " + args.e.text(),
                resource: args.newResource,
                id: DayPilot.guid()  
            });
            dp.events.add(newEvent);
        
            args.preventDefault(); 
        }
    };
    dp.init();
 
	
$.ajax({url: "/csj/EventController", success: function(result){
            console.log(result);
            dp.events.list = JSON.parse(result);
            dp.update();
        }});
    
$('#addEvent').submit(function () {


  $.ajax({
        url:'/csj/EventController',
        type:'POST',
        data: $("#addEvent").serialize(),
        dataType: 'json', 
        success: function(response){
            console.log(response);
            dp.events.list = response;
            dp.update();


            var email_id = document.getElementById('mailId').value,
			subject = "Your request for: " + document.getElementById('taskName').value,
			time1 = document.getElementById('startMonth').value,
			time2 = document.getElementById('startDay').value,
			time3 = document.getElementById('startYear').value,
			time4 = document.getElementById('startHour').value,
			time5 = document.getElementById('startMinute').value,
			time6 = document.getElementById('endHour').value,
			time7 = document.getElementById('endMinute').value,
			room = document.getElementById('roomNumber').value,
			blank = " ",
			dash = "-",
			place = "has been successfully booked for ",
			body_text = "Your meeting request";
			window.location.href = "mailto:"+ email_id +"?subject=" + body_text + "&body=" + subject + blank + place + time1 + dash + time2 + dash + time3 + " in room " + room + " from " + time4 + ":" + time5 + " to " + time6 + ":" + time7 + ".";
        },
        error: function(response){
            alert("something went wrong");
        }
    })
 return false;
});
return dp;
} 

</script>
</div>
<div class="clear">
</div>

</body>
</html>
