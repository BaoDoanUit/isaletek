<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SelloutChartQty.aspx.cs" Inherits="WebApplication.Pages.App.SelloutChartQty" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" />
    <title></title>

    <link href="/Content/bootstrap.min.css" rel="stylesheet">
    <link href="/Content/font-awesome/css/font-awesome.css" rel="stylesheet" />
    <link href="/Content/site.css" rel="stylesheet">
    <!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!--[if lt IE 9]>
        <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
        <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->

    <script src="/Scripts/jquery-1.12.2.min.js" type="text/javascript"></script>


    <style>
        *, .dxeBase, .dxeEditAreaSys, .dxeListBoxItem {
            font-size: small;
            line-height: inherit;
        }

        /*.filter .dxeCaption_Moderno {
            width: 64px !important
        }*/
    </style>

    <script src="https://code.highcharts.com/highcharts.js"></script>
    <script src="https://code.highcharts.com/modules/series-label.js"></script>
    <script src="https://code.highcharts.com/modules/exporting.js"></script>
    <script src="https://code.highcharts.com/modules/export-data.js"></script>
    <script>
        $(document).ready(function () { 
             var type = '<%= Request.QueryString["type"]%>'
            var data = {
                userId: '<%= Request.QueryString["userId"]%>',
                fromdate:'<%= Request.QueryString["fromdate"]%>',
                todate:'<%= Request.QueryString["todate"]%>',
                Region:'<%= Request.QueryString["Region"]%>',
                ObjectId:'<%= Request.QueryString["ObjectId"]%>',
                Product:'<%= Request.QueryString["Product"]%>',
                shopId:'<%= Request.QueryString["shopId"]%>'
            }
            var url = '/Pages/App/Handler/Mobile_Sellout_Chart_Qty.ashx'
            if (type === 'qty') {
                chartQty(url, data);
            } else {
                chartamount(url, data);
            }
        });
        function chartQty(url, data) { 
            $.post(url, data, function (data) {
                var categories = [],
                    series = [
                        {
                            type: 'spline', name: 'Target', data: [], index: 2, color: '#4591f9'
                        }, {
                            type: 'spline', name: 'Result', data: [], color: '#ff1800', index: 2
                        }, {
                            type: 'areaspline', name: 'Last Year', data: [],
                            color: {
                                radialGradient: { cx: 0.5, cy: 0.5, r: 0.5 },
                                stops: [[0, '#dae9fd'], [1, '#c6deff']]
                            }, index: 1
                        },
                        {
                            type: 'spline', name: 'AT%', data: [], color: '#ffa50000', index: 2, tooltip: { valueSuffix: '{.1f}%' }
                        },
                        {
                            type: 'spline',
                            name: 'ALY%', data: [], color: '#ff6a0000', index: 3, tooltip: { valueSuffix: '{.1f}%' }
                        }
                    ];
                var myArr = $.parseJSON(data);
                var total = 0, totallastyear = 0;
                for (var i = 0; i < myArr.length; i++) {
                    categories.push(myArr[i].day);
                    total = total + myArr[i].actualQty;
                    totallastyear = totallastyear + myArr[i].lastyearQty;
                    var per = 0, perlastyear = 0;
                    if (myArr[i].targetQty > 0)
                        per = Math.round(parseFloat(total) / myArr[i].targetQty * 100);
                    if (totallastyear > 0)
                        perlastyear = Math.round(parseFloat(total) / totallastyear * 100);

                    series[0].data.push(myArr[i].targetQty);
                    series[1].data.push(total);
                    series[2].data.push(totallastyear);
                    series[3].data.push(per);
                    series[4].data.push(perlastyear);

                }
                Highcharts.chart('container', {
                    chart: {
                        events: {
                            load: function () {
                                var label = this.renderer.label('Loading...', 100, 120)
                                    .attr({
                                        fill: Highcharts.getOptions().colors[0],
                                        padding: 10,
                                        r: 5,
                                        zIndex: 8
                                    })
                                    .css({
                                        color: '#FFFFFF'
                                    })
                                    .add();

                                setTimeout(function () {
                                    label.fadeOut();
                                }, 1000);
                            }
                        }
                    },
                    title: {
                        text: 'Sell out by month Qty'
                    },
                    xAxis: {
                        categories: categories
                    },
                    yAxis: {
                        title: {
                            text: 'Qty'
                        }
                    },
                    legend: {
                        enabled: false
                    },

                    tooltip: {
                        shared: true,
                        valueSuffix: ' '
                    },
                    credits: {
                        enabled: false
                    },
                    plotOptions: {
                        areaspline: {
                            fillOpacity: 0.5
                        }
                    },
                    series: series
                });

            });
        }
        function chartamount(url, data) {
            $.post(url, data, function (data) {
                var categories = [],
                    series = [
                        {
                            type: 'spline', name: 'Target', data: [], index: 2, color: '#4591f9'
                        },
                        {
                            type: 'spline', name: 'Result', data: [], color: '#ff1800', index: 2
                        }, {
                            type: 'areaspline', name: 'Last Year', data: [],
                            color: {
                                radialGradient: { cx: 0.5, cy: 0.5, r: 0.5 },
                                stops: [
                                    [0, '#dae9fd'],
                                    [1, '#c6deff']
                                ]
                            },
                            index: 1
                        },
                        {
                            type: 'spline', name: 'AT%', data: [], color: '#ffa50000', index: 2,
                            tooltip: {
                                valueSuffix: '{.1f}%'
                            }
                        },
                        {
                            type: 'spline', name: 'ALY%', data: [], color: '#ff6a0000', index: 3,
                            tooltip: {
                                valueSuffix: '{.1f}%'
                            }
                        }
                    ];
                var myArr = $.parseJSON(data);
                var total = 0, totallastyear = 0;
                for (var i = 0; i < myArr.length; i++) {
                    categories.push(myArr[i].day);

                    total = total + myArr[i].actualAmount;
                    totallastyear = totallastyear + myArr[i].lastyearAmt;

                    var per = 0, perlastyear = 0;

                    if (myArr[i].targetAmount > 0)
                        per = Math.round(parseFloat(total) / myArr[i].targetAmount * 100);

                    if (totallastyear > 0)
                        perlastyear = Math.round(parseFloat(total) / totallastyear * 100);

                    series[0].data.push(myArr[i].targetAmount);
                    series[1].data.push(total);
                    series[2].data.push(totallastyear);
                    series[3].data.push(per);
                    series[4].data.push(perlastyear);

                }
                Highcharts.chart('container', {
                    chart: {
                        events: {
                            load: function () {
                                var label = this.renderer.label('Loading...', 100, 120)
                                    .attr({
                                        fill: Highcharts.getOptions().colors[0],
                                        padding: 10,
                                        r: 5,
                                        zIndex: 8
                                    })
                                    .css({
                                        color: '#FFFFFF'
                                    })
                                    .add();

                                setTimeout(function () {
                                    label.fadeOut();
                                }, 1000);
                            }
                        }
                    },
                    title: {
                        text: 'Sell out by month Amt'
                    },
                    xAxis: {
                        categories: categories
                    },
                    
                    yAxis: {
                        title: {
                            text: 'Amt (KVND)'
                        }
                    },
                    legend: {
                        enabled: false
                    },
                    tooltip: {
                        shared: true,
                        valueSuffix: ' '
                    },
                    credits: {
                        enabled: false
                    },
                    plotOptions: {
                        areaspline: {
                            fillOpacity: 0.5
                        }
                    },
                    series: series
                });

            });
        }
    </script>
</head>
<body>
    <form id="form1" runat="server">
        <div id="container" style="min-width: 310px; height: 300px; margin: 0 auto"></div>
    </form>
</body>
</html>
