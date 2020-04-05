<%@ Page Title="Sell Out Report" Language="C#" MasterPageFile="~/Layout.master" AutoEventWireup="true" CodeBehind="SaleOutControl.aspx.cs" Inherits="WebApplication.Pages.SaleOutControl" Async="true" %>

<%@ Register Src="~/UserControls/ToolbarExport.ascx" TagPrefix="uc1" TagName="ToolbarExport" %>

<%@ Register TagPrefix="dx" Namespace="DevExpress.Web" Assembly="DevExpress.Web.v17.1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="Content" runat="server">
    <script>
        function OnEndCallback(s, e) {
            if (s.cpAlert != '') {
                alert(s.cpAlert);
            }
        }
        function gvEndCallback(s, e) {
            if (s.cpSale != '') {
                alert(s.cpSale);
            }
        }
    </script>
    <script type="text/javascript">
        $(document).ready(function () {
            $("#TopPanel_NavMenu ul li:eq(4)").addClass("dxm-selected");
        })
    </script>
    <div class="container">
        <div class="row marginTop20">
            <div class="col-md-12">
                <dx:ASPxFormLayout ID="AddCommentFormLayout" runat="server" UseDefaultPaddings="false" OnInit="AddCommentFormLayout_Init">
                    <SettingsItems Width="100%" />
                    <SettingsItemCaptions Location="Top" />
                    <Items>
                        <dx:LayoutGroup Caption="Filter">
                            <Items>
                                <dx:LayoutItem ShowCaption="False">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer>
                                            <div class="row">
                                                <div class="col-md-3">
                                                    <label>From</label>
                                                    <dx:ASPxDateEdit runat="server" Width="100%" ID="fFromDate" 
                                                        DisplayFormatString="yyyy-MM-dd"
                                                        EditFormat="Custom" EditFormatString="yyyy-MM-dd">
                                                        <ClearButton DisplayMode="OnHover"></ClearButton>
                                                    </dx:ASPxDateEdit>
                                                </div>
                                                <div class="col-md-3">
                                                    <label>To</label>
                                                    <dx:ASPxDateEdit Width="100%" runat="server" ID="fToDate" DisplayFormatString="yyyy-MM-dd"
                                                        EditFormat="Custom" EditFormatString="yyyy-MM-dd">
                                                        <ClearButton DisplayMode="OnHover"></ClearButton>
                                                    </dx:ASPxDateEdit>
                                                </div>
                                                <div class="col-md-3">
                                                    <label>Region</label>
                                                    <dx:ASPxComboBox Width="100%" runat="server" ID="cbRegion" ValueField="Region"
                                                        ValueType="System.String" NullText="Choose to filter by Region"
                                                        ClientInstanceName="cbRegion" CallbackPageSize="10" DataSourceID="odsRegion">
                                                        <ClearButton DisplayMode="OnHover"></ClearButton>
                                                        <ClientSideEvents SelectedIndexChanged="function(s,e){cbCity.PerformCallback(s.GetValue());cbOutlet.PerformCallback(cbRegion.GetValue()+';'+cbCity.GetValue()+';'+cbAccount.GetValue());}" />
                                                        <Columns>
                                                            <dx:ListBoxColumn FieldName="Region" />
                                                        </Columns>
                                                    </dx:ASPxComboBox>
                                                    <asp:ObjectDataSource ID="odsRegion" runat="server" SelectMethod="getDivision" TypeName="LogicTier.Controllers.OutletBL">
                                                        <SelectParameters>
                                                            <asp:Parameter DefaultValue="Region" Name="fieldName" Type="String" />
                                                            <asp:Parameter Name="fieldValue" Type="String" />
                                                            <asp:Parameter DefaultValue="Region" Name="fieldDisplay" Type="String" />
                                                        </SelectParameters>
                                                    </asp:ObjectDataSource>
                                                </div>
                                                <div class="col-md-3">
                                                    <label>City</label>
                                                    <dx:ASPxComboBox runat="server" Width="100%" ID="cbCity" OnCallback="cbCity_Callback"
                                                        ValueType="System.String" NullText="Choose to filter by City" ValueField="City"
                                                        ClientInstanceName="cbCity" CallbackPageSize="10" DataSourceID="odsCity">
                                                        <ClearButton DisplayMode="OnHover"></ClearButton>
                                                        <ClientSideEvents SelectedIndexChanged="function(s,e){cbOutlet.PerformCallback(cbRegion.GetValue()+';'+cbCity.GetValue()+';'+cbAccount.GetValue());}" />
                                                        <Columns>
                                                            <dx:ListBoxColumn FieldName="City" />
                                                        </Columns>
                                                    </dx:ASPxComboBox>
                                                    <asp:ObjectDataSource ID="odsCity" runat="server" SelectMethod="getDivision" TypeName="LogicTier.Controllers.OutletBL">
                                                        <SelectParameters>
                                                            <asp:Parameter DefaultValue="City" Name="fieldName" Type="String" />
                                                            <asp:Parameter Name="fieldValue" Type="String" />
                                                            <asp:Parameter DefaultValue="City" Name="fieldDisplay" Type="String" />
                                                        </SelectParameters>
                                                    </asp:ObjectDataSource>
                                                </div>
                                            </div>
                                            <div class="row marginTop20">
                                                <div class="col-md-3">
                                                    <label>Dealer</label>
                                                    <dx:ASPxComboBox runat="server" Width="100%" ID="cbAccount" ValueType="System.Int32" NullText="Choose to select Dealer"
                                                        DataSourceID="odsAccount" TextField="Account" ValueField="ObjectId"
                                                        ClientInstanceName="cbAccount" CallbackPageSize="10">
                                                        <ClearButton DisplayMode="OnHover"></ClearButton>
                                                        <ClientSideEvents SelectedIndexChanged="function(s,e){cbOutlet.PerformCallback(cbRegion.GetValue()+';'+cbCity.GetValue()+';'+cbAccount.GetValue());}" />
                                                    </dx:ASPxComboBox>
                                                    <asp:ObjectDataSource ID="odsAccount" runat="server" SelectMethod="getAccountGroup" TypeName="LogicTier.Controllers.SaleOutBL"></asp:ObjectDataSource>
                                                </div>
                                                <div class="col-md-3">
                                                    <label>Outlets</label>
                                                    <dx:ASPxComboBox runat="server" Width="100%" ID="cbOutlet" ValueField="ShopId"
                                                        ValueType="System.Int32" NullText="Choose to filter by Outlet" OnCallback="cbOutlet_Callback"
                                                        ClientInstanceName="cbOutlet" DataSourceID="obsgetOutlet"
                                                        IncrementalFilteringMode="Contains" TextFormatString="{0}" EnableCallbackMode="true" DropDownStyle="DropDownList">
                                                        <ClearButton DisplayMode="OnHover"></ClearButton>
                                                        <Columns>
                                                            <dx:ListBoxColumn FieldName="ShopName" Width="250px" />
                                                        </Columns>
                                                    </dx:ASPxComboBox>
                                                    <asp:ObjectDataSource ID="obsgetOutlet" runat="server" SelectMethod="getOutletWithReference" TypeName="LogicTier.Controllers.OutletBL">
                                                        <SelectParameters>
                                                            <asp:Parameter Name="AccountId" Type="Int32" />
                                                            <asp:Parameter Name="objectId" Type="Int32" />
                                                            <asp:Parameter Name="region" Type="String" />
                                                            <asp:Parameter Name="City" Type="String" />
                                                            <asp:Parameter Name="shopCode" Type="String" />
                                                            <asp:Parameter Name="shopName" Type="String" />
                                                            <asp:Parameter Name="Isdelete" Type="Char" ConvertEmptyStringToNull="true" DefaultValue="0" />
                                                        </SelectParameters>
                                                    </asp:ObjectDataSource>
                                                </div>
                                                <div class="col-md-3">
                                                    <label>Suppervisor</label>
                                                    <dx:ASPxComboBox runat="server" Width="100%" ID="cbLearder" ValueField="EmployeeId"
                                                        ValueType="System.Int32" NullText="Choose to filter by Leader person" OnInit="cbLearder_Init"
                                                        ClientInstanceName="cbLearder"  DataSourceID="odsLeader" 
                                                        IncrementalFilteringMode="Contains" TextFormatString="{0}" EnableCallbackMode="true" DropDownStyle="DropDownList">
                                                        <ClientSideEvents SelectedIndexChanged="function(s,e){cbEmployee.PerformCallback(s.GetValue());}" />
                                                        <ClearButton DisplayMode="OnHover"></ClearButton>
                                                        <Columns>
                                                            <dx:ListBoxColumn FieldName="EmployeeName" />
                                                        </Columns>
                                                    </dx:ASPxComboBox>
                                                    <asp:ObjectDataSource ID="odsLeader" runat="server" 
                                                        SelectMethod="getList" TypeName="LogicTier.Controllers.EmployeeBL">
                                                        <SelectParameters>
                                                             <asp:Parameter Name="AccountId" Type="Int32" DefaultValue="" ConvertEmptyStringToNull="true" />
                                                            <asp:Parameter Name="empId" Type="Int32" />
                                                            <asp:Parameter Name="empCode" Type="String" />
                                                            <asp:Parameter Name="pos" Type="String" />
                                                            <asp:Parameter Name="parentId" Type="Int32" />
                                                            <asp:Parameter Name="emplName" Type="String" />
                                                            <asp:ControlParameter ControlID="AddCommentFormLayout$OptionRadioButtonList" Name="Option" Type="Int32" PropertyName="Value" />
                                                            <asp:Parameter Name="userId" />
                                                        </SelectParameters>
                                                    </asp:ObjectDataSource>
                                                </div>
                                                <div class="col-md-3">
                                                    <label>Employee</label>
                                                    <dx:ASPxComboBox runat="server" Width="100%" ID="cbEmployee" OnCallback="cbEmployee_Callback"
                                                        ValueType="System.Int32" NullText="Choose to filter by Employee person" ValueField="EmployeeId"
                                                        ClientInstanceName="cbEmployee" CallbackPageSize="10" DataSourceID="odsEmployee"
                                                        IncrementalFilteringMode="Contains" TextFormatString="{0}" EnableCallbackMode="true" DropDownStyle="DropDownList">
                                                        <ClearButton DisplayMode="OnHover"></ClearButton>
                                                        <Columns>
                                                            <dx:ListBoxColumn FieldName="EmployeeName" />
                                                        </Columns>
                                                    </dx:ASPxComboBox>
                                                    <asp:ObjectDataSource ID="odsEmployee" runat="server" SelectMethod="getList" TypeName="LogicTier.Controllers.EmployeeBL">
                                                        <SelectParameters>
                                                            <asp:Parameter Name="AccountId" Type="Int32" DefaultValue="" ConvertEmptyStringToNull="true" />
                                                            <asp:Parameter Name="empId" Type="Int32" />
                                                            <asp:Parameter Name="empCode" Type="String" />
                                                            <asp:Parameter Name="pos" Type="String" />
                                                            <asp:Parameter Name="parentId" Type="Int32" />
                                                            <asp:Parameter Name="emplName" Type="String" />
                                                            <asp:ControlParameter ControlID="AddCommentFormLayout$OptionRadioButtonList" Name="Option" Type="Int32" PropertyName="Value" />
                                                            <asp:Parameter Name="userId" />
                                                        </SelectParameters>
                                                    </asp:ObjectDataSource>
                                                </div>
                                            </div>
                                            <div class="row marginTop20" style="display: none">
                                                <div class="col-md-3">
                                                    <label>Product</label>
                                                    <dx:ASPxComboBox runat="server" ID="cbProduct" ValueField="Product" Width="100%"
                                                        ValueType="System.String" NullText="Chọn Product"
                                                        ClientInstanceName="cbProduct" CallbackPageSize="10" DataSourceID="odsProduct"
                                                        IncrementalFilteringMode="Contains" TextFormatString="{0}" EnableCallbackMode="true" DropDownStyle="DropDownList">
                                                        <ClearButton DisplayMode="OnHover"></ClearButton>
                                                        <ClientSideEvents SelectedIndexChanged="function(s,e){cbRange.PerformCallback(s.GetValue());cbModel.PerformCallback(cbProduct.GetValue()+';'+cbRange.GetValue()+';'+cbCapacity.GetValue()+';'+cbType.GetValue());}" />
                                                        <Columns>
                                                            <dx:ListBoxColumn FieldName="Product" />
                                                        </Columns>
                                                    </dx:ASPxComboBox>
                                                    <asp:ObjectDataSource ID="odsProduct" runat="server" SelectMethod="getDivision" TypeName="LogicTier.Controllers.ProductsBL">
                                                        <SelectParameters>
                                                            <asp:Parameter DefaultValue="Product" Name="fieldName" Type="String" />
                                                            <asp:Parameter Name="fieldValue" Type="String" />
                                                            <asp:Parameter DefaultValue="Product" Name="fieldDisplay" Type="String" />
                                                        </SelectParameters>
                                                    </asp:ObjectDataSource>
                                                </div>
                                                <div class="col-md-3">
                                                    <label>Range</label>
                                                    <dx:ASPxComboBox runat="server" Width="100%" ID="cbRange" OnCallback="cbRange_Callback"
                                                        ValueType="System.String" NullText="Chọn Range" ValueField="Range"
                                                        ClientInstanceName="cbRange" CallbackPageSize="10" DataSourceID="odsRange"
                                                        IncrementalFilteringMode="Contains" TextFormatString="{0}" EnableCallbackMode="true" DropDownStyle="DropDownList">
                                                        <ClearButton DisplayMode="OnHover"></ClearButton>
                                                        <ClientSideEvents SelectedIndexChanged="function(s,e){cbCapacity.PerformCallback(s.GetValue());cbModel.PerformCallback(cbProduct.GetValue()+';'+cbRange.GetValue()+';'+cbCapacity.GetValue()+';'+cbType.GetValue());}" />
                                                        <Columns>
                                                            <dx:ListBoxColumn FieldName="Range" />
                                                        </Columns>
                                                    </dx:ASPxComboBox>
                                                    <asp:ObjectDataSource ID="odsRange" runat="server" SelectMethod="getDivision" TypeName="LogicTier.Controllers.ProductsBL">
                                                        <SelectParameters>
                                                            <asp:Parameter DefaultValue="Range" Name="fieldName" Type="String" />
                                                            <asp:Parameter Name="fieldValue" Type="String" />
                                                            <asp:Parameter DefaultValue="Range" Name="fieldDisplay" Type="String" />
                                                        </SelectParameters>
                                                    </asp:ObjectDataSource>
                                                </div>
                                                <div class="col-md-3">
                                                    <label>Capacity</label>
                                                    <dx:ASPxComboBox runat="server" Width="100%" ID="cbCapacity" ValueType="System.String" NullText="Chọn Capacity"
                                                        DataSourceID="odsCapacity" TextField="Capacity" ValueField="Capacity" OnCallback="cbCapacity_Callback"
                                                        ClientInstanceName="cbCapacity" CallbackPageSize="10"
                                                        IncrementalFilteringMode="Contains" TextFormatString="{0}" EnableCallbackMode="true" DropDownStyle="DropDownList">
                                                        <ClearButton DisplayMode="OnHover"></ClearButton>
                                                        <ClientSideEvents SelectedIndexChanged="function(s,e){cbType.PerformCallback(s.GetValue());cbModel.PerformCallback(cbProduct.GetValue()+';'+cbRange.GetValue()+';'+cbCapacity.GetValue()+';'+cbType.GetValue());}" />
                                                        <Columns>
                                                            <dx:ListBoxColumn FieldName="Capacity" />
                                                        </Columns>
                                                    </dx:ASPxComboBox>
                                                    <asp:ObjectDataSource ID="odsCapacity" runat="server" SelectMethod="getDivision" TypeName="LogicTier.Controllers.ProductsBL">
                                                        <SelectParameters>
                                                            <asp:Parameter DefaultValue="Capacity" Name="fieldName" Type="String" />
                                                            <asp:Parameter Name="fieldValue" Type="String" />
                                                            <asp:Parameter DefaultValue="Capacity" Name="fieldDisplay" Type="String" />
                                                        </SelectParameters>
                                                    </asp:ObjectDataSource>
                                                </div>
                                                <div class="col-md-3">
                                                    <label>Type</label>
                                                    <dx:ASPxComboBox runat="server" Width="100%" ID="cbType" ValueType="System.String" NullText="Chọn Type"
                                                        DataSourceID="odsType" TextField="Type" ValueField="Type" OnCallback="cbType_Callback"
                                                        ClientInstanceName="cbType" CallbackPageSize="10"
                                                        IncrementalFilteringMode="Contains" TextFormatString="{0}" EnableCallbackMode="true" DropDownStyle="DropDownList">
                                                        <ClientSideEvents SelectedIndexChanged="function(s,e){cbModel.PerformCallback(s.GetValue());cbModel.PerformCallback(cbProduct.GetValue()+';'+cbRange.GetValue()+';'+cbCapacity.GetValue()+';'+cbType.GetValue());}" />
                                                        <ClearButton DisplayMode="OnHover"></ClearButton>
                                                        <Columns>
                                                            <dx:ListBoxColumn FieldName="Type" />
                                                        </Columns>
                                                    </dx:ASPxComboBox>
                                                    <asp:ObjectDataSource ID="odsType" runat="server" SelectMethod="getDivision" TypeName="LogicTier.Controllers.ProductsBL">
                                                        <SelectParameters>
                                                            <asp:Parameter DefaultValue="Type" Name="fieldName" Type="String" />
                                                            <asp:Parameter Name="fieldValue" Type="String" />
                                                            <asp:Parameter DefaultValue="Type" Name="fieldDisplay" Type="String" />
                                                        </SelectParameters>
                                                    </asp:ObjectDataSource>
                                                </div>
                                            </div>
                                            <div class="row marginTop20">
                                                <div class="col-md-3">
                                                    <label>Model</label>
                                                    <dx:ASPxComboBox runat="server" ID="cbModel" Width="100%" ValueType="System.Int32" NullText="Chọn Model"
                                                        DataSourceID="odsModel" ValueField="ProductId" OnCallback="cbModel_Callback"
                                                        ClientInstanceName="cbModel" CallbackPageSize="10"
                                                        IncrementalFilteringMode="Contains" TextFormatString="{0}" EnableCallbackMode="true" DropDownStyle="DropDownList">
                                                        <ClearButton DisplayMode="OnHover"></ClearButton>
                                                        <Columns>
                                                            <dx:ListBoxColumn FieldName="Model" />
                                                        </Columns>
                                                    </dx:ASPxComboBox>
                                                    <asp:ObjectDataSource ID="odsModel" runat="server" SelectMethod="getList" TypeName="LogicTier.Controllers.ProductsBL">
                                                        <SelectParameters>
                                                            <asp:Parameter Name="productId" Type="Int32" DefaultValue="" ConvertEmptyStringToNull="true" />
                                                            <asp:Parameter Name="product" Type="String" DefaultValue="" ConvertEmptyStringToNull="true" />
                                                            <asp:Parameter Name="range" Type="String" DefaultValue="" ConvertEmptyStringToNull="true" />
                                                            <asp:Parameter Name="model" Type="String" DefaultValue="" ConvertEmptyStringToNull="true" />
                                                            <asp:Parameter Name="capacity" Type="String" DefaultValue="" ConvertEmptyStringToNull="true" />
                                                            <asp:Parameter Name="type" Type="String" DefaultValue="" ConvertEmptyStringToNull="true" />
                                                            <asp:Parameter Name="status" Type="Boolean" DefaultValue="" ConvertEmptyStringToNull="true" />
                                                        </SelectParameters>
                                                    </asp:ObjectDataSource>
                                                </div>
                                                <div class="col-md-5">
                                                    <label>Duplicate</label>
                                                    <dx:ASPxRadioButtonList ID="radioButtonList" runat="server" Paddings-PaddingLeft="1" Paddings-PaddingRight="1" Paddings-PaddingBottom="1" Paddings-PaddingTop="1" RepeatColumns="2" Width="100%"
                                                        RepeatLayout="UnorderedList">
                                                        <Items>
                                                            <dx:ListEditItem Text="Data không trùng" Value="0" />
                                                            <dx:ListEditItem Text="Data trùng" Value="1" />
                                                            <dx:ListEditItem Selected="true" Text="Không lọc" Value="-1" />
                                                        </Items>
                                                    </dx:ASPxRadioButtonList>
                                                </div>
                                                <div class="col-md-4">
                                                    <label>Lọc NV</label>
                                                    <dx:ASPxRadioButtonList ID="OptionRadioButtonList" runat="server" Paddings-PaddingLeft="1" Paddings-PaddingRight="1" Paddings-PaddingBottom="1" Paddings-PaddingTop="1" RepeatColumns="2" Width="100%"
                                                        RepeatLayout="UnorderedList">
                                                        <Items>
                                                            <dx:ListEditItem Selected="true" Text="Tất cả NV" Value="0" />
                                                            <dx:ListEditItem Text="NV còn làm việc" Value="-1" />
                                                        </Items>
                                                    </dx:ASPxRadioButtonList>
                                                </div>
                                            </div>
                                            <div class="row marginTop20">
                                                <div class="col-md-2">
                                                    <label>Theo tháng</label><br />
                                                    <dx:ASPxCheckBox ID="chkDumplicate" CheckState="Checked" runat="server" Text=""></dx:ASPxCheckBox>
                                                </div>
                                                <div class="col-md-5">
                                                    <label style="color: white">Tool</label><br />
                                                    <dx:ASPxButton ID="FilterButton" AutoPostBack="false" CssClass="btn btn-primary" runat="server" Text="Tìm kiếm">
                                                        <ClientSideEvents Click="function(s, e) {cp.PerformCallback('filter'); }"></ClientSideEvents>
                                                    </dx:ASPxButton>
                                                    <dx:ASPxButton ID="btImport" AutoPostBack="false" runat="server" Text="Import SO" CssClass="btn btn-warning">
                                                        <ClientSideEvents Click="function(s, e) { pcImport.Show(); }" />
                                                    </dx:ASPxButton>
                                                    <a href="/Content/template/Sellout_Template.xlsx">Template SO</a>
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
        <dx:ASPxCallbackPanel ID="ASPxCallbackPanel1" runat="server" Width="100%"
            ClientInstanceName="cp" OnCallback="ASPxCallbackPanel1_Callback">
            <ClientSideEvents EndCallback="OnEndCallback" />
            <PanelCollection>
                <dx:PanelContent runat="server">
                    <div class="row container marginTop20">
                        <div class="col-md-12 box-content">
                            <div class="row">
                                <div class="col-md-12">
                                    <uc1:ToolbarExport runat="server" ID="ToolbarExport1" OnItemClick="ToolbarExport1_ItemClick" />
                                    <dx:ASPxGridViewExporter ID="ASPxGridViewExporter1" runat="server" ExportSelectedRowsOnly="true" GridViewID="gvSale">
                                    </dx:ASPxGridViewExporter>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-12">
                                    <table class="OptionsBottomMargin">
                                        <tr>
                                            <td style="padding-right: 4px">
                                                <dx:ASPxButton ID="btnSelectAll" runat="server" Text="Chọn tất cả" UseSubmitBehavior="False"
                                                    AutoPostBack="false">
                                                    <ClientSideEvents Click="function(s, e) { gvSale.SelectRows(); }" />
                                                </dx:ASPxButton>
                                            </td>
                                            <td style="padding-right: 4px">
                                                <dx:ASPxButton ID="btnSelectAllOnPage" runat="server" Text="Chọn 1 trang"
                                                    UseSubmitBehavior="False" AutoPostBack="false">
                                                    <ClientSideEvents Click="function(s, e) { gvSale.SelectAllRowsOnPage(); }" />
                                                </dx:ASPxButton>
                                            </td>
                                            <td style="padding-right: 4px">
                                                <dx:ASPxButton ID="btnUnselectAll" runat="server" Text="Bỏ chọn" UseSubmitBehavior="False"
                                                    AutoPostBack="false">
                                                    <ClientSideEvents Click="function(s, e) { gvSale.UnselectRows(); gvSale.UnselectAllRowsOnPage(); }" />
                                                </dx:ASPxButton>
                                            </td>
                                            <td style="padding-right: 4px">
                                                <dx:ASPxButton ID="btnConfirm" runat="server" Text="Confirm Data" UseSubmitBehavior="False"
                                                    AutoPostBack="false">
                                                    <ClientSideEvents Click="function(s, e) {  cp.PerformCallback('confirm'); }"></ClientSideEvents>
                                                </dx:ASPxButton>
                                            </td>
                                        </tr>
                                    </table>
                                </div>
                            </div>
                            <div class="row marginBot20">
                                <div class="col-md-12">
                                    <dx:ASPxGridView runat="server" AutoGenerateColumns="False" ID="gvSale" ClientInstanceName="gvSale" Width="100%"
                                        KeyFieldName="SaleId;EmployeeId;SaleDate;BlockStatus;ShopId;ProductId" OnLoad="gvSale_Load" OnCustomCallback="gvSale_CustomCallback"
                                        OnRowDeleting="gvSale_RowDeleting" DataSourceID="odsSale" OnHtmlRowPrepared="gvSale_HtmlRowPrepared">
                                        <ClientSideEvents EndCallback="gvEndCallback" />
                                        <SettingsCommandButton>
                                            <DeleteButton Text="Delete"></DeleteButton>
                                            <EditButton Text="Edit"></EditButton>
                                        </SettingsCommandButton>
                                        <SettingsBehavior ConfirmDelete="true" AllowFocusedRow="True" AutoExpandAllGroups="true" />
                                        <SettingsText ConfirmDelete="Are you sure?" />
                                        <SettingsEditing EditFormColumnCount="2" Mode="PopupEditForm" />
                                        <Settings HorizontalScrollBarMode="Visible" ShowTitlePanel="true" />
                                        <SettingsDataSecurity AllowInsert="False" />
                                        <SettingsPopup>
                                            <EditForm Width="600" HorizontalAlign="Center" VerticalAlign="Middle" />
                                        </SettingsPopup>
                                        <Styles>
                                            <FixedColumn BackColor="LightYellow"></FixedColumn>
                                            <Header Wrap="True" VerticalAlign="Middle" HorizontalAlign="Center"></Header>
                                            <Cell Wrap="True" VerticalAlign="Middle"></Cell>
                                            <AlternatingRow Enabled="true" />
                                        </Styles>
                                        <Templates>
                                            <EditForm>
                                                <div class="row">
                                                    <div class="col-md-12">
                                                        <dx:ASPxGridViewTemplateReplacement runat="server" ReplacementType="EditFormEditors" />
                                                    </div>
                                                </div>
                                                <div style="text-align: right; padding: 8px 8px 8px">
                                                    <dx:ASPxButton runat="server" ID="btUpdate" Text="Update" CssClass="btn btn-link" AutoPostBack="false">
                                                        <ClientSideEvents Click="function(s,e){gvSale.PerformCallback('update');}" />
                                                    </dx:ASPxButton>
                                                    <dx:ASPxButton runat="server" ID="btCancel" Text="Cancel" CssClass="btn btn-link" AutoPostBack="false">
                                                        <ClientSideEvents Click="function(s,e){gvSale.PerformCallback('cancel');}" />
                                                    </dx:ASPxButton>
                                                </div>
                                            </EditForm>
                                        </Templates>
                                        <Columns>
                                            <dx:GridViewCommandColumn ShowSelectCheckbox="True" Width="40px" VisibleIndex="0" FixedStyle="Left" />
                                            <dx:GridViewDataTextColumn FieldName="Region" VisibleIndex="1" FixedStyle="Left">
                                                <EditFormSettings Visible="False" />
                                            </dx:GridViewDataTextColumn>
                                            <dx:GridViewDataComboBoxColumn FieldName="ShopName" VisibleIndex="2" FixedStyle="Left">
                                                <EditFormSettings VisibleIndex="0" />
                                                <EditItemTemplate>
                                                    <dx:ASPxComboBox runat="server" ID="eCbxOutlets" ClientInstanceName="eCbxOutlets" OnInit="eCbxOutlets_Init"
                                                        DataSourceID="odsEOutlets" EnableCallbackMode="true" CallbackPageSize="10" NullText="Please choose shop name"
                                                        ValueField="ShopId" ValueType="System.Int32"
                                                        DropDownStyle="DropDownList">
                                                        <Columns>
                                                            <dx:ListBoxColumn FieldName="ShopName" Width="150px" />
                                                        </Columns>
                                                    </dx:ASPxComboBox>
                                                </EditItemTemplate>
                                            </dx:GridViewDataComboBoxColumn>
                                            <dx:GridViewDataTextColumn FieldName="SaleDate" Caption="Date" VisibleIndex="3" FixedStyle="Left">
                                                <PropertiesTextEdit DisplayFormatString="{0:yyyy-MM-dd}"></PropertiesTextEdit>
                                                <EditFormSettings VisibleIndex="2" />
                                                <EditItemTemplate>
                                                    <dx:ASPxDateEdit runat="server" ID="txSaleDate" DisplayFormatString="yyyy-MM-dd"
                                                        EditFormat="Custom" EditFormatString="yyyy-MM-dd" Date='<%# Eval("SaleDate") %>'>
                                                        <ClearButton DisplayMode="OnHover"></ClearButton>
                                                    </dx:ASPxDateEdit>
                                                </EditItemTemplate>
                                            </dx:GridViewDataTextColumn>
                                            <dx:GridViewDataTextColumn FieldName="Product" VisibleIndex="4">
                                                <EditFormSettings Visible="False" />
                                            </dx:GridViewDataTextColumn>
                                            <dx:GridViewDataColumn FieldName="Range" VisibleIndex="5">
                                                <EditFormSettings Visible="False" />
                                            </dx:GridViewDataColumn>
                                            <dx:GridViewDataColumn FieldName="Model" VisibleIndex="6" FixedStyle="Left">
                                                <EditFormSettings VisibleIndex="1" />
                                                <EditItemTemplate>
                                                    <dx:ASPxComboBox runat="server" ID="cbeModel" ValueType="System.Int32" NullText="Chọn Model" Width="100%"
                                                        DataSourceID="odseModel" ValueField="ProductId" OnInit="cbeModel_Init"
                                                        ClientInstanceName="cbeModel" CallbackPageSize="5">
                                                        <ClearButton DisplayMode="OnHover"></ClearButton>
                                                        <Columns>
                                                            <dx:ListBoxColumn FieldName="Model" />
                                                        </Columns>
                                                    </dx:ASPxComboBox>
                                                    <asp:ObjectDataSource ID="odseModel" runat="server" SelectMethod="getDivision" TypeName="LogicTier.Controllers.ProductsBL">
                                                        <SelectParameters>
                                                            <asp:Parameter DefaultValue="Type" Name="fieldName" Type="String" />
                                                            <asp:Parameter Name="fieldValue" Type="String" />
                                                            <asp:Parameter DefaultValue="Model" Name="fieldDisplay" Type="String" />
                                                        </SelectParameters>
                                                    </asp:ObjectDataSource>
                                                </EditItemTemplate>
                                            </dx:GridViewDataColumn>
                                            <dx:GridViewDataColumn FieldName="Color" VisibleIndex="9">
                                                <EditFormSettings VisibleIndex="3" />
                                                <EditItemTemplate>
                                                    <dx:ASPxTextBox runat="server" ID="txeColor" Text='<%#Eval("Color") %>'></dx:ASPxTextBox>
                                                </EditItemTemplate>
                                            </dx:GridViewDataColumn>
                                            <dx:GridViewDataColumn FieldName="Quantity" VisibleIndex="7">
                                                <EditFormSettings VisibleIndex="4" />
                                                <EditItemTemplate>
                                                    <dx:ASPxSpinEdit runat="server" ID="txeQuantity" Text='<%#Eval("Quantity") %>'>
                                                        <SpinButtons ShowIncrementButtons="false"></SpinButtons>
                                                    </dx:ASPxSpinEdit>
                                                </EditItemTemplate>
                                            </dx:GridViewDataColumn>
                                            <dx:GridViewDataSpinEditColumn FieldName="Price" VisibleIndex="8">
                                                <EditFormSettings VisibleIndex="5" />
                                                <PropertiesSpinEdit DisplayFormatString="{0:N}" DecimalPlaces="0"></PropertiesSpinEdit>
                                                <EditItemTemplate>
                                                    <dx:ASPxSpinEdit runat="server" ID="txePrice" Text='<%#Eval("Price") %>' DisplayFormatString="{0:C}" DecimalPlaces="3">
                                                        <SpinButtons ShowIncrementButtons="false"></SpinButtons>
                                                    </dx:ASPxSpinEdit>
                                                </EditItemTemplate>
                                            </dx:GridViewDataSpinEditColumn>
                                            <dx:GridViewDataTextColumn FieldName="CusName" VisibleIndex="10" Caption="Customer Name">
                                                <EditFormSettings VisibleIndex="6" />
                                                <EditItemTemplate>
                                                    <dx:ASPxTextBox runat="server" ID="txEcusName" Text='<%#Eval("CusName") %>'></dx:ASPxTextBox>
                                                </EditItemTemplate>
                                            </dx:GridViewDataTextColumn>
                                            <dx:GridViewDataTextColumn FieldName="CusPhone" VisibleIndex="11" Caption="Cell phone">
                                                <EditFormSettings VisibleIndex="7" />
                                                <EditItemTemplate>
                                                    <dx:ASPxTextBox runat="server" ID="txEcusPhone" Text='<%#Eval("CusPhone") %>'></dx:ASPxTextBox>
                                                </EditItemTemplate>
                                            </dx:GridViewDataTextColumn>
                                            <dx:GridViewDataTextColumn FieldName="CussAdd" VisibleIndex="12" Caption="Address">
                                                <EditFormSettings VisibleIndex="8" />
                                                <EditItemTemplate>
                                                    <dx:ASPxTextBox runat="server" ID="txEcusAdd" Text='<%#Eval("CussAdd") %>'></dx:ASPxTextBox>
                                                </EditItemTemplate>
                                            </dx:GridViewDataTextColumn>
                                            <dx:GridViewDataTextColumn FieldName="EmployeeCode" VisibleIndex="13">
                                                <EditFormSettings Visible="False" />
                                            </dx:GridViewDataTextColumn>
                                            <dx:GridViewDataTextColumn FieldName="EmployeeName" VisibleIndex="14">
                                                <EditFormSettings Visible="False" />
                                            </dx:GridViewDataTextColumn>
                                            <dx:GridViewDataColumn FieldName="ConfirmBy" VisibleIndex="15">
                                                <EditFormSettings Visible="False" />
                                            </dx:GridViewDataColumn>
                                            <dx:GridViewDataColumn FieldName="Duplicate" Width="1" VisibleIndex="17">
                                                <EditFormSettings Visible="False" />
                                            </dx:GridViewDataColumn>
                                            <dx:GridViewCommandColumn ShowEditButton="true" ShowDeleteButton="true" VisibleIndex="16">
                                            </dx:GridViewCommandColumn>
                                        </Columns>
                                    </dx:ASPxGridView>
                                    <asp:ObjectDataSource ID="odsSale" runat="server" SelectMethod="dataRawbyadmin" TypeName="LogicTier.Controllers.SaleOutBL">
                                        <SelectParameters>
                                            <asp:Parameter Name="SaleId" Type="Int64" />
                                            <asp:Parameter Name="Region" Type="String" />
                                            <asp:Parameter Name="ObjectId" Type="Int32" />
                                            <asp:Parameter Name="ShopId" Type="Int32" />
                                            <asp:Parameter Name="ShopCode" Type="String" />
                                            <asp:Parameter Name="District" Type="String" />
                                            <asp:Parameter Name="City" Type="String" />
                                            <asp:Parameter Name="FromDate" Type="String" />
                                            <asp:Parameter Name="ToDate" Type="String" />
                                            <asp:Parameter Name="ParentId" Type="Int32" />
                                            <asp:Parameter Name="EmployeeId" Type="Int32" />
                                            <asp:Parameter Name="EmployeeCode" Type="String" />
                                            <asp:Parameter Name="productId" Type="Int32" />
                                            <asp:Parameter Name="product" Type="String" />
                                            <asp:Parameter Name="range" Type="String" />
                                            <asp:Parameter Name="capacity" Type="String" />
                                            <asp:Parameter Name="type" Type="String" />
                                            <asp:Parameter Name="model" Type="String" />
                                            <asp:Parameter Name="BlockStatus" Type="Int32" />
                                            <asp:Parameter Name="userName" Type="String" />
                                            <asp:Parameter Name="Duplicate" Type="Int32" />
                                            <asp:Parameter Name="Ismonth" Type="Boolean" DefaultValue="True" />
                                        </SelectParameters>
                                    </asp:ObjectDataSource>
                                    <asp:ObjectDataSource ID="odsEOutlets" runat="server" SelectMethod="getByEmployee" TypeName="LogicTier.Controllers.OutletBL">
                                        <SelectParameters>
                                            <asp:Parameter Name="empId" Type="Int32" />
                                            <asp:Parameter Name="activeDate" Type="String" />
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
    <dx:ASPxPopupControl ID="pcImport" runat="server" Width="320" CloseAction="CloseButton" CloseOnEscape="true" Modal="True"
        PopupHorizontalAlign="WindowCenter" PopupVerticalAlign="WindowCenter" ClientInstanceName="pcImport"
        HeaderText="Import SO" AllowDragging="True" PopupAnimationType="None" EnableViewState="False" AutoUpdatePosition="true">
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
                                                <dx:ASPxUploadControl ID="UploadControl" runat="server" ClientInstanceName="uploadSO"
                                                    NullText="Bấm để chọn file excel..." OnFileUploadComplete="UploadControl_FileUploadComplete">
                                                    <AdvancedModeSettings EnableMultiSelect="false" EnableDragAndDrop="true" />
                                                    <ValidationSettings MaxFileSize="4194304" AllowedFileExtensions=".xls, .xlsx" ShowErrors="false"></ValidationSettings>
                                                    <ClientSideEvents FileUploadComplete="function(s,e){ 
                                                    if (e.callbackData != '') {
                                                       alert(e.callbackData); pcImport.Hide();
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
                                                        <dx:ASPxButton ID="btOK" runat="server" Text="Import" Width="80px" AutoPostBack="False" CssClass="btn btn-primary">
                                                            <ClientSideEvents Click="function(s, e) { uploadSO.UploadFile();}" />
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