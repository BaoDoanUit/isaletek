<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="MonthlyMarketShare.ascx.cs" Inherits="WebApplication.UserControls.MonthlyMarketShare" %>
<fieldset class="scheduler-border" id="container_monthly_martket" style="position: relative; margin: 0; display: none; float: right; width: calc(100% - 410px);">
    <legend class="scheduler-border" id="title_martket_monthly"></legend>
    <%--<div class="back"><a class="btn btn-default" onclick="javascript: container_martket_hide();">&lt; Back</a></div>--%>
    <div class="row marginTop20">
        <div class="form-group col-md-3">
            <label>Year</label>
            <div class="input-group">
                <dx:ASPxComboBox ID="cbYear" ClientInstanceName="cbYear_martket" runat="server" Width="100%">
                    <ClientSideEvents SelectedIndexChanged="function(s,e){chart_monthly_martket();}" />
                    <Items>
                    </Items>
                </dx:ASPxComboBox>
            </div>
        </div>
        <div class="form-group col-md-3">
            <label>Month</label>
            <div class="input-group">
                <dx:ASPxComboBox ID="cbMonth" ClientInstanceName="cbMonth_martket" runat="server" Width="100%">
                    <ClientSideEvents SelectedIndexChanged="function(s,e){chart_monthly_martket();}" />
                    <Items>
                    </Items>
                </dx:ASPxComboBox>
            </div>
        </div>
    </div>
    <div class='row' style="margin: 0; padding: 0" id="chart_martket"></div>
    <div class="row marginTop20" id="chart_martket_nodata">
        <div class="form-group col-md-12">
            <div class="box-item thumbnail  "><b>NO DATA!</b></div>
        </div>
    </div>
</fieldset>
<script> 
    function chart_monthly_martket() {
        var type_martket = cbReportType.GetValue();
        $('#title_martket_monthly').html("MARKET SHARE BY " + type_martket.toUpperCase());
        var data_martket = { month: cbMonth_martket.GetValue(), year: cbYear_martket.GetValue(), username: hdfKey.Get("username"), by: type_martket };
        ShowChart_martket("/Handler/MonthlyMarketShareHandler.ashx", data_martket);

    }
    function ShowChart_martket(url, data) {
        var width = $('#container_monthly_martket').width();
        $.post(url, data, function (data) {
            var myArr = $.parseJSON(data);
            if (myArr != null & myArr.length > 0) {
                $('#chart_martket').children().remove();
                for (var i = 0; i < myArr.length; i++) {
                    var id = 'container_martket_' + myArr[i].categories;
                    $('#chart_martket').append("  <div class='row marginTop20' id='" + id + "' ></div>");
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
                $('#chart_martket_nodata').hide();
            }
            else {
                $('#chart_martket').children().remove();
                $('#chart_martket_nodata').show();
            }
        });

    }
</script>
