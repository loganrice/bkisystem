$(document).ready(function(){
  var poundsChart = Morris.Line({
  //     // ID of the element in which to draw the chart.
       element: 'pounds-by-month-chart',
  //     // Chart data records -- each entry in this array corresponds to a point on
  //     // the chart.
       data: $('#pounds-by-month-chart').data('pounds'),
  //     // The name of the data record attribute that contains x-values.
       xkey: 'date',
  //     // A list of names of data record attributes that contain y-values.
       ykeys: ['pounds'],
  //     // Labels for the ykeys -- will be displayed when you hover over the
  //     // chart.
       xLabels: 'month',
       labels: ['Total Pounds']
  });


  $(".easy-pie-chart").easyPieChart({
     animate: "true",
     barColor: "#337ab7"
  });

  $('.sparkline').sparkline(); 
}); 
