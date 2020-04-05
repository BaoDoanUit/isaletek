<%@ Page Title="PC Profile" Language="C#" MasterPageFile="~/Pages/PCDesktop/PCMaster.Master" AutoEventWireup="true" CodeBehind="PCProfile.aspx.cs" Inherits="WebApplication.Pages.PCDesktop.PCProfile" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Content" runat="server">
    <script src="/Scripts/jquery-1.12.2.min.js"></script>
    <script src="/Scripts/highcharts.js"></script>
    <script src="/Scripts/highcharts-3d.js"></script>
    <script src="/Scripts/highcharts-more.js"></script>
    <script>
        $(document).ready(function () {
            $("#TopPanel_NavMenu ul li:eq(0)").addClass("dxm-selected");

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

        .input-group {
            width: 100%
        }

        .modal-title {
            line-height: 1.5
        }
        .modal-body span{
            text-decoration: underline;
            padding-left: 5px;
        }
    </style>
    <fieldset class="scheduler-border" id="container_main">
        <legend class="scheduler-border">Summary</legend>
        <div class="row" id="container_filter">
            <div class="form-group col-md-6">
                <label>Thông tin nhân viên</label>
                <div class="row">
                    <div class="col-md-4">
                        <asp:Literal ID="ltr1" runat="server"></asp:Literal>
                    </div>
                    <div class="col-md-8">
                        <asp:Literal ID="ltr2" runat="server"></asp:Literal>
                    </div>
                </div>
                <div class="row marginTop10">
                    <div class="col-md-12">
                        <asp:Literal ID="ltr3" runat="server"></asp:Literal>
                    </div>
                </div>
                <div class="row marginTop10">
                    <div class="col-md-4">
                        <asp:Literal ID="ltr4" runat="server"></asp:Literal>
                    </div>
                    <div class="col-md-8">
                        <asp:Literal ID="ltr5" runat="server"></asp:Literal>
                    </div>
                </div>
            </div>
            <div class="form-group col-md-6">
                <label>Manner</label>
                <div class="row">
                    <div class="col-md-12">
                        <table class="table table-bordered">
                            <thead>
                                <tr>
                                    <th>Month</th>
                                    <th>T11</th>
                                    <th>T12</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td>Points</td>
                                    <td>update</td>
                                    <td>update</td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
        <div class="row marginTop10 marginBot20">
            <div class="form-group col-md-4">
                <div class="modal" style="display: block; overflow: inherit;" role="dialog" id="div_management">
                    <div class="modal-dialog">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h4 class="modal-title"><b style="font-size: 18px;">ATTENDENCE</b>
                                    <a style="float: right; height: 30px; border-color: #00ceff; line-height: 22px; font-size: 12px" class="btn btn-default">Xem chi tiết</a>
                                </h4>
                            </div>
                            <div class="modal-body">
                                <div class="row">
                                    <div class="col-md-6">
                                        <p>
                                            <b>Số ngày theo lịch: </b>
                                            <asp:Label ID="lb0" runat="server" Text=""></asp:Label>
                                        </p>
                                    </div>
                                    <div class="col-md-6">
                                        <p>
                                            <b>Số ngày làm: </b>
                                            <asp:Label ID="lb1" runat="server" Text=""></asp:Label>
                                        </p>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-6">
                                        <p>
                                            <b>OFF: </b>
                                            <asp:Label ID="lb2" runat="server" Text="0"></asp:Label>
                                        </p>
                                    </div>
                                    <div class="col-md-6">
                                        <p>
                                            <b>Ontime: </b>
                                            <asp:Label ID="lb3" runat="server" Text="0"></asp:Label>
                                        </p>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-6">
                                        <p>
                                            <b>Late/Early: </b>
                                            <asp:Label ID="lb4" runat="server" Text="0"></asp:Label>
                                        </p>
                                    </div>
                                    <div class="col-md-6">
                                        <p>
                                            <b>NA: </b>
                                            <asp:Label ID="lb5" runat="server" Text="0"></asp:Label>
                                        </p>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-12">
                                        <p>
                                            <b>Hôm nay: </b>
                                            <asp:Label ID="lb6" runat="server" Text=""></asp:Label>
                                            <asp:Label ID="lb7" runat="server" Text=""></asp:Label>
                                        </p>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="form-group col-md-4" style="display: none">
                <div class="modal" style="display: block; overflow: inherit" role="dialog" id="div_display">
                    <div class="modal-dialog">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h4 class="modal-title"><b style="font-size: 18px;">DISPLAY</b>
                                    <a style="float: right; height: 30px; border-color: #00ceff; line-height: 22px; font-size: 12px" class="btn btn-default">Xem chi tiết</a>
                                </h4>
                            </div>
                            <div class="modal-body">
                                <p>
                                    <b>
                                        <asp:Literal ID="ltrdate1" runat="server"></asp:Literal> </b>
                                    <asp:Label ID="lb8" runat="server" Text=""></asp:Label>
                                </p>
                                <p>
                                    <b>Hôm nay: </b>
                                    <asp:Label ID="lb9" runat="server" Text=""></asp:Label>
                                </p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="form-group col-md-4">
                <div class="modal" style="display: block; overflow: inherit" role="dialog" id="div_sale">
                    <div class="modal-dialog">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h4 class="modal-title"><b style="font-size: 18px;">SELL OUT</b>
                                    <a style="float: right; height: 30px; border-color: #00ceff; line-height: 22px; font-size: 12px" class="btn btn-default">Xem chi tiết</a>
                                </h4>
                            </div>
                            <div class="modal-body">
                                <p>
                                    <b>
                                        <asp:Literal ID="ltrdate2" runat="server"></asp:Literal> </b>
                                    <asp:Label ID="lb10" runat="server" Text=""></asp:Label>
                                </p>
                                <p>
                                    <b>Hôm nay: </b>
                                    <asp:Label ID="lb11" runat="server" Text=""></asp:Label>
                                </p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="form-group col-md-4">
                <div class="modal" style="display: block; overflow: inherit; margin-top: 20px" role="dialog" id="div_market">
                    <div class="modal-dialog">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h4 class="modal-title"><b style="font-size: 18px;">MARKET</b>
                                    <a style="float: right; height: 30px; border-color: #00ceff; line-height: 22px; font-size: 12px" class="btn btn-default">Xem chi tiết</a>
                                </h4>
                            </div>
                            <div class="modal-body">
                                <p>
                                    <b>Plan: </b>
                                    <asp:Label ID="Label1" runat="server" Text="0"></asp:Label>
                                </p>
                                <p>
                                    <b>Actual: </b>
                                    <asp:Label ID="Label2" runat="server" Text="0"></asp:Label>
                                </p>
                                <p>
                                    <b>Change: </b>
                                    <asp:Label ID="Label3" runat="server" Text="0"></asp:Label>
                                </p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="form-group col-md-4">
                <div class="modal" style="display: block; overflow: inherit; margin-top: 20px" role="dialog" id="div_community">
                    <div class="modal-dialog">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h4 class="modal-title"><b style="font-size: 18px;">COMMUNITY</b>
                                    <a style="float: right; height: 30px; border-color: #00ceff; line-height: 22px; font-size: 12px" class="btn btn-default">Xem chi tiết</a>
                                </h4>
                            </div>
                            <div class="modal-body">
                                <p>
                                    <b>Online testing: </b>
                                    <asp:Label ID="Label4" runat="server" Text="1 (Chưa thi)"></asp:Label>
                                </p>
                                <p>
                                    <b>Online leason: </b>
                                    <asp:Label ID="Label6" runat="server" Text="5 (Học & thi 3/5)"></asp:Label>
                                </p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </fieldset>
    <dx:ASPxHiddenField ID="hdfKey" ClientInstanceName="hdfKey" runat="server"></dx:ASPxHiddenField>
</asp:Content>