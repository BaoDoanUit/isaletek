<%@ Page Title="Testing Online" Language="C#" MasterPageFile="~/Layout.master" AutoEventWireup="true" CodeBehind="Testing.aspx.cs" Inherits="WebApplication.Pages.Testing" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Content" runat="server">
    <script type="text/javascript" src="../Scripts/jquery.dragsort-0.5.2.min.js"></script>
    <script>
        function OnEndCallback(s, e) {
            if (s.cpAlert != '' && (typeof s.cpAlert !== 'undefined')) {
                alert(s.cpAlert);
            }
        }
        function FilterOnEndCallback(s, e) {
            if (s.cpAlert != '' && (typeof s.cpAlert !== 'undefined')) {
                if (s.cpAlert == 'Thành công' || s.cpAlert == 'KHÔNG thành công') {
                    alert(s.cpAlert);
                }
                cpfilter.PerformCallback();
            }
        }
        function Edit(Id) {
            cp.PerformCallback('edit;' + Id);
            pcImport.Show();
        }
        function Del(Id) {
            if (confirm("Bạn chắc chắn muốn xóa không?")) {
                cp.PerformCallback('delete;' + Id);
            }
        }
        function New() {
            cp.PerformCallback('new;0');
            pcImport.Show();
        }
        function Save() {
            cp.PerformCallback('save;0');
            pcImport.Hide();
        }
    </script>
    <script type="text/javascript">
        $(document).ready(function () {
            $("#TopPanel_NavMenu ul li:eq(6)").addClass("dxm-selected");
        })
    </script>
    <style type="text/css">
        ul {
            list-style-type: none;
        }

        .placeHolder div {
            background-color: white !important;
            border: dashed 1px gray !important;
        }

        ul#gallery {
            float: left;
            width: 100%;
            padding: 0;
            margin: 0
        }

            ul#gallery li {
                float: left;
                height: 85px;
            }

        .thumbnail {
            position: relative
        }

        ul#gallery li a {
            padding-left: 15px
        }
    </style>
    <dx:ASPxCallbackPanel ID="ASPxCallbackPanel3" runat="server" Width="100%"
        ClientInstanceName="cpfilter" OnCallback="ASPxCallbackPanel3_Callback">
        <ClientSideEvents EndCallback="FilterOnEndCallback" />
        <PanelCollection>
            <dx:PanelContent runat="server">
                <div class="row container marginTop20">
                    <div class="col-md-12 box-content">
                        <div class="row">
                            <div class="col-md-12 marginTop20 marginBot20">
                                <a onclick="New()" class="btn btn-blue"><i class="fa fa-plus-circle"></i>&nbsp; Add New&nbsp;  </a>
                                <%--<a class="btn btn-blue" href="/Content/template/Task_Template.xlsx" target="_blank">&nbsp; Template&nbsp; </a>--%>
                                <div style="clear: both; height: 20px"></div>
                                <dx:ASPxGridView runat="server" AutoGenerateColumns="False" ID="gvLessions" ClientInstanceName="gvLessions" Width="100%"
                                    KeyFieldName="LessonId">
                                    <Styles>
                                        <Header Wrap="True" VerticalAlign="Middle" HorizontalAlign="Center"></Header>
                                        <Cell Wrap="True" VerticalAlign="Middle"></Cell>
                                        <AlternatingRow Enabled="true" />
                                    </Styles>
                                    <Columns>
                                        <dx:GridViewDataColumn VisibleIndex="0" Width="100px" Caption="Stt">
                                            <CellStyle HorizontalAlign="Center"></CellStyle>
                                            <DataItemTemplate>
                                                <%# Container.ItemIndex+1 %>
                                            </DataItemTemplate>
                                            <EditFormSettings Visible="False" />
                                        </dx:GridViewDataColumn>
                                        <dx:GridViewDataTextColumn FieldName="CourseName" Width="420px" Caption="Tên bài học" VisibleIndex="1">
                                            <EditFormSettings VisibleIndex="0" />
                                        </dx:GridViewDataTextColumn>
                                        <dx:GridViewDataTextColumn FieldName="QBNo" Width="200px" Caption="Tổng câu hỏi" VisibleIndex="2">
                                            <EditFormSettings Visible="False" />
                                            <CellStyle VerticalAlign="Middle" HorizontalAlign="Center"></CellStyle>
                                        </dx:GridViewDataTextColumn>
                                        <dx:GridViewDataColumn VisibleIndex="4" Caption=" " Width="400px">
                                            <CellStyle HorizontalAlign="Center"></CellStyle>
                                            <DataItemTemplate>
                                                <a href='<%# "/Pages/TestingCourse.aspx?Id=" + Eval("Id") %>' style="cursor: pointer; padding-right: 0">Exam Schedule</a>
                                                <a href='<%# "/Pages/TestingDetail.aspx?Id=" + Eval("Id") %>' style="padding-left: 10px; cursor: pointer; padding-right: 0">Questions</a>
                                                <a onclick='<%# "Edit(" +Eval("Id") +")" %>' style="padding: 0 10px; cursor: pointer">Edit</a>
                                                <a onclick='<%# "Del(" +Eval("Id") +")" %>' style="cursor: pointer">Delete</a>
                                            </DataItemTemplate>
                                        </dx:GridViewDataColumn>
                                    </Columns>
                                    <Settings HorizontalScrollBarMode="Visible" VerticalScrollBarStyle="Standard" VerticalScrollableHeight="370" VerticalScrollBarMode="Visible" />
                                    <SettingsBehavior AllowSort="true" ColumnResizeMode="Control" />
                                    <Styles>
                                        <Header HorizontalAlign="Center" Wrap="True" Paddings-Padding="3px"></Header>
                                        <Cell Wrap="True" VerticalAlign="Middle" Paddings-Padding="5px"></Cell>
                                    </Styles>
                                    <SettingsPager PageSize="12"></SettingsPager>
                                </dx:ASPxGridView>
                            </div>
                        </div>
                    </div>
                </div>
            </dx:PanelContent>
        </PanelCollection>
    </dx:ASPxCallbackPanel>
    <dx:ASPxPopupControl ID="pcImport" runat="server" Width="600" CloseAction="CloseButton" CloseOnEscape="true" Modal="True"
        PopupHorizontalAlign="WindowCenter" PopupVerticalAlign="WindowCenter" ClientInstanceName="pcImport"
        HeaderText="Testing" AllowDragging="True" PopupAnimationType="None" EnableViewState="False" AutoUpdatePosition="true">
        <ContentCollection>
            <dx:PopupControlContentControl runat="server">
                <dx:ASPxPanel ID="Panel1" runat="server" DefaultButton="btOK">
                    <PanelCollection>
                        <dx:PanelContent runat="server">
                            <dx:ASPxCallbackPanel ID="ASPxCallbackPanel1" runat="server" Width="100%"
                                ClientInstanceName="cp" OnCallback="ASPxCallbackPanel1_Callback">
                                <ClientSideEvents EndCallback="FilterOnEndCallback" />
                                <PanelCollection>
                                    <dx:PanelContent runat="server">
                                        <dx:ASPxFormLayout runat="server" ID="ASPxFormLayout1" Width="100%" Height="100%">
                                            <Items>
                                                <dx:LayoutItem Caption="Testing Name">
                                                    <LayoutItemNestedControlCollection>
                                                        <dx:LayoutItemNestedControlContainer>
                                                            <dx:ASPxButtonEdit runat="server" Width="100%" ID="txtnameedit" ClientInstanceName="txtnameedit">
                                                                <ClearButton DisplayMode="OnHover"></ClearButton>
                                                            </dx:ASPxButtonEdit>
                                                        </dx:LayoutItemNestedControlContainer>
                                                    </LayoutItemNestedControlCollection>
                                                </dx:LayoutItem>
                                                <dx:LayoutItem ShowCaption="False">
                                                    <LayoutItemNestedControlCollection>
                                                        <dx:LayoutItemNestedControlContainer>
                                                            <asp:Literal ID="ltrbSave" runat="server"></asp:Literal>
                                                        </dx:LayoutItemNestedControlContainer>
                                                    </LayoutItemNestedControlCollection>
                                                </dx:LayoutItem>
                                            </Items>
                                        </dx:ASPxFormLayout>
                                    </dx:PanelContent>
                                </PanelCollection>
                            </dx:ASPxCallbackPanel>
                        </dx:PanelContent>
                    </PanelCollection>
                </dx:ASPxPanel>
            </dx:PopupControlContentControl>
        </ContentCollection>
        <ContentStyle>
            <Paddings PaddingBottom="5px" />
        </ContentStyle>
    </dx:ASPxPopupControl>
</asp:Content>
