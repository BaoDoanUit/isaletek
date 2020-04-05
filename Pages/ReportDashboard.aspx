<%@ Page Title="Dashboard" Language="C#" MasterPageFile="~/Layout.master" AutoEventWireup="true" CodeBehind="ReportDashboard.aspx.cs" Inherits="WebApplication.Pages.ReportDashboard" %>

<%@ Register Src="~/UserControls/MonthlySale.ascx" TagPrefix="uc1" TagName="MonthlySale" %>
<%@ Register Src="~/UserControls/DailySale.ascx" TagPrefix="uc1" TagName="DailySale" %>
<%@ Register Src="~/UserControls/MonthlyMarketShare.ascx" TagPrefix="uc1" TagName="MonthlyMarketShare" %>
<%@ Register Src="~/UserControls/DailyMarketShare.ascx" TagPrefix="uc1" TagName="DailyMarketShare" %>
<%@ Register Src="~/UserControls/DailyAttendance.ascx" TagPrefix="uc1" TagName="DailyAttendance" %>
<%@ Register Src="~/UserControls/MonthlyAttendance.ascx" TagPrefix="uc1" TagName="MonthlyAttendance" %>


<asp:Content ID="Content1" ContentPlaceHolderID="Content" runat="server">
    <script src="/Scripts/jquery-1.12.2.min.js"></script>
    <script src="/Scripts/highcharts.js"></script>
    <script src="/Scripts/highcharts-3d.js"></script>
    <script src="/Scripts/highcharts-more.js"></script>
    <script>
        $(document).ready(function () {
            $('#div_sale').click(function () {
                openChart();
                container_sale_show();
            });
            $('#div_market').click(function () {
                openChart();
                container_martket_show();
            });
            $('#div_attendance').click(function () {
                var type = cbReportType.GetValue();
                if (type === "Product") {
                    alert("Report Attendance do not support type Product!")
                    return;
                }
                else {
                    openChart();
                    container_attendance_show();
                }
            });
        });
        function openChart() {
            $('#container_main').css({
                "display": "block",
                "float": "left",
                "margin-left": "10px",
                "width": "400px"
            });
            $('.container').css({
                "width": "100%"
            });
            $('.modal-content').css({
                "height": "auto"
            });
            $.each($('#container_main .form-group'), function (i, o) {
                var elment = $(o);
                if (elment != null) {
                    elment.removeClass();
                    elment.addClass("form-group col-md-12");
                }
            });
        }
        function container_sale_show() {
            var by = cbReportBy.GetValue();
            container_chart_hide();
            if (by === "Monthly") {
                $('#container_monthly_sales').fadeIn(300);
                $('#container_daily_sale').fadeOut(300);
                chart_monthly_sale();
            }
            else if (by === "Daily") {
                $('#container_monthly_sales').fadeOut(300);
                $('#container_daily_sale').fadeIn(300);
                chart_daily_sale();
            }
        }
        function container_chart_hide() {
            $('#container_monthly_sales').fadeOut(300);
            $('#container_daily_sale').fadeOut(300);
            $('#container_monthly_martket').fadeOut(300);
            $('#container_daily_martket').fadeOut(300);
            $('#container_monthly_attendance').fadeOut(300);
            $('#container_daily_attendance').fadeOut(300);
        }
        function container_martket_show() {
            var by = cbReportBy.GetValue();
            container_chart_hide();
            if (by === "Monthly") {
                $('#container_monthly_martket').fadeIn(300);
                $('#container_daily_martket').fadeOut(300);
                chart_monthly_martket();
            }
            else if (by === "Daily") {
                $('#container_monthly_martket').fadeOut(300);
                $('#container_daily_martket').fadeIn(300);
                chart_daily_martket();
            }
        }

        function container_attendance_show() {
            var by = cbReportBy.GetValue();
            container_chart_hide();
            if (by === "Monthly") {
                $('#container_monthly_attendance').fadeIn(300);
                $('#container_daily_attendance').fadeOut(300);
                chart_monthly_attendance();
            }
            else if (by === "Daily") {
                $('#container_monthly_attendance').fadeOut(300);
                $('#container_daily_attendance').fadeIn(300);
                chart_daily_attendance();
            }
        }
    </script>
    <style>
        .box {
            min-height: 150px;
            position: relative;
            cursor: pointer
        }


        .back {
            position: absolute;
            top: 45px;
            right: 45px;
            z-index: 1501;
        }


        .form-group {
            margin: 0
        }

        .box.row {
            margin: 0
        }

        .box b {
            width: 100%;
            text-align: center;
            float: left;
            font-size: 18px;
            margin-top: 30px
        }

        .box .box-item {
            float: left
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
            height: 200px;
            box-shadow: none;
            border: 1px solid rgb(254, 178, 101);
    -webkit-box-shadow: 0px 2px 0px 2px rgba(255, 129, 0, 0.6);
    box-shadow: 0px 2px 0px 2px rgba(255, 129, 0, 0.6);
        }
        .modal-body {
    padding: 25px 15px;
}
        .modal-header {
            padding: 10px;
        }

        .btn {
            padding: 3px 9px;
            font-size: 13px;
        }
        .input-group{
            width: 100%
        }
        .modal-title{
            line-height:1.5
        }
    </style>
    <fieldset class="scheduler-border" id="container_main">
        <legend class="scheduler-border">Summary</legend>
        <div class="row" style="width: 100%" id="container_filter">
            <div class="form-group col-md-3">
                <label>Report by</label>
                <div class="input-group">
                    <dx:ASPxComboBox ID="cbReportBy" ClientInstanceName="cbReportBy" runat="server" Width="100%">
                        <Items>
                            <dx:ListEditItem Value="Daily" Text="Daily" />
                            <dx:ListEditItem Selected="True" Value="Monthly" Text="Monthly" />
                            <%--<dx:ListEditItem Value="3" Text="Yearly" />--%>
                        </Items>
                    </dx:ASPxComboBox>
                </div>
            </div>
            <div class="form-group col-md-3">
                <label>Report Type</label>
                <div class="input-group">
                    <dx:ASPxComboBox ID="cbReportType" ClientInstanceName="cbReportType" runat="server" Width="100%">
                        <Items>
                            <dx:ListEditItem Value="Product" Selected="True" Text="Product" />
                            <dx:ListEditItem Value="Region" Text="Region" />
                            <dx:ListEditItem Value="Account" Text="Account" />
                        </Items>
                    </dx:ASPxComboBox>
                </div>
            </div>
        </div>
        <div style="text-align: right; margin-top: 10px; color:#2196F3; font-size: 15px"><a><%:"Today: " + DateTime.Now.ToString("yyyy-MM-dd") %></a></div>
        <div class="row marginTop10 marginBot20">
            <div class="form-group col-md-4">
                <div class="modal" style="display: block; overflow: inherit" role="dialog" id="div_sale">
                    <div class="modal-dialog">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h4 class="modal-title"><b style="font-size: 18px;">SELL OUT</b>
                                    <a style="float: right; height: 30px;border-color: #00ceff;line-height: 22px; font-size: 12px" class="btn btn-default">View Dashboard</a>
                                </h4>
                            </div>
                            <div class="modal-body">
                                <p>
                                    <b>Number: </b>
                                    <asp:Label ID="lblNumber" runat="server" Text="0"></asp:Label>
                                </p>
                                <p>
                                    <b>Value:</b>
                                    <asp:Label ID="lblValue" runat="server" Text="0"></asp:Label>
                                </p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="form-group col-md-4">
                <div class="modal" style="display: block; overflow: inherit" role="dialog" id="div_market">
                    <div class="modal-dialog">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h4 class="modal-title"><b style="font-size: 18px;">MARKET SHARE</b>
                                    <a style="float: right; height: 30px;border-color: #00ceff;line-height: 22px; font-size: 12px" class="btn btn-default">View Dashboard</a>
                                </h4>
                            </div>
                            <div class="modal-body">
                                <p>
                                    <b>Hitachi: </b>
                                    <asp:Label ID="lblmartket" runat="server" Text="0"></asp:Label>
                                </p>

                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="form-group col-md-4">
                <div class="modal" style="display: block; overflow: inherit" role="dialog" id="div_attendance">
                    <div class="modal-dialog">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h4 class="modal-title"><b style="font-size: 18px;">ATTENDANCE</b>
                                    <a style="float: right; height: 30px;border-color: #00ceff;line-height: 22px; font-size: 12px" class="btn btn-default">View Dashboard</a>
                                </h4>
                            </div>
                            <div class="modal-body">
                                <p>
                                    <b>Plan: </b>
                                    <asp:Label ID="lblPlan" runat="server" Text="0"></asp:Label>
                                </p>
                                <p>
                                    <b>Actual: </b>
                                    <asp:Label ID="lblActual" runat="server" Text="0"></asp:Label>
                                </p>
                                <p>
                                    <b>Change: </b>
                                    <asp:Label ID="lblChange" runat="server" Text="0"></asp:Label>
                                </p>

                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </fieldset>
    <uc1:MonthlySale runat="server" ID="MonthlySale" />
    <uc1:DailySale runat="server" ID="DailySale" />
    <uc1:MonthlyMarketShare runat="server" ID="MonthlyMarketShare" />
    <uc1:DailyMarketShare runat="server" ID="DailyMarketShare" />
    <uc1:MonthlyAttendance runat="server" ID="MonthlyAttendance" />
    <uc1:DailyAttendance runat="server" ID="DailyAttendance" />


    <dx:ASPxHiddenField ID="hdfKey" ClientInstanceName="hdfKey" runat="server"></dx:ASPxHiddenField>
</asp:Content>
