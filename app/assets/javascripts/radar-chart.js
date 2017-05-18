'use strict'

$(function() {

  var data = {
    labels: ["くすくす", "しみじみ", "どきどき", "ひやひや", "すっきり"],
    datasets: [
      {
        label: "My Second dataset",
        backgroundColor: "rgba(255,99,132,0.2)",
        borderColor: "rgba(255,99,132,1)",
        pointBackgroundColor: "rgba(255,99,132,1)",
        pointBorderColor: "#fff",
        pointHoverBackgroundColor: "#fff",
        pointHoverBorderColor: "rgba(255,99,132,1)",
        data: gon.point_list
      }
    ]
  };

  const ctx = $('#radarChart')[0].getContext('2d');
  const radarChart = new Chart(ctx, {
    type: 'radar',
    data: data,
    options: {
      scale: {
        pointLabels: {
          fontSize: 14
        },
        ticks: {
          stepSize: 1,
          max: 5,
          beginAtZero: true
        }
      },
      legend: {
        display: false
      }
    }
  });

});
