<%@ Page Title="" Language="C#" MasterPageFile="~/Layout.master" AutoEventWireup="true" CodeBehind="Tasks.aspx.cs" Inherits="WebApplication.Pages.Employee.Tasks" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Content" runat="server">
    <div class="row text-center">
        <h3 style="padding-left: 15px; line-height: 24px; font-size: 16px!important; color: #f56373">
            <asp:Literal ID="ltrname" runat="server"></asp:Literal>
        </h3>
        <asp:Repeater ID="rpTask" runat="server">
            <ItemTemplate>
                <div class="col-xs-12" style="margin: 10px 0px">
                    <div style="float: left; position: relative; margin-bottom: 20px; width: 100%; border-radius: 5px; height: 120px; box-shadow: 2px 2px 0px rgba(220, 220, 220, 0.5); border: 1px solid #d7d7d7">
                        <div class="col-xs-1" style="border-radius: 0 70px 70px 0; padding: 0; height: 117px; width: 5px; background: #00c2ff"></div>
                        <div class="col-xs-11 text-left" style="padding-top: 10px">
                            <h5 style="font-weight: 600"><%# Eval("TaskName") %></h5>
                            <a style="padding-top: 10px">Số câu: <%# Eval("Total") %></a>
                        </div>
                        <div class="col-xs-11 text-left">
                                <h5>Thời gian: <%# "Từ " + Convert.ToDateTime(Convert.ToString(Eval("FromDate"))).ToString("yyyy-MM-dd") + " đến " + Convert.ToDateTime(Convert.ToString(Eval("ToDate"))).ToString("yyyy-MM-dd") %></h5>
                            </div>
                        <div style="position: absolute; bottom: -16px; width: 40%; left: 30%; background: #e4f6ff; height: 32px; border-radius: 16px;border: 1px solid #2196F3; line-height: 32px; text-align: center">
                            <%# (Convert.ToInt32(Eval("Survey")) > 0 && Convert.ToInt32(Eval("Finish")) < 1) ? "<a href='/pg/tasks-result/" + Eval("Id") + ".html' style='color: #000'>Khảo sát</a>" : "<a>Đã khảo sát</a>" %>
                        </div>
                    </div>
                </div>
            </ItemTemplate>
        </asp:Repeater>
    </div>
</asp:Content>
