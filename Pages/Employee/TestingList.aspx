<%@ Page Title="Testint Online" Language="C#" MasterPageFile="~/Layout.master" AutoEventWireup="true" CodeBehind="TestingList.aspx.cs" Inherits="WebApplication.Pages.Employee.TestingList" %>
<asp:Content ID="Content1" ContentPlaceHolderID="Content" runat="server">
    <div class="row text-center">
        <h3>Online Testing</h3>
        <asp:Literal ID="ltrTest" runat="server"></asp:Literal>
        <%--<div class="col-xs-12" style="margin: 10px 0px">
            <div style="float: left; position: relative; margin-top: 20px; width: 100%; border-radius: 5px; height: 90px;box-shadow:2px 2px 0px rgba(220, 220, 220, 0.5); border: 1px solid #d7d7d7">
                <div class="col-xs-1" style="border-radius:0 70px 70px 0; padding:0; height: 88px; width: 10px; background:#f5627a">
                </div>
                <div class="col-xs-6 text-left" style="padding-top: 10px">
                    <h5>Bài 1</h5>
                    <a>% Đạt: 60%</a>
                </div>
                <div class="col-xs-5 text-left" style="padding-top: 10px">
                    <h5>Thời gian: 15 phút</h5>
                    <a>Số câu: 10</a>
                </div>
                <div style="position: absolute;bottom: -16px;width: 40%;left: 30%;background:#7fd4fe;height: 32px;border-radius: 16px;line-height: 32px;">
                    <a style="color:#fff">Bắt đầu thi</a>
                </div>
            </div>
        </div>
        <div class="col-xs-12" style="margin: 10px 0px">
            <div style="float: left; margin-top: 20px; width: 100%; border-radius: 5px; height: 90px;box-shadow:2px 2px 0px rgba(220, 220, 220, 0.5); border: 1px solid #d7d7d7">
                <div class="col-xs-1" style="border-radius:0 70px 70px 0; padding:0; height: 88px; width: 10px; background:#72a1fb">
                </div>
                <div class="col-xs-6 text-left" style="padding-top: 10px">
                    <h5>Bài 2</h5>
                    <a>% Đạt: 60%</a>
                </div>
                <div class="col-xs-5 text-left" style="padding-top: 10px">
                    <h5>Thời gian: 15 phút</h5>
                    <a>Số câu: 10</a>
                </div>
                <div style="position: absolute;bottom: -16px;width: 40%;left: 30%;background:#fbd789;height: 32px;border-radius: 16px;line-height: 32px;">
                    <a style="color:#000">Chưa mở</a>
                </div>
            </div>
        </div>
        <asp:ObjectDataSource ID="odsOutlet" runat="server" SelectMethod="getByDay" TypeName="LogicTier.Controllers.WorkingPlanBL">
            <SelectParameters>
                <asp:Parameter Name="empId" Type="Int32" />
                <asp:Parameter Name="wkDate" Type="String" />
            </SelectParameters>
        </asp:ObjectDataSource>--%>
    </div>
</asp:Content>