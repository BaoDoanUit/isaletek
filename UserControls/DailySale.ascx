<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="DailySale.ascx.cs" Inherits="WebApplication.UserControls.DailySale" %>
<fieldset class="scheduler-border" id="container_daily_sale" style="position: relative; margin: 0; display: none; float: right; width: calc(100% - 410px);">
    <legend class="scheduler-border" id="title_sale_daily"></legend>
    <%--<div class="back"><a class="btn btn-default" onclick="javascript: container_sale_hide();">&lt; Back</a></div>--%>
    <div class="row marginTop20">
        <div class="form-group col-md-3">
            <label>From</label>
            <div class="input-group">
                <dx:ASPxDateEdit runat="server" ID="fFromDate" ClientInstanceName="fFromDate" DisplayFormatString="yyyy-MM-dd" OnInit="fFromDate_Init"
                    EditFormat="Custom" EditFormatString="yyyy-MM-dd">
                    <ClearButton DisplayMode="OnHover"></ClearButton>
                    <ClientSideEvents ValueChanged="function(s,e){chart_daily_sale();}" />
                </dx:ASPxDateEdit>
            </div>
        </div>
        <div class="form-group col-md-3">
            <label>To</label>
            <div class="input-group">
                <dx:ASPxDateEdit runat="server" ID="fToDate" ClientInstanceName="fToDate" DisplayFormatString="yyyy-MM-dd" OnInit="fToDate_Init"
                    EditFormat="Custom" EditFormatString="yyyy-MM-dd">
                    <ClearButton DisplayMode="OnHover"></ClearButton>
                    <ClientSideEvents ValueChanged="function(s,e){chart_daily_sale();}" />
                </dx:ASPxDateEdit>
            </div>
        </div>
    </div>
    <div class="row marginTop20"  >
        <div class="form-group col-md-6" id="chart_daily_sale_value" style="float: left; min-height: 300px"></div>
        <div class="form-group col-md-6" id="chart_daily_sale_quantity" style="float: left; min-height: 300px"></div>
    </div>
   
</fieldset>
<script> 
    function chart_daily_sale() {
        var type = cbReportType.GetValue();
        $('#title_sale_daily').html("SELL OUT BY " + type.toUpperCase());
        var data = { from: fFromDate.GetText(), to: fToDate.GetText(), username: hdfKey.Get("username"), by: type + '-Price' };
        ShowChart_Daily_sale("chart_daily_sale_value", "SELL OUT VALUE", "Triệu VNĐ", "/Handler/DailySaleHandler.ashx", data, false);

        var data2 = { from: fFromDate.GetText(), to: fToDate.GetText(), username: hdfKey.Get("username"), by: type + '-Quantity' };
        ShowChart_Daily_sale("chart_daily_sale_quantity", "SELL OUT NUMBER", "Số lượng", "/Handler/DailySaleHandler.ashx", data2, false);
    }
    function ShowChart_Daily_sale(id, tile, xAxisText, url, data, showlegend) {
        var width = $('#container_daily_sale').width() / 2;
        $.post(url, data, function (data) {

            var isLoading = false;
            var categories = [],
                series = [
                    { name: 'value', data: [], type: 'column', color: '#c51919', yAxis: 0, pointWidth: 30 }
                ];


            var myArr = $.parseJSON(data);
            for (var i = 0; i < myArr.length; i++) {
                categories.push(myArr[i].categories);
                series[0].data.push(myArr[i].value);

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
