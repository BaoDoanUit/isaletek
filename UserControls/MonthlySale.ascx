<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="MonthlySale.ascx.cs" Inherits="WebApplication.UserControls.MonthlySale" %>
<fieldset class="scheduler-border" id="container_monthly_sales" style="position: relative; margin: 0; display: none; float: right; width: calc(100% - 410px);">
    <legend class="scheduler-border" id="title"></legend>
    <%--<div class="back"><a class="btn btn-default" onclick="javascript: container_sale_hide();">&lt; Back</a></div>--%>
    <div class="row marginTop20">
        <div class="form-group col-md-3">
            <label>Year</label>
            <div class="input-group">
                <dx:ASPxComboBox ID="cbYear" ClientInstanceName="cbYear" runat="server" Width="100%">
                    <ClientSideEvents SelectedIndexChanged="function(s,e){chart_monthly_sale();}" />
                    <Items>
                    </Items>
                </dx:ASPxComboBox>
            </div>
        </div>
        <div class="form-group col-md-3">
            <label>Month</label>
            <div class="input-group">
                <dx:ASPxComboBox ID="cbMonth" ClientInstanceName="cbMonth" runat="server" Width="100%">
                    <ClientSideEvents SelectedIndexChanged="function(s,e){chart_monthly_sale();}" />
                    <Items>
                    </Items>
                </dx:ASPxComboBox>
            </div>
        </div>
    </div>
    <div class="row marginTop20">
        <div class="form-group col-md-6" id="chart_monthly_sale_value" style="float: left; min-height: 300px"></div>
        <div class="form-group col-md-6" id="chart_monthly_sale_quantity" style="float: left; min-height: 300px"></div>
    </div>
</fieldset>
<script>
    function chart_monthly_sale() {
        var type = cbReportType.GetValue();
        var width = $('#container_monthly_sales').width() / 2;
        $('#title').html("SELL OUT BY " + type.toUpperCase());
        var data = { month: cbMonth.GetValue(), year: cbYear.GetValue(), username: hdfKey.Get("username"), by: type + '-Price' };
        ShowChart("chart_monthly_sale_value", "SELL OUT VALUE", "Triệu VNĐ", "/Handler/MonthlySaleHandler.ashx", data, false, width);

        var data2 = { month: cbMonth.GetValue(), year: cbYear.GetValue(), username: hdfKey.Get("username"), by: type + '-Quantity' };
        ShowChart("chart_monthly_sale_quantity", "SELL OUT NUMBER", "Số lượng", "/Handler/MonthlySaleHandler.ashx", data2, false, width);
    }
    function ShowChart(id, tile, xAxisText, url, data, showlegend, width) {

        if (width == null)
            width = 1101;
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
