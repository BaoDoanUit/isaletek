<%@ Page Title="Working Plan" Language="C#" MasterPageFile="~/Layout.master" AutoEventWireup="true" CodeBehind="WorkingPlan.aspx.cs" Inherits="WebApplication.Pages.WorkingPlan" Async="true" %>

<%@ Register Assembly="DevExpress.Web.ASPxPivotGrid.v17.1, Version=17.1.6.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.ASPxPivotGrid" TagPrefix="dx" %>
<%@ Register Src="~/UserControls/ToolbarExport.ascx" TagPrefix="uc1" TagName="ToolbarExport" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Content" runat="server">
    <script type="text/javascript">
        function OnEndCallback(s, e) {
            if (s.cpAlert == 'Thành công') {
                alert(s.cpAlert);
            }
        }
        function OnInit(s, e) {
            var calendar = s.GetCalendar();
            calendar.owner = s;
        }

        function OnDropDown(s, e) {
            var calendar = s.GetCalendar();
            var fastNav = calendar.fastNavigation;
            fastNav.activeView = calendar.GetView(0, 0);
            fastNav.Prepare();
            fastNav.GetPopup().popupVerticalAlign = "Below";
            fastNav.GetPopup().ShowAtElement(s.GetMainElement());

            fastNav.OnOkClick = function () {
                var parentDateEdit = this.calendar.owner;
                var currentDate = new Date(fastNav.activeYear, fastNav.activeMonth, 1);
                parentDateEdit.SetDate(currentDate);
                parentDateEdit.HideDropDown();
                fastNav.GetPopup().Hide();
            }

            fastNav.OnCancelClick = function () {
                var parentDateEdit = this.calendar.owner;
                parentDateEdit.HideDropDown();
                fastNav.GetPopup().Hide();
            }
        }
        function ShowLoginWindow() {
            pcImport.Show();
        }
        function DownTemp() {
            cp.PerformCallback('template');
        }
        function DelWP() {
            if (confirm('Bạn có chắc xóa lịch làm việc này không?')) {
                cp.PerformCallback('delete');
            }
        }
    </script>
    <script type="text/javascript">
        $(document).ready(function () {
            $("#TopPanel_NavMenu ul li:eq(6)").addClass("dxm-selected");
        })
    </script>
    <style type="text/css">
        .btn-danger {
            background-color: #d9534f !important;
            background: linear-gradient(to bottom, #d9534f 0%, #d9534f 100%)
        }

        #ctl00_Content_ASPxCallbackPanel1_gvWorkPlan_pgArea2 {
            display: none
        }

        .dxpgColumnArea_Moderno, .dxpgDataArea_Moderno {
            border-top: none;
        }

        #Content_AddCommentFormLayout {
            width: 100%
        }
    </style>
    <div class="container">
        <div class="row">
            <div class="col-md-12 marginTop20">
                <dx:ASPxFormLayout ID="AddCommentFormLayout" runat="server" UseDefaultPaddings="false">
                    <SettingsItems Width="100%" />
                    <SettingsItemCaptions Location="Top" />
                    <Items>
                        <dx:LayoutGroup Caption="Working Plan" ColCount="1">
                            <Items>
                                <dx:LayoutItem ShowCaption="False">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer>
                                            <div class="row marginTop10">
                                                <div class="col-md-3">
                                                    <dx:ASPxDateEdit runat="server" Width="100%" ID="txReportDate" DisplayFormatString="yyyy-MM"
                                                        EditFormat="Custom" EditFormatString="yyyy-MM" OnInit="txReportDate_Init">
                                                        <ClearButton DisplayMode="OnHover"></ClearButton>
                                                    </dx:ASPxDateEdit>
                                                </div>
                                                <div class="col-md-3">
                                                    <dx:ASPxComboBox runat="server" Width="100%" ID="cbParentName" ClientInstanceName="cbParentName" TextField="EmployeeName"
                                                        ValueField="EmployeeId" ValueType="System.Int32" EnableCallbackMode="true" CallbackPageSize="10"
                                                        DropDownStyle="DropDownList" DataSourceID="fodsParent" OnInit="fParentId_Init">
                                                        <ClearButton DisplayMode="OnHover"></ClearButton>
                                                    </dx:ASPxComboBox>
                                                    <asp:ObjectDataSource runat="server" ID="fodsParent" SelectMethod="getParentbyPosition" TypeName="LogicTier.Controllers.EmployeeBL">
                                                        <SelectParameters>
                                                            <asp:Parameter Name="Position" DefaultValue="PC" Type="String" />
                                                        </SelectParameters>
                                                    </asp:ObjectDataSource>
                                                </div>
                                                <div class="col-md-6">
                                                    <dx:ASPxButton ID="FilterButton" AutoPostBack="false" CssClass="btn btn-primary" runat="server" Text="Tìm kiếm">
                                                        <ClientSideEvents Click="function(s, e) {  cp.PerformCallback('filter'); }"></ClientSideEvents>
                                                    </dx:ASPxButton>
                                                    <dx:ASPxButton ID="btImport" AutoPostBack="false" runat="server" CssClass="btn btn-warning" Text="Import">
                                                        <ClientSideEvents Click="function(s, e) { ShowLoginWindow(); }" />
                                                    </dx:ASPxButton>
                                                    <a href='<%= "/Pages/DownTemp.aspx?type=shift&m=" + txReportDate.Date.Month %>' class="btn btn-danger" target="_blank">Template</a>
                                                </div>
                                            </div>
                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>
                                </dx:LayoutItem>
                            </Items>
                        </dx:LayoutGroup>
                    </Items>
                </dx:ASPxFormLayout>
            </div>
        </div>
        <div class="row">
            <div class="col-md-12">
                <dx:ASPxCallbackPanel ID="ASPxCallbackPanel1" runat="server" Width="100%"
                    ClientInstanceName="cp" OnCallback="ASPxCallbackPanel1_Callback"
                    EndCallback="OnEndCallback">
                    <PanelCollection>
                        <dx:PanelContent runat="server">
                            <div class="row container marginTop20">
                                <div class="col-md-12 box-content">
                                    <div class="row">
                                        <div class="col-md-6">
                                            <uc1:ToolbarExport runat="server" ID="ToolbarExport1" OnItemClick="ToolbarExport_ItemClick" />
                                            <dx:ASPxPivotGridExporter ID="ASPxPivotGridExporter1" runat="server" ASPxPivotGridID="gvWorkPlan" />
                                        </div>
                                        <div class="col-md-2">
                                            <dx:ASPxButton ID="btDelete" AutoPostBack="false" Visible="false" CssClass="btn-danger" Style="float: right; margin-top: 10px" runat="server" Text="Delete">
                                                <ClientSideEvents Click="function(s, e) { DelWP(); }" />
                                            </dx:ASPxButton>
                                        </div>
                                    </div>
                                    <div class="row marginBot20">
                                        <div class="col-md-12">
                                            <dx:ASPxPivotGrid ID="gvWorkPlan" runat="server" OnLoad="gvWorkPlan_Load"
                                                DataSourceID="odsWp" Width="100%" ClientIDMode="AutoID">
                                                <Fields>
                                                    <dx:PivotGridField Area="ColumnArea" AreaIndex="1" FieldName="WorkingDate" ID="fieldWorkingDate2" ValueFormat-FormatString="dddd" ValueFormat-FormatType="DateTime">
                                                        <CellStyle HorizontalAlign="Center"></CellStyle>
                                                    </dx:PivotGridField>
                                                    <dx:PivotGridField Area="ColumnArea" AreaIndex="0" FieldName="WorkingDate" ID="fieldWorkingDate" ValueFormat-FormatString="dd" ValueFormat-FormatType="DateTime">
                                                        <CellStyle HorizontalAlign="Center"></CellStyle>
                                                    </dx:PivotGridField>
                                                    <dx:PivotGridField Area="RowArea" AreaIndex="0" FieldName="Region" ID="fieldRegion" Options-AllowExpand="False" />
                                                    <%--<dx:PivotGridField Area="RowArea" AreaIndex="1" FieldName="ShopCode" ID="fieldShopCode" Options-AllowExpand="False" />--%>
                                                    <dx:PivotGridField Area="RowArea" AreaIndex="2" FieldName="ShopName" ID="fieldShopName" Options-AllowExpand="False" />
                                                    <%--<dx:PivotGridField Area="RowArea" AreaIndex="3" FieldName="EmployeeCode" ID="fieldEmplyeeCode" Options-AllowExpand="False" />--%>
                                                    <dx:PivotGridField Area="RowArea" AreaIndex="4" FieldName="EmployeeName" ID="fieldEmployeeName" Options-AllowExpand="False" />
                                                    <dx:PivotGridField Area="DataArea" AreaIndex="0" FieldName="ShiftType" ID="fieldShiftType" SummaryType="Max">
                                                        <CellStyle HorizontalAlign="Center"></CellStyle>
                                                    </dx:PivotGridField>
                                                </Fields>
                                                <OptionsView HorizontalScrollBarMode="Auto" ShowColumnGrandTotals="False" ShowRowTotals="False" ShowRowGrandTotals="False" />
                                                <OptionsFilter NativeCheckBoxes="False" ShowOnlyAvailableItems="true" />
                                            </dx:ASPxPivotGrid>
                                            <asp:ObjectDataSource ID="odsWp" runat="server" SelectMethod="getList" TypeName="LogicTier.Controllers.WorkingPlanBL">
                                                <SelectParameters>
                                                    <asp:Parameter Name="username" Type="String" />
                                                    <asp:Parameter Name="empId" Type="Int32" />
                                                    <asp:Parameter Name="parentId" Type="Int32" />
                                                    <asp:Parameter Name="month" Type="Int32" />
                                                    <asp:Parameter Name="year" Type="Int32" />
                                                </SelectParameters>
                                            </asp:ObjectDataSource>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </dx:PanelContent>
                    </PanelCollection>
                </dx:ASPxCallbackPanel>
            </div>
        </div>
    </div>
    <dx:ASPxPopupControl ID="pcImport" runat="server" Width="320" CloseAction="CloseButton" CloseOnEscape="true" Modal="True"
        PopupHorizontalAlign="WindowCenter" PopupVerticalAlign="WindowCenter" ClientInstanceName="pcImport"
        HeaderText="Choose the Excel file to Import" AllowDragging="True" PopupAnimationType="None" EnableViewState="False" AutoUpdatePosition="true">
        <ContentCollection>
            <dx:PopupControlContentControl runat="server">
                <dx:ASPxPanel ID="Panel1" runat="server" DefaultButton="btOK">
                    <PanelCollection>
                        <dx:PanelContent runat="server">
                            <dx:ASPxFormLayout runat="server" ID="ASPxFormLayout1" Width="100%" Height="100%">
                                <Items>
                                    <dx:LayoutItem ShowCaption="False">
                                        <LayoutItemNestedControlCollection>
                                            <dx:LayoutItemNestedControlContainer>
                                                <dx:ASPxUploadControl ID="UploadControl" runat="server" ClientInstanceName="upload"
                                                    NullText="Bấm để chọn file excel..." OnFileUploadComplete="UploadControl_FileUploadComplete">
                                                    <AdvancedModeSettings EnableMultiSelect="false" EnableDragAndDrop="true" />
                                                    <ValidationSettings MaxFileSize="4194304" AllowedFileExtensions=".xls, .xlsx" ShowErrors="false"></ValidationSettings>
                                                    <ClientSideEvents FileUploadComplete="function(s,e){ 
                                                    if (e.callbackData != '') {
                                                       alert(e.callbackData); 
                                                   }}" />
                                                </dx:ASPxUploadControl>
                                            </dx:LayoutItemNestedControlContainer>
                                        </LayoutItemNestedControlCollection>
                                    </dx:LayoutItem>
                                    <dx:LayoutItem ShowCaption="False">
                                        <LayoutItemNestedControlCollection>
                                            <dx:LayoutItemNestedControlContainer>
                                                <div class="row marginTop20">
                                                    <div class="col-md-12 text-center">
                                                        <dx:ASPxButton ID="btOK" runat="server" Text="Import" Width="80px" AutoPostBack="False" CssClass="btn btn-success">
                                                            <ClientSideEvents Click="function(s, e) { upload.UploadFile();pcImport.Hide();}" />
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
                </dx:ASPxPanel>
            </dx:PopupControlContentControl>
        </ContentCollection>
        <ContentStyle>
            <Paddings PaddingBottom="5px" />
        </ContentStyle>
    </dx:ASPxPopupControl>
</asp:Content>