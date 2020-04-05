<%@ Page Title="Task" Language="C#" MasterPageFile="~/Layout.master" AutoEventWireup="true" CodeBehind="Task.aspx.cs" Inherits="WebApplication.Pages.Task" %>

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
                cpfilter.PerformCallback('filter');
            }
        }
        function Edit(Id) {
            cp.PerformCallback('edit;' + Id);
            pcImport.Show();
        }
        function Del(Id) {
            if (confirm("Bạn chắc chắn muốn xóa không?")) {
                cpfilter.PerformCallback('delete;' + Id);
            }
        }
        function New() {
            pcQuestion.Show();
        }
        function Save() {
            cp.PerformCallback('save;0');
            pcImport.Hide();
        }
        function onFileUploadComplete(s, e) {
            if (e.callbackData) {
                if (e.callbackData != null && e.callbackData != "") {
                    alert(e.callbackData);
                }
                if (e.callbackData === "Import thành công!") {
                    cpfilter.PerformCallback("filter");
                    pcQuestion.Hide();
                }
            }
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
                                <a class="btn btn-blue" href="/Content/template/Task_Template.xlsx" target="_blank">&nbsp; Template&nbsp; </a>
                                <div style="clear: both; height: 20px"></div>
                                <dx:ASPxGridView runat="server" AutoGenerateColumns="False" ID="gvTasks" ClientInstanceName="gvTasks" Width="100%"
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
                                        <dx:GridViewDataTextColumn FieldName="TaskName" Width="300px" Caption="Task Name" VisibleIndex="1">
                                            <EditFormSettings VisibleIndex="0" />
                                        </dx:GridViewDataTextColumn>
                                        <dx:GridViewDataTextColumn FieldName="Region" Caption="Region" VisibleIndex="2">
                                            <EditFormSettings VisibleIndex="0" />
                                            <CellStyle VerticalAlign="Middle" HorizontalAlign="Center"></CellStyle>
                                        </dx:GridViewDataTextColumn>
                                        <dx:GridViewDataTextColumn FieldName="Position" Caption="Position" VisibleIndex="3">
                                            <EditFormSettings VisibleIndex="0" />
                                            <CellStyle VerticalAlign="Middle" HorizontalAlign="Center"></CellStyle>
                                        </dx:GridViewDataTextColumn>
                                        <dx:GridViewDataTextColumn FieldName="FromDate" VisibleIndex="4" Caption="FromDate">
                                            <PropertiesTextEdit DisplayFormatString="yyyy-MM-dd"></PropertiesTextEdit>
                                            <EditFormSettings Visible="False" />
                                            <CellStyle VerticalAlign="Middle" HorizontalAlign="Center"></CellStyle>
                                        </dx:GridViewDataTextColumn>
                                        <dx:GridViewDataTextColumn FieldName="ToDate" VisibleIndex="5" Caption="ToDate">
                                            <PropertiesTextEdit DisplayFormatString="yyyy-MM-dd"></PropertiesTextEdit>
                                            <EditFormSettings Visible="False" />
                                            <CellStyle VerticalAlign="Middle" HorizontalAlign="Center"></CellStyle>
                                        </dx:GridViewDataTextColumn>
                                        <dx:GridViewDataTextColumn FieldName="Total" Caption="Tổng câu" VisibleIndex="6">
                                            <EditFormSettings Visible="False" />
                                            <CellStyle VerticalAlign="Middle" HorizontalAlign="Center"></CellStyle>
                                        </dx:GridViewDataTextColumn>
                                        <dx:GridViewDataColumn VisibleIndex="7" Caption="Đã khảo sát">
                                            <CellStyle HorizontalAlign="Center"></CellStyle>
                                            <DataItemTemplate>
                                                <a target="_blank" href='<%# "/Pages/TaskFinish.aspx?Id=" + Eval("Id") %>' style="padding-left: 10px; cursor: pointer; padding-right: 0">
                                                    <%# Eval("TotalFinish") %>
                                                </a>
                                            </DataItemTemplate>
                                        </dx:GridViewDataColumn>
                                        <dx:GridViewDataColumn VisibleIndex="8" Caption=" " Width="190px">
                                            <CellStyle HorizontalAlign="Center"></CellStyle>
                                            <DataItemTemplate>
                                                <a href='<%# "/Pages/TaskDetail.aspx?Id=" + Eval("Id") %>' style="padding-left: 10px; cursor: pointer; padding-right: 0">Task Bank</a>
                                               <%-- <a onclick='<%# "Edit(" +Eval("Id") +")" %>' style="padding: 0 10px; cursor: pointer">Edit</a>  --%>  
                                            
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
<%--    <dx:ASPxPopupControl ID="pcImport" runat="server" Width="600" CloseAction="CloseButton" CloseOnEscape="true" Modal="True"
        PopupHorizontalAlign="WindowCenter" PopupVerticalAlign="WindowCenter" ClientInstanceName="pcImport"
        HeaderText="Task" AllowDragging="True" PopupAnimationType="None" EnableViewState="False" AutoUpdatePosition="true">
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
                                                <dx:LayoutItem ShowCaption="False">
                                                    <LayoutItemNestedControlCollection>
                                                        <dx:LayoutItemNestedControlContainer>
                                                            <dx:ASPxDropDownEdit ClientInstanceName="checkComboBox" NullText="--All--" Caption="Area" ID="checkRegion" runat="server" AnimationType="None">
                                                                <DropDownWindowTemplate>
                                                                    <dx:ASPxListBox Width="100%" ID="listBox" ClientInstanceName="checkListBox" SelectionMode="CheckColumn" DataSourceID="odsregion"
                                                                        runat="server" Height="200" EnableSelectAll="false" ValueField="Region" TextField="Region">
                                                                        <Border BorderStyle="None" />
                                                                        <BorderBottom BorderStyle="Solid" BorderWidth="1px" BorderColor="#DCDCDC" />
                                                                        <ClientSideEvents SelectedIndexChanged="updateText" Init="updateText" />
                                                                    </dx:ASPxListBox>
                                                                    <table style="width: 100%">
                                                                        <tr>
                                                                            <td style="padding: 4px">
                                                                                <dx:ASPxButton ID="ASPxButton1" AutoPostBack="False" runat="server" Text="Close" Style="float: right">
                                                                                    <ClientSideEvents Click="function(s, e){ checkComboBox.HideDropDown();GetValues(); }" />
                                                                                </dx:ASPxButton>
                                                                            </td>
                                                                        </tr>
                                                                    </table>
                                                                </DropDownWindowTemplate>
                                                                <ClientSideEvents TextChanged="synchronizeListBoxValues" DropDown="synchronizeListBoxValues" />
                                                            </dx:ASPxDropDownEdit>
                                                            <asp:ObjectDataSource ID="odsregion" runat="server" SelectMethod="getRegion_byArea" TypeName="LogicTier.Controllers.OutletBL">
                                                                <SelectParameters>
                                                                    <asp:Parameter Name="Area" Type="String" />
                                                                </SelectParameters>
                                                            </asp:ObjectDataSource>
                                                        </dx:LayoutItemNestedControlContainer>
                                                    </LayoutItemNestedControlCollection>
                                                </dx:LayoutItem>
                                                <dx:LayoutItem ShowCaption="False">
                                                    <LayoutItemNestedControlCollection>
                                                        <dx:LayoutItemNestedControlContainer>
                                                            <dx:ASPxDropDownEdit ClientInstanceName="checkComboBoxAccount" NullText="--All--" Caption="Position" ID="checkComboBoxAccount" runat="server" AnimationType="None">
                                                                <DropDownWindowTemplate>
                                                                    <dx:ASPxListBox Width="100%" ID="listBoxAccount" ClientInstanceName="checkListBoxAccount" SelectionMode="CheckColumn"
                                                                        runat="server" Height="100" EnableSelectAll="false">
                                                                        <Border BorderStyle="None" />
                                                                        <BorderBottom BorderStyle="Solid" BorderWidth="1px" BorderColor="#DCDCDC" />
                                                                        <ClientSideEvents SelectedIndexChanged="updateTextAccount" Init="updateTextAccount" />
                                                                        <Items>
                                                                            <dx:ListEditItem Text="HA" Value="HA" />
                                                                            <dx:ListEditItem Text="SHA" Value="SHA" />
                                                                        </Items>
                                                                    </dx:ASPxListBox>
                                                                    <table style="width: 100%">
                                                                        <tr>
                                                                            <td style="padding: 4px">
                                                                                <dx:ASPxButton ID="ASPxButton2" AutoPostBack="False" runat="server" Text="Close" Style="float: right">
                                                                                    <ClientSideEvents Click="function(s, e){ checkComboBoxAccount.HideDropDown();GetValuesAccount(); }" />
                                                                                </dx:ASPxButton>
                                                                            </td>
                                                                        </tr>
                                                                    </table>
                                                                </DropDownWindowTemplate>
                                                                <ClientSideEvents TextChanged="synchronizeListBoxValues" DropDown="synchronizeListBoxValues" />
                                                            </dx:ASPxDropDownEdit>
                                                        </dx:LayoutItemNestedControlContainer>
                                                    </LayoutItemNestedControlCollection>
                                                </dx:LayoutItem>
                                                <dx:LayoutItem Caption="Task Name">
                                                    <LayoutItemNestedControlCollection>
                                                        <dx:LayoutItemNestedControlContainer>
                                                            <dx:ASPxButtonEdit runat="server" Width="100%" ID="txtnameedit" ClientInstanceName="txtnameedit">
                                                                <ClearButton DisplayMode="OnHover"></ClearButton>
                                                            </dx:ASPxButtonEdit>
                                                        </dx:LayoutItemNestedControlContainer>
                                                    </LayoutItemNestedControlCollection>
                                                </dx:LayoutItem>
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
    </dx:ASPxPopupControl>--%>
    <dx:ASPxPopupControl ID="pcQuestion" runat="server" Width="600" CloseAction="CloseButton" CloseOnEscape="true" Modal="True"
        PopupHorizontalAlign="WindowCenter" PopupVerticalAlign="WindowCenter" ClientInstanceName="pcQuestion"
        HeaderText="Chọn file để Import" AllowDragging="True" PopupAnimationType="None" EnableViewState="False" AutoUpdatePosition="true">
        <ContentCollection>
            <dx:PopupControlContentControl ID="PopupControlContentControl1" runat="server">
                <dx:ASPxFormLayout runat="server" ID="ASPxFormLayout2" CssClass="formLayout">
                    <SettingsAdaptivity AdaptivityMode="SingleColumnWindowLimit" SwitchToSingleColumnAtWindowInnerWidth="500" />
                    <Items>
                        <dx:LayoutItem Caption="Task" ShowCaption="False" Width="100%">
                            <LayoutItemNestedControlCollection>
                                <dx:LayoutItemNestedControlContainer>
                                    <dx:ASPxUploadControl ID="upQuestion" runat="server" ClientInstanceName="upQuestion" Width="100%" UploadButton-ImagePosition="Bottom"
                                        NullText="Chọn file (xlsx)..." UploadMode="Advanced" ShowProgressPanel="True"
                                        OnFileUploadComplete="upQuestion_FileUploadComplete" FileUploadMode="OnPageLoad">
                                        <ValidationSettings AllowedFileExtensions=".xlsx"></ValidationSettings>
                                        <AdvancedModeSettings EnableMultiSelect="True" EnableFileList="True" EnableDragAndDrop="false" />
                                        <ClientSideEvents FileUploadComplete="onFileUploadComplete" />
                                    </dx:ASPxUploadControl>
                                </dx:LayoutItemNestedControlContainer>
                            </LayoutItemNestedControlCollection>
                        </dx:LayoutItem>
                        <dx:LayoutItem ShowCaption="False" HorizontalAlign="Right" Width="100%">
                            <LayoutItemNestedControlCollection>
                                <dx:LayoutItemNestedControlContainer>
                                    <div class="row marginTop20">
                                        <div class="col-md-12 text-center">
                                            <dx:ASPxButton ID="btOKQ" runat="server" Text="Import" Width="80px" AutoPostBack="False" CssClass="btn btn-success">
                                                <ClientSideEvents Click="function(s, e) { upQuestion.Upload(); }" />
                                            </dx:ASPxButton>
                                            &nbsp;
                                            <dx:ASPxButton ID="btCancelQ" runat="server" Text="Cancel" Width="80px" AutoPostBack="False">
                                                <ClientSideEvents Click="function(s, e) { pcQuestion.Hide(); }" />
                                            </dx:ASPxButton>
                                        </div>
                                    </div>
                                </dx:LayoutItemNestedControlContainer>
                            </LayoutItemNestedControlCollection>
                        </dx:LayoutItem>
                    </Items>
                </dx:ASPxFormLayout>
            </dx:PopupControlContentControl>
        </ContentCollection>
    </dx:ASPxPopupControl>
    <dx:ASPxHiddenField ID="hdfKey" ClientInstanceName="hdfKey" runat="server"></dx:ASPxHiddenField>
</asp:Content>