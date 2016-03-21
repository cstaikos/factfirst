
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

          var evidence_upvotes_downvotes_options = ({
              chart: {
                  renderTo: 'evidence-upvotes-downvotes',
                  plotBackgroundColor: null,
                  plotBorderWidth: null,
                  plotShadow: false,
                  type: 'pie'
              },
              title: {
                  text: ''
              },
              tooltip: {
                  pointFormat: '{series.name}: <b>{point.percentage:.1f}%</b>'
              },
              plotOptions: {
                  pie: {
                      allowPointSelect: true,
                      showInLegend: true,
                      cursor: 'pointer',
                      dataLabels: {
                          connectorWidth: 0,
                          enabled: false
                      }
                  }
              }

          });

          var facts_upvotes_downvotes_options = ({
              chart: {
                  renderTo: 'facts-upvotes-downvotes',
                  plotBackgroundColor: null,
                  plotBorderWidth: null,
                  plotShadow: false,
                  type: 'pie'
              },
              title: {
                  text: ''
              },
              tooltip: {
                  pointFormat: '{series.name}: <b>{point.percentage:.1f}%</b>'
              },
              plotOptions: {
                  pie: {
                      allowPointSelect: true,
                      showInLegend: true,
                      cursor: 'pointer',
                      dataLabels: {
                          connectorWidth: 0,
                          enabled: false
                      }
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

              // Activity by Category Data
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

                //Evidence Quality Data
                evidence_upvotes_downvotes.setTitle({text: 'Evidence Quality' + ' ' + data[6] + '%'});
                evidence_upvotes_downvotes.addSeries({
                    name: 'Votes',
                    colorByPoint: true,
                    data: [{
                        name: 'upvotes',
                        y: data[4]
                    }, {
                        name: 'downvotes',
                        y: data[5]
                    }]
                })


                facts_upvotes_downvotes.setTitle({text: 'Average Fact Score' + ' ' + data[7] + '%'});
                facts_upvotes_downvotes.addSeries({
                    name: 'evidence',
                    colorByPoint: true,
                    data: [{
                        name: 'supporting evidence',
                        y: data[8]
                    }, {
                        name: 'refuting evidence',
                        y: data[9]
                    }]
                })
                //evidence_upvotes_downvotes.plotOptions.pie.dataLabels.enabled = false;

              }
            }
          })


        var activity_by_category = new Highcharts.Chart(activity_by_category_options);
        var evidence_upvotes_downvotes = new Highcharts.Chart(evidence_upvotes_downvotes_options);
        var facts_upvotes_downvotes = new Highcharts.Chart(facts_upvotes_downvotes_options);

        // Pie Chart - Fact Upvotes vs DownVotes



        // Pie Chart - Evidence Upvotes vs DownVotes


    })
    };

