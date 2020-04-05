<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SelloutChartRange.aspx.cs" Inherits="WebApplication.Pages.App.SelloutChartRange" %>


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
            var url = '/Pages/App/Handler/Mobile_Sellout_Chart_Range.ashx'
            if (type === 'atqty') {
                chartATQty(url, data);
            } else if (type === 'lyqty') {
                chartLYQty(url, data);
            } else if (type === 'atamt') {
                chartATAmt(url, data)
            } else if (type === 'lyamt') {
                chartLYAmt(url, data)
            }
        });
        function chartATQty(url, data) {
            $.post(url, data, function (data) {
                var categories = [],
                    series = [
                        {
                            name: 'Target', type: 'column', data: [], color: '#4591f9'
                        },
                        {
                            name: 'Result', type: 'column', data: [], color: '#ff1800'
                        },
                        {
                            type: 'spline', name: '%', data: [], color: '#ffa50000', tooltip: { valueSuffix: '{.1f}%' }
                        }
                    ];
                var myArr = $.parseJSON(data);
                for (var i = 0; i < myArr.length; i++) {
                    categories.push(myArr[i].range);
                    var per = 0;
                    if (myArr[i].targetQty > 0)
                        per = Math.round(parseFloat(myArr[i].actualQty) / myArr[i].targetQty * 100);

                    series[0].data.push(myArr[i].targetQty);
                    series[1].data.push(myArr[i].actualQty);
                    series[2].data.push(per);
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
                        text: 'AT'
                    },
                    xAxis: {
                        categories: categories
                    },
                    yAxis: {
                        title: {
                            text: ' '
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

        function chartLYQty(url, data) {
            $.post(url, data, function (data) {
                var categories = [],
                    series = [
                        {
                            name: 'Target', type: 'column', data: [], color: '#4591f9'
                        },
                        {
                            name: 'Result', type: 'column', data: [], color: '#ff1800'
                        },
                        {
                            type: 'spline', name: '%', data: [], color: '#ffa50000', tooltip: { valueSuffix: '{.1f}%' }
                        }
                    ];
                var myArr = $.parseJSON(data);
                for (var i = 0; i < myArr.length; i++) {
                    categories.push(myArr[i].range);
                    var per = 0;
                    if (myArr[i].lastyearQty > 0)
                        per = Math.round(parseFloat(myArr[i].actualQty) / myArr[i].lastyearQty * 100);

                    series[0].data.push(myArr[i].actualQty);
                    series[1].data.push(myArr[i].lastyearQty);
                    series[2].data.push(per);
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
                        text: 'ALY'
                    },
                    xAxis: {
                        categories: categories
                    },
                    yAxis: {
                        title: {
                            text: ' '
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
        function chartATAmt(url, data) {
            $.post(url, data, function (data) {
                var categories = [],
                    series = [
                        {
                            name: 'Target', type: 'column', data: [], color: '#4591f9'
                        },
                        {
                            name: 'Result', type: 'column', data: [], color: '#ff1800'
                        },
                        {
                            type: 'spline', name: '%', data: [], color: '#ffa50000', tooltip: { valueSuffix: '{.1f}%' }
                        }
                    ];
                var myArr = $.parseJSON(data);
                for (var i = 0; i < myArr.length; i++) {
                    categories.push(myArr[i].range);
                    var per = 0;
                    if (myArr[i].targetAmount > 0)
                        per = Math.round(parseFloat(myArr[i].actualAmount) / myArr[i].targetAmount * 100);

                    series[0].data.push(myArr[i].targetAmount);
                    series[1].data.push(myArr[i].actualAmount);
                    series[2].data.push(per);
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
                        text: 'AT (kVNĐ)'
                    },
                    xAxis: {
                        categories: categories
                    },
                    yAxis: {
                        title: {
                            text: ' '
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
        function chartLYAmt(url, data) {
            $.post(url, data, function (data) {
                var categories = [],
                    series = [
                        {
                            name: 'Target', type: 'column', data: [], color: '#4591f9'
                        },
                        {
                            name: 'Result', type: 'column', data: [], color: '#ff1800'
                        },
                        {
                            type: 'spline', name: '%', data: [], color: '#ffa50000', tooltip: { valueSuffix: '{.1f}%' }
                        }
                    ];
                var myArr = $.parseJSON(data);
                for (var i = 0; i < myArr.length; i++) {
                    categories.push(myArr[i].range);
                    var per = 0;
                    if (myArr[i].lastyearAmount > 0)
                        per = Math.round(parseFloat(myArr[i].actualAmount) / myArr[i].lastyearAmount * 100);

                    series[0].data.push(myArr[i].actualAmount);
                    series[1].data.push(myArr[i].lastyearAmount);
                    series[2].data.push(per);
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
                        text: 'ALY (kVNĐ)'
                    },
                    xAxis: {
                        categories: categories
                    },
                    yAxis: {
                        title: {
                            text: ' '
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
