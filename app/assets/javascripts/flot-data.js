//Flot Pie Chart
$(function() {
  if ($("#flot-pie-chart").length) {
    var i
    var data =[];
    for(i=1;i<=10;i++){
      var temp={
        label: $("#key_"+i).html(),
        data:  $("#count_"+i).html()
      }
      data.push(temp);
    }


    var plotObj = $.plot($("#flot-pie-chart"), data, {
      series: {
        pie: {
          show: true
        }
      },
      grid: {
        hoverable: true
      },
      tooltip: true,
      tooltipOpts: {
        content: "%p.0%, %s", // show percentages, rounding to 2 decimal places
        shifts: {
          x: 20,
          y: 0
        },
        defaultTheme: false
      }
    });
  }
});

//Flot Pie Chart 2
$(function() {
  if ($("#flot-pie-chart-2").length) {
    var i
    var data =[];
    for(i=1;i<=10;i++){
      var temp={
        label: $("#country_"+i).html(),
        data:  $("#tri_"+i).html()
      }
      data.push(temp);
      
    }

    var plotObj = $.plot($("#flot-pie-chart-2"), data, {
      series: {
        pie: {
          show: true
        }
      },
      grid: {
        hoverable: true
      },
      tooltip: true,
      tooltipOpts: {
        content: "%p.0%, %s", // show percentages, rounding to 2 decimal places
        shifts: {
          x: 20,
          y: 0
        },
        defaultTheme: false
      }
    });
  }
});

