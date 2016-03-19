

    var hCharts = function() {

      $(function () {

        // Set chart options globally

        Highcharts.setOptions({
          chart: {
            backgroundColor: {
              linearGradient: [0, 0, 500, 500],
              stops: [
                [0, 'rgb(255, 255, 255)'],
                [1, 'rgb(240, 240, 255)']
              ]
            },
            borderWidth: 2,
            plotBackgroundColor: 'rgba(255, 255, 255, .9)',
            plotShadow: true,
            plotBorderWidth: 1
          }
        });

        var activity_by_category_options = ({
          chart: {
            renderTo: 'activity-by-category',
            type: 'bar'
          },
          title: {
            text: 'Activity by Category'
          },
          xAxis: {
            categories: ''
          },
          yAxis: {
            title: {
              text: 'Facts by Category'
            }
          }
        });


        $.ajax({
          url: window.location.pathname + '/metrics',
          type: 'GET',
          dataType: 'json',
          success: function(data){
            if ( data ) {
              console.log(data);
              console.log(data[0]);
              console.log(data[1]);
              console.log(activity_by_category);

              activity_by_category.xAxis[0].setCategories(data[0]);

              activity_by_category.addSeries({
                name: 'Facts',
                data: data[1]
              });

              activity_by_category.addSeries({
                name: 'Evidence',
                data: data[2]
              });

              activity_by_category.addSeries({
                name: 'Votes',
                data: data[3]
              });
            }
          }
        })


        var activity_by_category = new Highcharts.Chart(activity_by_category_options);


        // Pie Chart - Fact Upvotes vs DownVotes

        $('#facts-upvotes-downvotes').highcharts({
          chart: {
            plotBackgroundColor: null,
            plotBorderWidth: null,
            plotShadow: false,
            type: 'pie'
          },
          title: {
            text: 'Matthew\'s Facts'
          },
          tooltip: {
            pointFormat: '{series.name}: <b>{point.percentage:.1f}%</b>'
          },
          plotOptions: {
            pie: {
              allowPointSelect: true,
              cursor: 'pointer',
              dataLabels: {
                enabled: true,
                format: '<b>{point.name}</b>: {point.percentage:.1f} %',
                style: {
                  color: (Highcharts.theme && Highcharts.theme.contrastTextColor) || 'black'
                }
              }
            }
          },
          series: [{
            name: 'Votes',
            colorByPoint: true,
            data: [{
              name: 'upvotes',
              y: 56.33
            }, {
              name: 'downvotes',
              y: 44
            }]
          }]
        });

        // Pie Chart - Evidence Upvotes vs DownVotes

        $('#evidence-upvotes-downvotes').highcharts({
          chart: {
            plotBackgroundColor: null,
            plotBorderWidth: null,
            plotShadow: false,
            type: 'pie'
          },
          title: {
            text: 'Matthew\'s Evidence'
          },
          tooltip: {
            pointFormat: '{series.name}: <b>{point.percentage:.1f}%</b>'
          },
          plotOptions: {
            pie: {
              allowPointSelect: true,
              cursor: 'pointer',
              dataLabels: {
                enabled: true,
                format: '<b>{point.name}</b>: {point.percentage:.1f} %',
                style: {
                  color: (Highcharts.theme && Highcharts.theme.contrastTextColor) || 'black'
                }
              }
            }
          },
          series: [{
            name: 'Votes',
            colorByPoint: true,
            data: [{
              name: 'upvotes',
              y: 56.33
            }, {
              name: 'downvotes',
              y: 44
            }]
          }]
        });

      });
    }
