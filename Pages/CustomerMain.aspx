<%@ Page Title="Dashboard" Language="C#" 
    MasterPageFile="~/Layout.master" AutoEventWireup="true" CodeBehind="CustomerMain.aspx.cs" Inherits="WebApplication.Pages.CustomerMain" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Content" runat="server">
    <script src="/Scripts/highcharts.js"></script>
    <!--[if !IE]><!-->
    <link rel="stylesheet" type="text/css" href="/Content/all-ie-only.css" />
    <!--<![endif]-->
    <link rel="stylesheet" type="text/css" href="/Content/all.css" />
    <style>
        .card-body-icon {
            position: absolute;
            z-index: 0;
            top: -2.75rem;
            right: -1rem;
            opacity: 0.4;
            font-size: 10rem;
            -webkit-transform: rotate(15deg);
            transform: rotate(15deg);
        }

        .modal {
            position: initial;
            margin-top: 10px;
            cursor: pointer
        }


        .modal-dialog {
            width: 100%;
            margin: 0;
        }

        .modal-content {
            height: auto;
            box-shadow: none;
            border: 1px solid #efefef;
            /*color: white*/
        }

        .modal-header {
            padding: 10px;
        }

        .modal-body {
            height: 260px;
        }

            .modal-body a {
                font-size: 15px;
                float: left;
                margin-bottom: 5px;
                color: #000000;
                letter-spacing: 0.6px;
            }

            .modal-body i {
                margin-right: 10px
            }

        .modal-blue {
            /*background: #007bff !important*/
        }

        .modal-warning {
            /*background-color: #ffc107 !important;*/
        }

        .modal-green {
            /*background-color: #28a745 !important*/
        }

        .modal-red {
            /*background-color: #dc3545 !important*/
        }

        .modal-gray {
            background-color: #f1f1f1 !important
        }

        .modal-footer {
            padding: 5px
        }

        header {
            border-top: none !important;
            border-bottom: 5px solid #e60027;
        }

        .pull-right .panelItem:first-child {
            display: none
        }

        .b-title {
            background: linear-gradient(to right, #af2432 0%, #3d2e30 100%);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            font-weight: 700;
            font-size: 26px;
            display: inline;
        }

        .ie {
            color: #af2432 !important;
            background: none !important
        }

        .td-letter b {
            text-decoration: overline;
            font-size: 26px;
            display: inline;
            color: #a82432;
        }

        .footerDown {
            background: #d71e2b;
            border-bottom: 2px solid #500309;
            text-align: center;
            height: 78px;
            line-height: 46px;
        }

        td i {
            color: #af2432
        }

        td a:hover {
            text-decoration: none
        }

        .content {
            margin-bottom: 20px
        }

        .u-dashboard {
            margin: 0;
            padding: 0
        }

            .u-dashboard li {
                margin: 0;
                padding: 0;
                float: left;
                width: 32%;
                margin-right: 2%;
                margin-top: 25px;
                list-style: none
            }

                .u-dashboard li:nth-child(3), .u-dashboard li:nth-child(6) {
                    margin-right: 0
                }
        @media (max-width: 767px){
            .u-dashboard li {
                width: 100%;
                margin-right: 0;
            }
            .modal-body a{
                font-size: 18px;
            }
            .modal-body{
                height: auto
            }
        }
    </style>
    <asp:Literal ID="ltrmenu" runat="server"></asp:Literal>
    <dx:ASPxHiddenField ID="hdfKey" ClientInstanceName="hdfKey" runat="server"></dx:ASPxHiddenField>
    <script type="text/javascript"> 
        $(document).ready(function () {
            var ua = window.navigator.userAgent;
            var msie = ua.indexOf("MSIE ");
            if (msie > 0 || !!navigator.userAgent.match(/Trident.*rv\:11\./)) {
                $('p.b-title').addClass('ie');
            }
            ShowChart();
        });

        function ShowChart() {
            var data = { username: hdfKey.Get("userName") };
            var url = "/Handler/CustomerGetSellChartHandler.ashx";

            $.post(url, data, function (data) {

                var categories = [],
                    _series = [
                        {
                            name: 'Achieved', data: [], type: 'bar', color: '#ff0100', yAxis: 0,
                            dataLabels: {
                                color: "#000000",
                                enabled: false, formatter: function () { return ' ' + (this.y) + '%'; }
                            }, tooltip: {
                                valueSuffix: '%'
                            }
                        },
                        {
                            name: 'Amount', data: [], type: 'bar', color: '#f57e36', yAxis: 1
                            , tooltip: {
                                valueSuffix: ' kVND'
                            }, dataLabels: {
                                color: "#000000",
                                enabled: false
                            },
                            visible: false

                        },
                    ];
                var html = "";

                var myArr = $.parseJSON(data);
                var _max = 100;
                for (var i = 0; i < myArr.length; i++) {
                    categories.push(myArr[i].Area);
                    _series[0].data.push(parseInt(myArr[i].Per));

                    var ach = parseFloat(myArr[i].Achieved.split(',').join(''));
                    _series[1].data.push(ach);
                    html += "    <tr> <td >" + myArr[i].Area + "</td>  <td>" + myArr[i].Achieved + "</td>  <td>" + myArr[i].Remain + "</td>  </tr>";

                }
                $('#tbody_data').children().remove();
                $('#tbody_data').append(html);

                chart = new Highcharts.Chart({
                    chart: {
                        renderTo: 'container',
                        height: 300
                    },
                    credits: { enabled: false },
                    labels: {},
                    legend: {
                        enabled: false
                    },
                    plotOptions: {

                    },
                    title: { text: 'Sell out as of ' + hdfKey.Get("dateFormat") },
                    tooltip: { shared: true },
                    xAxis: {
                        categories: categories,
                        title: { text: '' }
                    },
                    yAxis: [{
                        min: 0,
                        labels: {
                            formatter: function () {
                                return this.value + '%';
                            }
                        },
                        title: { text: '' },
                        tickInterval: 10

                    }, {

                        min: 0,
                        opposite: true,
                        title: { text: 'kVND' }
                    }],
                    series: _series
                });
            });

        }
    </script>
</asp:Content>