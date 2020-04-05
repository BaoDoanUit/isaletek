<%@ Page Title="Task" Language="C#" MasterPageFile="~/Layout.master" AutoEventWireup="true" CodeBehind="TaskReport.aspx.cs" Inherits="WebApplication.Pages.TaskReport" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Content" runat="server">
    <script src="https://code.highcharts.com/highcharts.js"></script>
    <script src="https://code.highcharts.com/modules/series-label.js"></script>
    <script src="https://code.highcharts.com/modules/exporting.js"></script>
    <script src="https://code.highcharts.com/modules/export-data.js"></script>
    <style>
        fieldset.scheduler-border {
            background-color: rgba(227, 229, 229, 0.09);
            border: 1px groove #ddd !important;
            padding: 0 1em 1em 1em !important;
            margin: 0 0 1.5em 0 !important;
            -webkit-box-shadow: 0px 0px 0px 0px #000;
            box-shadow: 0px 0px 0px 0px #000;
        }

        legend.scheduler-border {
            font-size: 1.2em !important;
            font-weight: bold !important;
            text-align: left !important;
            width: auto;
            padding: 10px 10px 0 10px;
            border-bottom: none;
        }

        .legend {
            margin-bottom: 10px
        }

        .dxeRadioButtonList_Moderno {
            border: none !important
        }

        .dxeCaption_Moderno {
            font-weight: 600;
        }

        .highcharts-exporting-group, .highcharts-credits {
            display: none
        }

        .dxEditors_edtRadioButtonUnchecked_Moderno {
            background-position: -18px -18px !important;
            width: 18px !important;
            height: 18px !important;
        }

        .dxEditors_edtRadioButtonUnchecked_Moderno, .dxEditors_edtRadioButtonChecked_Moderno {
            background-size: 36px !important;
        }

        .dxEditors_edtRadioButtonChecked_Moderno {
            background-position: 0 0 !important;
            width: 18px !important;
            height: 18px !important;
        }

        .dxeRoot_Moderno td:first-child {
            width: 85px
        }

        .dxeRoot_Moderno td:last-child {
            width: calc(100% - 85px)
        }

        .dxeRadioButtonList_Moderno td {
            width: auto !important
        }

        .chart {
            margin: 0;
            padding: 0;
        }

            .chart li {
                float: left;
                list-style: none;
                margin-bottom: 15px
            }
        /*.chart li:nth-child(2n+1){
            width: 60%;
        }
        .chart li:nth-child(2n){
            width: 40%;
        }*/
        .pl-0 {
            padding-left: 0 !important
        }
        tspan{
            font-family: "Helvetica Neue",Helvetica,Arial,sans-serif;
        }
    </style>
    <script type="text/javascript">
        $(document).ready(function () {
            svchart();
        })
    </script>
    <%--<script type="text/javascript">
        $(document).ready(function () {
            var pieColors = (function () {
                var colors = [],
                    base = Highcharts.getOptions().colors[0],
                    i;

                for (i = 0; i < 10; i += 1) {
                    // Start out with a darkened base color (negative brighten), and end
                    // up with a much brighter color
                    colors.push(Highcharts.Color(base).brighten((i - 3) / 7).get());
                }
                return colors;
            }());

            // cau 1
            Highcharts.chart('chart1', {
                chart: {
                    plotBackgroundColor: null,
                    plotBorderWidth: null,
                    plotShadow: false,
                    type: 'pie'
                },
                title: {
                    text: 'Câu 1: Sản phẩm tủ lạnh của Hitachi có cần phải dán POP ở siêu thị không?'
                },
                tooltip: {
                    pointFormat: '{series.name}: <b>{point.percentage:.1f}%</b>'
                },
                plotOptions: {
                    pie: {
                        allowPointSelect: true,
                        cursor: 'pointer',
                        colors: pieColors,
                        dataLabels: {
                            enabled: true,
                            format: '<b>{point.name}</b><br>{point.percentage:.1f} %',
                            distance: -50,
                            filter: {
                                property: 'percentage',
                                operator: '>',
                                value: 4
                            }
                        }
                    }
                },
                series: [{
                    name: 'Câu 1',
                    data: [
                        { name: 'Yes', y: <% =num1yes %>, color: '#e67224' },
                        { name: 'No', y: <% =num1no %>, color: '#4472c4' }
                    ]
                }]
            });
            // cau 2
            Highcharts.chart('chart2', {
                chart: {
                    plotBackgroundColor: null,
                    plotBorderWidth: null,
                    plotShadow: false,
                    type: 'pie'
                },
                title: {
                    text: 'Câu 2: Khách hàng có yêu cầu nhất thiết phải có POP khi mua hàng không?'
                },
                tooltip: {
                    pointFormat: '{series.name}: <b>{point.percentage:.1f}%</b>'
                },
                plotOptions: {
                    pie: {
                        allowPointSelect: true,
                        cursor: 'pointer',
                        colors: pieColors,
                        dataLabels: {
                            enabled: true,
                            format: '<b>{point.name}</b><br>{point.percentage:.1f} %',
                            distance: -50,
                            filter: {
                                property: 'percentage',
                                operator: '>',
                                value: 4
                            }
                        }
                    }
                },
                series: [{
                    name: 'Câu 2',
                    data: [
                        { name: 'Yes', y: <% =num2yes %>, color: '#e67224' },
                        { name: 'No', y: <% =num2no %>, color: '#4472c4' }
                    ]
                }]
            });
            // cau 4
            Highcharts.chart('chart4', {
                chart: {
                    plotBackgroundColor: null,
                    plotBorderWidth: null,
                    plotShadow: false,
                    type: 'pie'
                },
                title: {
                    text: 'Câu 4: Sản phẩm trưng bày bao lâu thì sẽ bị thay thế?'
                },
                tooltip: {
                    pointFormat: '{series.name}: <b>{point.percentage:.1f}%</b>'
                },
                plotOptions: {
                    pie: {
                        allowPointSelect: true,
                        cursor: 'pointer',
                        colors: pieColors,
                        dataLabels: {
                            enabled: true,
                            format: '<b>{point.name}</b><br>{point.percentage:.1f} %',
                            distance: -50,
                            filter: {
                                property: 'percentage',
                                operator: '>',
                                value: 4
                            }
                        }
                    }
                },
                series: [{
                    name: 'Câu 4',
                    data: [
                        { name: '1 tuần', y: <% =num41tuan %>, color: '#e67224' },
                        { name: '1 tháng', y: <% =num41thang %>, color: '#8085e9' },
                        { name: '3 tháng', y: <% =num43thang %>, color: '#7cb5ec' },
                        { name: '6 tháng', y: <% =num46thang %>, color: '#4472c4' }
                    ]
                }]
            });

            // câu 3
            Highcharts.chart('chart3', {
                chart: {
                    type: 'column'
                },
                title: {
                    text: 'Câu 3: Nếu không thể dán POP hết, thì theo bạn dòng nào không cần dán POP?'
                },
                xAxis: {
                    categories: ['TF<300L', 'TF>300L', 'TF>400L', 'Bottom freezer', 'Big4', 'SBS']
                },
                yAxis: {
                    min: 0,
                    title: {
                        text: ' '
                    }
                },
                tooltip: {
                    pointFormat: '<span style="color:{series.color}">{series.name}</span>: <b>{point.y}</b> ({point.percentage:.1f} %)<br/>',
                    shared: true
                },
                plotOptions: {
                    column: {
                        stacking: 'percent',
                        dataLabels: {
                            enabled: true,
                            format: '<b>{point.name}</b><br>{point.percentage:.1f} %',
                            distance: -50,
                        }
                    }
                },
                series: [{
                    name: 'Yes',
                    data: [<% =num3yes %>],
                    color: '#e67224'
                }, {
                    name: 'No',
                    data: [<% =num3no %>],
                    color: '#4472c4'
                }]
            });
            // câu 3
            Highcharts.chart('chart5', {
                chart: {
                    type: 'column'
                },
                title: {
                    text: 'Câu 5: Sản phẩm của hãng nào khi mở thùng ra đã có dán POP?'
                },
                xAxis: {
                    categories: ['Samsung', 'Panasonic', 'Toshiba', 'LG', 'Sharp', 'Khác']
                },
                yAxis: {
                    min: 0,
                    title: {
                        text: ' '
                    }
                },
                tooltip: {
                    pointFormat: '<span style="color:{series.color}">{series.name}</span>: <b>{point.y}</b> ({point.percentage:.1f} %)<br/>',
                    shared: true
                },
                plotOptions: {
                    column: {
                        stacking: 'percent',
                        dataLabels: {
                            enabled: true,
                            format: '<b>{point.name}</b><br>{point.percentage:.1f} %',
                            distance: -50,
                        }
                    }
                },
                series: [{
                    name: 'Yes',
                    data: [<% =num5yes %>],
                    color: '#e67224'
                }, {
                    name: 'No',
                    data: [<% =num5no %>],
                    color: '#4472c4'
                    }]
            });
        })
    </script>--%>
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <div class="row filter">
                <div class="col-md-12">
                    <fieldset class="scheduler-border">
                        <legend class="scheduler-border">Search</legend>
                        <div class="row">
                            <div class="col-md-4">
                                <dx:ASPxComboBox Caption="Survey *" Width="100%" runat="server" ID="cbSurvey" ValueField="Id" ValueType="System.Int32" NullText="--All--"
                                    ClientInstanceName="cbSurvey" DropDownStyle="DropDownList">
                                    <ClearButton DisplayMode="Always"></ClearButton>
                                    <Columns>
                                        <dx:ListBoxColumn FieldName="TaskName" Caption="Survey" />
                                    </Columns>
                                </dx:ASPxComboBox>
                            </div>
                            <div class="col-md-3">
                                <dx:ASPxButton ID="FilterButton" OnClick="FilterButton_Click" CssClass="btn btn-primary" runat="server" Text="Search">
                                </dx:ASPxButton>
                                <dx:ASPxButton ID="ExportButton" OnClick="ExportButton_Click" CssClass="btn btn-warning" runat="server" Text="Export">
                                </dx:ASPxButton>
                            </div>
                        </div>
                    </fieldset>
                </div>
            </div>
            <div class="row">
                <div class="col-md-12" style="position: relative">
                    <ul class="chart">
                        <asp:Literal ID="ltrSurvey" runat="server"></asp:Literal>
                    </ul>
                </div>
            </div>
        </ContentTemplate>
    </asp:UpdatePanel>
    <script type="text/javascript">
        var requestManager = Sys.WebForms.PageRequestManager.getInstance();
        requestManager.add_endRequest(function () {
            svchart(); cbSurvey.SetEnabled(true);
        });
    </script>
</asp:Content>
