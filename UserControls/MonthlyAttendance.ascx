<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="MonthlyAttendance.ascx.cs" Inherits="WebApplication.UserControls.MonthlyAttendance" %>
<fieldset class="scheduler-border" id="container_monthly_attendance" style="position: relative; margin: 0; display: none; float: right; width: calc(100% - 410px);">
    <legend class="scheduler-border" id="title_monthly_attendance"></legend>
    <%--<div class="back"><a class="btn btn-default" onclick="javascript: container_attendance_hide();">&lt; Back</a></div>--%>
    <div class="row marginTop20">
        <div class="form-group col-md-3">
            <label>Year</label>
            <div class="input-group">
                <dx:ASPxComboBox ID="cbYear" ClientInstanceName="cbYear_attendance" runat="server" Width="100%">
                    <ClientSideEvents SelectedIndexChanged="function(s,e){chart_monthly_attendance();}" />
                    <Items>
                    </Items>
                </dx:ASPxComboBox>
            </div>
        </div>
        <div class="form-group col-md-3">
            <label>Month</label>
            <div class="input-group">
                <dx:ASPxComboBox ID="cbMonth" ClientInstanceName="cbMonth_attendance" runat="server" Width="100%">
                    <ClientSideEvents SelectedIndexChanged="function(s,e){chart_monthly_attendance();}" />
                    <Items>
                    </Items>
                </dx:ASPxComboBox>
            </div>
        </div>
    </div>
    <div class="row marginTop20" style="float: left; min-height: 300px" id="chart_monthly_attendance">
    </div>
</fieldset>
<script>
    function chart_monthly_attendance() {
        var type = cbReportType.GetValue();
        var width = $('#container_monthly_attendance').width();
        $('#title_monthly_attendance').html("ATTENDANCE OUT BY " + type.toUpperCase());
        var data = { month: cbMonth_attendance.GetValue(), year: cbYear_attendance.GetValue(), username: hdfKey.Get("username"), by: type };
        ShowChart_Attendance("chart_monthly_attendance", "ATTENDANCE", "Số ca", "/Handler/MonthlyattendanceHandler.ashx", data, true, width);
    }
    function ShowChart_Attendance(id, tile, xAxisText, url, data, showlegend, width) {

        if (width == null)
            width = 1101;
        $.post(url, data, function (data) {

            var categories = [],
                series = [
                    { name: 'Plan', data: [], type: 'column', color: '#1c84b7', yAxis: 0, },
                    { name: 'Actual', data: [], type: 'column', color: '#37b9ff', yAxis: 0, },
                    { name: 'Change', data: [], type: 'column', color: '#c51919', yAxis: 0, }
                ];

            var myArr = $.parseJSON(data);
            for (var i = 0; i < myArr.length; i++) {
                categories.push(myArr[i].categories);
                series[0].data.push(myArr[i].Plan);
                series[1].data.push(myArr[i].Actual);
                series[2].data.push(myArr[i].Edit);

            }
            var chart = Highcharts.chart(id, {
                chart: {
                    height: 400,
                    width: width
                },
                title: {
                    text: tile
                },
                loading: {
                    hideDuration: 1000,
                    showDuration: 1000
                },
                legend: {
                    enabled: showlegend != null ? showlegend : true,
                    align: 'center',
                    backgroundColor: '#FFFFFF',
                    borderWidth: 1,
                    layout: 'horizontal', shadow: true,
                    verticalAlign: 'bottom'
                },
                plotOptions: {
                    column: {
                        cursor: 'pointer',
                        dataLabels: {
                            enabled: true,
                            formatter: function () { return ' ' + this.y; },
                            style: { fontSize: '11px' }
                        },

                    },
                    line: {
                        cursor: 'pointer',
                        dataLabels: { enabled: true, formatter: function () { return ' ' + this.y + '%'; } },

                    }
                },
                tooltip: { shared: true },
                xAxis: {
                    categories: categories,
                    labels: { autoRotation: 0 }
                },
                yAxis: [{
                    labels: { format: '{value}' },
                    title: { text: xAxisText }
                }, {
                    labels: { format: '{value}' },
                    min: 0,
                    opposite: true, title: { text: null }
                }],
                series: series,
                credits: { enabled: false }
            });

        });

    }
</script>
