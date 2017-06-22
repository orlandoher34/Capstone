<!--

This is the read-only page of the web reservation application. 
This page is accesible by everyone (non-admin staff) to see reservations and room availability. 
-->

<html>
<head>
<center><img src="telecom.png" alt="Citizen INC." width="128" height="128"></center>
      <title>Conference Room Scheduler</title> 
		 <link rel="stylesheet" type="text/css" href="stylesheet.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.0/jquery.min.js"></script>
</head>
<body>


<nav class="topright">
<a href="home.jsp">Logout&nbsp;</a>
</nav>
<H1 ALIGN="CENTER">Citizen Inc. Dashboard</H1>
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
					//
					nav.selectMode = "day";
                    nav.showMonths = 3;
                    nav.skipMonths = 3;
				
					//
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

<br>
<br>
<!--

The Java Script below loads the calander events. 

-->

<script type="text/javascript">

    var dp = loadScheduler();
    function loadScheduler() {
    var dp = new DayPilot.Scheduler("dp");
    dp.resources = [
  {"id":"1","name":"Winter Room"},
  {"id":"2","name":"Spring Room"},
  {"id":"3","name":"Fall Room"},
  {"id":"4","name":"Summer Room"},
    {"id":"5","name":"Chicago Room"},
  {"id":"6","name":"Evanston Room"},
  {"id":"7","name":"Qatar Room"},
  {"id":"8","name":"Ball Room"},
    {"id":"9","name":"Beer Room"},
  {"id":"10","name":"William Sunna Room"},
];

dp.eventMoveHandling = "Disabled";	
dp.eventResizeHandling = "Disabled";
      
  dp.treeEnabled = true;
                
                dp.heightSpec = "Max";
                dp.height = 300;
                
                dp.scale = "Hour";
                dp.startDate = nav.selectionDay;
                dp.days = DayPilot.Date.today().daysInMonth();
                dp.cellWidth = 100;
                
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
                


                dp.bubble = new DayPilot.Bubble();
	


  

    dp.heightSpec = "Max";
    dp.height = 500;

    dp.events.list = [];



    dp.onBeforeResHeaderRender = function(args) {
        args.resource.bubbleHtml = "Test";
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