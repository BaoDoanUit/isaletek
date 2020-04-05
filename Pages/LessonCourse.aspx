<%@ Page Title="Examination" Language="C#" MasterPageFile="~/Layout.master" AutoEventWireup="true" CodeBehind="LessonCourse.aspx.cs" Inherits="WebApplication.Pages.LessonCourse" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Content" runat="server">
    <script type="text/javascript" src="../Scripts/jquery.dragsort-0.5.2.min.js"></script>
    <script>
        function OnEndCallback(s, e) {
            if (s.cpAlert != null && s.cpAlert != "") {
                alert(s.cpAlert);
                if (s.cpAlert === "Lưu thành công") {
                    pcImport.Hide();
                    aspxCallback.PerformCallback("filter");
                }
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
    <style type="text/css">
        ul {
            list-style-type: none;
        }

        .placeHolder div {
            background-color: white !important;
            border: dashed 1px gray !important;
        }

        .tab-custom {
            text-align: center;
        }

            .tab-custom a {
                margin: 0 10px;
                border: 1px solid #ddd;
                padding: 5px 10px;
                border-radius: 5px;
            }

        .tab-custom-active {
            background-color: orange;
            color: #fff
        }

        .tab-custom a:hover {
            text-decoration: underline;
            color: #FFF;
            cursor: pointer;
            background-color: orange;
        }

        #Content_ASPxCallbackPanel1_lbname {
            font-size: 16px;
            padding-left: 30px;
            margin-top: 10px;
            display: block;
            margin-bottom: 0;
            padding-bottom: 0;
            font-weight: 600;
        }
        #Content_ASPxCallbackPanel2_lbname{
            font-size: 16px;
    padding-left: 30px;
    margin-top: 10px;
    display: block;
    margin-bottom: 0;
    padding-bottom: 0;
    font-weight: 600;
        }
    </style>
    <dx:ASPxCallbackPanel ID="ASPxCallbackPanel2" runat="server" Width="100%"
        ClientInstanceName="aspxCallback" OnCallback="aspxCallback_Callback">
        <ClientSideEvents EndCallback="OnEndCallback" />
        <PanelCollection>
            <dx:PanelContent runat="server">
                <div class="container">
                    <asp:Label ID="lbname" runat="server" Text="Label"></asp:Label>
                    <dx:ASPxFormLayout runat="server" ID="formLayout" CssClass="formLayout">
                        <SettingsAdaptivity AdaptivityMode="SingleColumnWindowLimit" SwitchToSingleColumnAtWindowInnerWidth="384" />
                        <Items>
                            <dx:LayoutGroup ShowCaption="False" UseDefaultPaddings="false">
                                <Items>
                                    <dx:LayoutItem Caption="" ShowCaption="False" Width="100%">
                                        <LayoutItemNestedControlCollection>
                                            <dx:LayoutItemNestedControlContainer>
                                                <div class="col-md-12" style="padding: 0px; ">
                                                    <a onclick="New()" class="btn btn-blue"><i class="fa fa-plus-circle"></i>&nbsp; Add New&nbsp;  </a>
                                                    <div style="clear: both; height: 20px"></div>
                                                    <dx:ASPxGridView runat="server" AutoGenerateColumns="False" ID="gvExam" ClientInstanceName="gvExam" Width="100%"
                                                        KeyFieldName="Id">
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
                                                            <dx:GridViewDataTextColumn FieldName="CourseName" Width="300px" Caption="Tên bài học" VisibleIndex="1">
                                                                <EditFormSettings VisibleIndex="0" />
                                                            </dx:GridViewDataTextColumn>
                                                            <dx:GridViewDataTextColumn FieldName="FromDate" Width="130px" VisibleIndex="2" Caption="Từ ngày">
                                                                <PropertiesTextEdit DisplayFormatString="yyyy-MM-dd"></PropertiesTextEdit>
                                                                <EditFormSettings Visible="False" />
                                                                <CellStyle VerticalAlign="Middle" HorizontalAlign="Center"></CellStyle>
                                                            </dx:GridViewDataTextColumn>
                                                            <dx:GridViewDataTextColumn FieldName="ToDate" Width="130px" VisibleIndex="3" Caption="Đến ngày">
                                                                <PropertiesTextEdit DisplayFormatString="yyyy-MM-dd"></PropertiesTextEdit>
                                                                <EditFormSettings Visible="False" />
                                                                <CellStyle VerticalAlign="Middle" HorizontalAlign="Center"></CellStyle>
                                                            </dx:GridViewDataTextColumn>
                                                            <dx:GridViewDataTextColumn FieldName="NumQuestion" Width="120px" Caption="Tổng số câu" VisibleIndex="4">
                                                                <EditFormSettings Visible="False" />
                                                                <CellStyle VerticalAlign="Middle" HorizontalAlign="Center"></CellStyle>
                                                            </dx:GridViewDataTextColumn>
                                                            <dx:GridViewDataTextColumn FieldName="Timer" Width="120px" Caption="Thời gian (phút)" VisibleIndex="5">
                                                                <EditFormSettings Visible="False" />
                                                                <CellStyle VerticalAlign="Middle" HorizontalAlign="Center"></CellStyle>
                                                            </dx:GridViewDataTextColumn>
                                                            <dx:GridViewDataColumn VisibleIndex="6" Caption=" " Width="130px">
                                                                <CellStyle HorizontalAlign="Center"></CellStyle>
                                                                <DataItemTemplate>
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
                                            </dx:LayoutItemNestedControlContainer>
                                        </LayoutItemNestedControlCollection>
                                    </dx:LayoutItem>
                                </Items>
                            </dx:LayoutGroup>
                        </Items>
                    </dx:ASPxFormLayout>
                </div>
            </dx:PanelContent>
        </PanelCollection>
    </dx:ASPxCallbackPanel>
    <dx:ASPxPopupControl ID="pcImport" runat="server" Width="600" CloseAction="CloseButton" CloseOnEscape="true" Modal="True"
        PopupHorizontalAlign="WindowCenter" PopupVerticalAlign="WindowCenter" ClientInstanceName="pcImport"
        HeaderText="Course" AllowDragging="True" PopupAnimationType="None" EnableViewState="False" AutoUpdatePosition="true">
        <ContentCollection>
            <dx:PopupControlContentControl ID="PopupControlContentControl3" runat="server">
                <dx:ASPxCallbackPanel ID="ASPxCallbackPanel1" runat="server" Width="100%"
                    ClientInstanceName="cp" OnCallback="ASPxCallbackPanel1_Callback">
                    <ClientSideEvents EndCallback="OnEndCallback" />
                    <PanelCollection>
                        <dx:PanelContent runat="server">
                            <dx:ASPxFormLayout runat="server" ID="ASPxFormLayout2" CssClass="formLayout">
                                <SettingsAdaptivity AdaptivityMode="SingleColumnWindowLimit" SwitchToSingleColumnAtWindowInnerWidth="500" />
                                <Items>
                                    <dx:LayoutItem Caption="From Date">
                                        <LayoutItemNestedControlCollection>
                                            <dx:LayoutItemNestedControlContainer>
                                                <asp:HiddenField ID="hfId" runat="server" />
                                                <dx:ASPxDateEdit runat="server" Width="100%" ID="txFrom" DisplayFormatString="yyyy-MM-dd"
                                                    EditFormat="Custom" EditFormatString="yyyy-MM-dd">
                                                    <ClearButton DisplayMode="OnHover"></ClearButton>
                                                </dx:ASPxDateEdit>
                                            </dx:LayoutItemNestedControlContainer>
                                        </LayoutItemNestedControlCollection>
                                    </dx:LayoutItem>
                                    <dx:LayoutItem Caption="To Date">
                                        <LayoutItemNestedControlCollection>
                                            <dx:LayoutItemNestedControlContainer>
                                                <dx:ASPxDateEdit runat="server" Width="100%" ID="txTo" DisplayFormatString="yyyy-MM-dd"
                                                    EditFormat="Custom" EditFormatString="yyyy-MM-dd">
                                                    <ClearButton DisplayMode="OnHover"></ClearButton>
                                                </dx:ASPxDateEdit>
                                            </dx:LayoutItemNestedControlContainer>
                                        </LayoutItemNestedControlCollection>
                                    </dx:LayoutItem>
                                    <dx:LayoutItem Caption="No.Question">
                                        <LayoutItemNestedControlCollection>
                                            <dx:LayoutItemNestedControlContainer>
                                                <dx:ASPxButtonEdit runat="server" Width="100%" ID="txtNoQ">
                                                    <ClearButton DisplayMode="OnHover"></ClearButton>
                                                </dx:ASPxButtonEdit>
                                            </dx:LayoutItemNestedControlContainer>
                                        </LayoutItemNestedControlCollection>
                                    </dx:LayoutItem>
                                    <dx:LayoutItem Caption="No.Time (phút)">
                                        <LayoutItemNestedControlCollection>
                                            <dx:LayoutItemNestedControlContainer>
                                                <dx:ASPxButtonEdit runat="server" Width="100%" ID="txtNoT">
                                                    <ClearButton DisplayMode="OnHover"></ClearButton>
                                                </dx:ASPxButtonEdit>
                                            </dx:LayoutItemNestedControlContainer>
                                        </LayoutItemNestedControlCollection>
                                    </dx:LayoutItem>
                                    <dx:LayoutItem ShowCaption="False" HorizontalAlign="Right" Width="100%">
                                        <LayoutItemNestedControlCollection>
                                            <dx:LayoutItemNestedControlContainer>
                                                <div class="row marginTop20">
                                                    <div class="col-md-12 text-center">
                                                        <dx:ASPxButton ID="btOK" runat="server" Text="Save" Width="80px" AutoPostBack="False" CssClass="btn btn-danger">
                                                            <ClientSideEvents Click="function(s, e) { Save(); }" />
                                                        </dx:ASPxButton>
                                                        &nbsp;
                                            <dx:ASPxButton ID="btCancel" runat="server" Text="Cancel" Width="80px" AutoPostBack="False">
                                                <ClientSideEvents Click="function(s, e) { pcImport.Hide(); }" />
                                            </dx:ASPxButton>
                                                    </div>
                                                </div>
                                            </dx:LayoutItemNestedControlContainer>
                                        </LayoutItemNestedControlCollection>
                                    </dx:LayoutItem>
                                </Items>
                            </dx:ASPxFormLayout>
                        </dx:PanelContent>
                    </PanelCollection>
                </dx:ASPxCallbackPanel>
            </dx:PopupControlContentControl>
        </ContentCollection>
    </dx:ASPxPopupControl>
</asp:Content>
