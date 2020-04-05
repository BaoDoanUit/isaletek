<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="DailyMarketShare.ascx.cs" Inherits="WebApplication.UserControls.DailyMarketShare" %>

<fieldset class="scheduler-border" id="container_daily_martket" style="position: relative; margin: 0; display: none; float: right; width: calc(100% - 410px);">
    <legend class="scheduler-border" id="title_martket_daily"></legend>
    <%--<div class="back"><a class="btn btn-default" onclick="javascript: container_martket_hide();">&lt; Back</a></div>--%>
    <div class="row marginTop20">
        <div class="form-group col-md-3">
            <label>From</label>
            <div class="input-group">
                <dx:ASPxDateEdit runat="server" ID="fFromDate" ClientInstanceName="fFromDate_market" DisplayFormatString="yyyy-MM-dd" OnInit="fFromDate_Init"
                    EditFormat="Custom" EditFormatString="yyyy-MM-dd">
                    <ClearButton DisplayMode="OnHover"></ClearButton>
                    <ClientSideEvents ValueChanged="function(s,e){chart_daily_martket();}" />
                </dx:ASPxDateEdit>
            </div>
        </div>
        <div class="form-group col-md-3">
            <label>To</label>
            <div class="input-group">
                <dx:ASPxDateEdit runat="server" ID="fToDate" ClientInstanceName="fToDate_market" DisplayFormatString="yyyy-MM-dd" OnInit="fToDate_Init"
                    EditFormat="Custom" EditFormatString="yyyy-MM-dd">
                    <ClearButton DisplayMode="OnHover"></ClearButton>
                    <ClientSideEvents ValueChanged="function(s,e){chart_daily_martket();}" />
                </dx:ASPxDateEdit>
            </div>
        </div>
    </div>
    <div class='row' style="margin: 0; padding: 0" id="chart_martket_daily"></div>
    <div class="row marginTop20" id="chart_martket_daily_nodata">
        <div class="form-group col-md-12">
            <div class="box-item thumbnail  "><b>NO DATA!</b></div>
        </div>
    </div>
</fieldset>

<script> 
    function chart_daily_martket() {
        var type_martket = cbReportType.GetValue();
        $('#title_martket_daily').html("MARKET SHARE BY " + type_martket.toUpperCase());
        var data_martket = { from: fFromDate_market.GetText(), to: fToDate_market.GetText(), username: hdfKey.Get("username"), by: type_martket };
        ShowChart_daily_martket("/Handler/DailyMarketShareHandler.ashx", data_martket);

    }
    function ShowChart_daily_martket(url, data) {
        var width = $('#container_daily_martket').width();
        $.post(url, data, function (data) {
            var myArr = $.parseJSON(data);
            if (myArr != null & myArr.length > 0) {
                $('#chart_martket_daily').children().remove();
                for (var i = 0; i < myArr.length; i++) {
                    var id = 'container_martket_daily_' + myArr[i].categories;
                    $('#chart_martket_daily').append("  <div class='row marginTop20' id='" + id + "' ></div>");
                    Highcharts.chart(id, {
                        chart: {
                            plotBackgroundColor: null,
                            plotBorderWidth: null,
                            plotShadow: false,
                            type: 'pie',
                            height: 400,
                            width: width,
                            options3d: {
                                enabled: true,
                                alpha: 45,
                                beta: 0
                            }
                        },

                        title: {
                            text: 'MARTKET SHARE BY ' + myArr[i].categories
                        },
                        tooltip: {
                            pointFormat: '{series.name}: <span>{point.percentage:.1f}%</span>'
                        },
                        plotOptions: {
                            pie: {
                                allowPointSelect: true,
                                cursor: 'pointer',
                                depth: 35,
                                dataLabels: {
                                    enabled: true,
                                    format: '<span>{point.name}</span>: {point.percentage:.1f} %',
                                    style: {
                                        color: (Highcharts.theme && Highcharts.theme.contrastTextColor) || 'black'
                                    }
                                }
                            }
                        },
                        series: [{
                            name: '%',
                            colorByPoint: true,
                            data: myArr[i].data
                        }],
                        credits: { enabled: false }
                    });
                }
                $('#chart_martket_daily_nodata').hide();
            }
            else {
                $('#chart_martket_daily').children().remove();
                $('#chart_martket_daily_nodata').show();
            }
        });

    }
</script>
