<%@ Page Title="" Language="C#" MasterPageFile="~/Mobile.Master" AutoEventWireup="true" CodeBehind="LessonList.aspx.cs" Inherits="WebApplication.Pages.Employee.LessonList" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Content" runat="server">
    <div class="row text-center">
        <h3>Training Online</h3>
        <asp:Repeater ID="rpLesson" runat="server">
            <ItemTemplate>
                <div class="col-xs-12" style="margin: 10px 0px">
                    <div style="float: left; position: relative; margin-bottom: 20px; width: 100%; border-radius: 5px; height: 90px; box-shadow: 2px 2px 0px rgba(220, 220, 220, 0.5); border: 1px solid #d7d7d7">
                        <div class="col-xs-1" style="border-radius: 0 70px 70px 0; padding: 0; height: 88px; width: 5px; background: #00c2ff"></div>
                        <div class="col-xs-11 text-left" style="padding-top: 10px">
                            <h5><%# Eval("CourseName") %></h5>
                            <a style="padding-top: 10px">Số slide: <%# Eval("LBNo") %></a>
                        </div>
                        <div style="position: absolute; bottom: -16px; width: 40%; left: 30%; background: #e4f6ff; height: 32px; border-radius: 16px;border: 1px solid #2196F3; line-height: 32px; text-align: center">
                            <a href='<%# "/pg/online-training/" + Eval("LessonId") + ".html" %>' style="color: #000">Học bài</a>
                            <%# Convert.ToInt32(Eval("ExamId")) > 0 ? "<a href='/pg/online-testing/" + Eval("ExamId") + "/" + Eval("Id") + ".html' style='color: #000'>Thi</a>" : "" %>
                        </div>
                    </div>
                </div>
            </ItemTemplate>
        </asp:Repeater>
    </div>
</asp:Content>