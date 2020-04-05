<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="DailyAttendance.ascx.cs" Inherits="WebApplication.UserControls.DailyAttendance" %>
<fieldset class="scheduler-border" id="container_daily_attendance" style="position: relative; margin: 0; display: none; float: right; width: calc(100% - 410px);">
    <legend class="scheduler-border" id="title_attendance_daily"></legend>
    <%--<div class="back"><a class="btn btn-default" onclick="javascript: container_attendance_hide();">&lt; Back</a></div>--%>
    <div class="row marginTop20">
        <div class="form-group col-md-3">
            <label>From</label>
            <div class="input-group">
                <dx:ASPxDateEdit runat="server" ID="fFromDate" ClientInstanceName="fFromDate_attendance" DisplayFormatString="yyyy-MM-dd" OnInit="fFromDate_Init"
                    EditFormat="Custom" EditFormatString="yyyy-MM-dd">
                    <ClearButton DisplayMode="OnHover"></ClearButton>
                    <ClientSideEvents ValueChanged="function(s,e){chart_daily_attendance();}" />
                </dx:ASPxDateEdit>
            </div>
        </div>
        <div class="form-group col-md-3">
            <label>To</label>
            <div class="input-group">
                <dx:ASPxDateEdit runat="server" ID="fToDate" ClientInstanceName="fToDate_attendance" DisplayFormatString="yyyy-MM-dd" OnInit="fToDate_Init"
                    EditFormat="Custom" EditFormatString="yyyy-MM-dd">
                    <ClearButton DisplayMode="OnHover"></ClearButton>
                    <ClientSideEvents ValueChanged="function(s,e){chart_daily_attendance();}" />
                </dx:ASPxDateEdit>
            </div>
        </div>
    </div>
    <div class="row marginTop20" style="float: left; min-height: 300px" id="chart_daily_attendance" >
    </div> 
</fieldset>
<script> 
    function chart_daily_attendance() {
        var type = cbReportType.GetValue();
        $('#title_attendance_daily').html("ATTENDANCE BY " + type.toUpperCase());
        var data = { from: fFromDate_attendance.GetText(), to: fToDate_attendance.GetText(), username: hdfKey.Get("username"), by: type  };
        ShowChart_Daily_attendance("chart_daily_attendance", "ATTENDANCE", "Số ca", "/Handler/DailyAttendanceHandler.ashx", data, true);
         
    }
    function ShowChart_Daily_attendance(id, tile, xAxisText, url, data, showlegend) {
        var width = $('#container_daily_attendance').width();
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

