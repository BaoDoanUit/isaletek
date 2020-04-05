<%@ Page Title="Diplays Report" Language="C#" MasterPageFile="~/Layout.master" AutoEventWireup="true" CodeBehind="StockDisplayControl.aspx.cs" Inherits="WebApplication.Pages.StockDisplayControl" %>

<%@ Register Assembly="DevExpress.Web.ASPxPivotGrid.v17.1, Version=17.1.6.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.ASPxPivotGrid" TagPrefix="dx" %>
<%@ Register Src="~/UserControls/ToolbarExport.ascx" TagPrefix="uc1" TagName="ToolbarExport" %>
<asp:Content ID="Content1" ContentPlaceHolderID="Content" runat="server">
    <script>
        function OnEndCallback(s, e) {
            if (s.cpAlert != '') {
                alert(s.cpAlert);
            }
        }

        function SetDate(s, e) {
            hdfKey.Set('SetDate', txdateimport.GetDate());
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
                <dx:ASPxFormLayout ID="AddCommentFormLayout" runat="server" UseDefaultPaddings="false">
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
                                                    <dx:ASPxDateEdit runat="server" ID="fFromDate" Width="100%" DisplayFormatString="yyyy-MM-dd"
                                                        EditFormat="Custom" EditFormatString="yyyy-MM-dd">
                                                        <ClearButton DisplayMode="OnHover"></ClearButton>
                                                    </dx:ASPxDateEdit>
                                                </div>
                                                <div class="col-md-3">
                                                    <label>To</label>
                                                    <dx:ASPxDateEdit runat="server" ID="fToDate" Width="100%" DisplayFormatString="yyyy-MM-dd"
                                                        EditFormat="Custom" EditFormatString="yyyy-MM-dd">
                                                        <ClearButton DisplayMode="OnHover"></ClearButton>
                                                    </dx:ASPxDateEdit>
                                                </div>
                                                <div class="col-md-3">
                                                    <label>Region</label>
                                                    <dx:ASPxComboBox runat="server" ID="cbRegion" Width="100%" ValueField="Region"
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
                                                    <dx:ASPxComboBox runat="server" ID="cbCity" Width="100%" OnCallback="cbCity_Callback"
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
                                                    <dx:ASPxComboBox runat="server" ID="cbAccount" Width="100%" ValueType="System.Int32" NullText="Choose to select Dealer"
                                                        DataSourceID="odsAccount" TextField="Account" ValueField="ObjectId"
                                                        ClientInstanceName="cbAccount" CallbackPageSize="10">
                                                        <ClearButton DisplayMode="OnHover"></ClearButton>
                                                        <ClientSideEvents SelectedIndexChanged="function(s,e){cbOutlet.PerformCallback(cbRegion.GetValue()+';'+cbCity.GetValue()+';'+cbAccount.GetValue());}" />
                                                    </dx:ASPxComboBox>
                                                    <asp:ObjectDataSource ID="odsAccount" runat="server" SelectMethod="getAccountGroup" TypeName="LogicTier.Controllers.SaleOutBL"></asp:ObjectDataSource>
                                                </div>
                                                <div class="col-md-3">
                                                    <label>Outlets</label>
                                                    <dx:ASPxComboBox runat="server" ID="cbOutlet" Width="100%" ValueField="ShopId"
                                                        ValueType="System.Int32" NullText="Choose to filter by Outlet" OnCallback="cbOutlet_Callback"
                                                        ClientInstanceName="cbOutlet" CallbackPageSize="10" DataSourceID="obsgetOutlet"
                                                        IncrementalFilteringMode="Contains" TextFormatString="{0}" EnableCallbackMode="true" DropDownStyle="DropDownList">
                                                        <ClearButton DisplayMode="OnHover"></ClearButton>
                                                        <Columns>
                                                            <dx:ListBoxColumn FieldName="ShopName" Width="250px" />
                                                        </Columns>
                                                    </dx:ASPxComboBox>
                                                    <asp:ObjectDataSource ID="obsgetOutlet" runat="server" SelectMethod="getOutletByUser" TypeName="LogicTier.Controllers.OutletBL">
                                                        <SelectParameters>
                                                            <asp:Parameter Name="EmployeeId" Type="Int32" DefaultValue="" ConvertEmptyStringToNull="true" />
                                                            <asp:Parameter Name="objectId" Type="Int32" DefaultValue="" ConvertEmptyStringToNull="true" />
                                                            <asp:Parameter Name="region" Type="String" DefaultValue="" ConvertEmptyStringToNull="true" />
                                                            <asp:Parameter Name="shopCode" Type="String" DefaultValue="" ConvertEmptyStringToNull="true" />
                                                            <asp:Parameter Name="shopName" Type="String" DefaultValue="" ConvertEmptyStringToNull="true" />
                                                        </SelectParameters>
                                                    </asp:ObjectDataSource>
                                                </div>
                                                <div class="col-md-3">
                                                    <label>Suppervisor</label>
                                                    <dx:ASPxComboBox runat="server" ID="cbLearder" Width="100%" ValueField="EmployeeId"
                                                        ValueType="System.Int32" NullText="Choose to filter by Leader person"
                                                        ClientInstanceName="cbLearder" CallbackPageSize="10" DataSourceID="odsLeader" OnInit="cbLearder_Init" OnCallback="cbLearder_Callback"
                                                        IncrementalFilteringMode="Contains" TextFormatString="{0}" EnableCallbackMode="true" DropDownStyle="DropDownList">
                                                        <ClientSideEvents SelectedIndexChanged="function(s,e){cbEmployee.PerformCallback(s.GetValue());}" />
                                                        <ClearButton DisplayMode="OnHover"></ClearButton>
                                                        <Columns>
                                                            <dx:ListBoxColumn FieldName="EmployeeName" />
                                                        </Columns>
                                                    </dx:ASPxComboBox>
                                                    <asp:ObjectDataSource ID="odsLeader" runat="server" SelectMethod="getList" TypeName="LogicTier.Controllers.EmployeeBL">
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
                                                    <dx:ASPxComboBox runat="server" ID="cbEmployee" Width="100%" OnCallback="cbEmployee_Callback"
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
                                            <div class="row marginTop20">
                                                <div class="col-md-3">
                                                    <label>Lọc NV</label>
                                                    <dx:ASPxRadioButtonList ID="OptionRadioButtonList" runat="server" Paddings-PaddingLeft="1" Paddings-PaddingRight="1" Paddings-PaddingBottom="1" Paddings-PaddingTop="1" RepeatColumns="2" Width="100%"
                                                        RepeatLayout="UnorderedList">
                                                        <ClientSideEvents SelectedIndexChanged="function(s,e){cbLearder.PerformCallback('Sup');cbEmployee.PerformCallback();}" />
                                                        <Items>
                                                            <dx:ListEditItem Selected="true" Text="Tất cả NV" Value="0" />
                                                            <dx:ListEditItem Text="NV còn làm việc" Value="-1" />
                                                        </Items>
                                                    </dx:ASPxRadioButtonList>
                                                </div>
                                                <div class="col-md-3">
                                                    <label style="color: white">Tool</label><br />
                                                    <dx:ASPxButton ID="FilterButton" AutoPostBack="false" runat="server" CssClass="btn btn-primary" Text="Tìm kiếm">
                                                        <ClientSideEvents Click="function(s, e) {  cp.PerformCallback('filter'); }"></ClientSideEvents>
                                                    </dx:ASPxButton>
                                                    <dx:ASPxButton ID="btImport" AutoPostBack="false" runat="server" Text="Import" CssClass="btn btn-warning">
                                                        <ClientSideEvents Click="function(s, e) { pcImport.Show(); }" />
                                                    </dx:ASPxButton>
                                                    <a href="/Content/template/Display_Template.xlsx">Template</a>
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
                    <div class="row marginTop20">
                        <div class="col-md-12">
                            <dx:ASPxPageControl ID="ASPxPageControl1" runat="server" ActiveTabIndex="0" Width="100%">
                                <TabPages>
                                    <dx:TabPage Text="Summary">
                                        <ContentCollection>
                                            <dx:ContentControl runat="server">
                                                <dx:ASPxPivotGrid ID="gvSale" runat="server" OnLoad="gvSale_Load" OnCustomFieldSort="gvSale_CustomFieldSort"
                                                    DataSourceID="odsSale" Width="100%" ClientIDMode="AutoID">
                                                    <Fields>
                                                        <dx:PivotGridField Area="ColumnArea" AreaIndex="0" FieldName="Product" ID="fieldProduct" SortMode="Custom">
                                                            <CellStyle HorizontalAlign="Center"></CellStyle>
                                                            <HeaderStyle HorizontalAlign="Center" />
                                                        </dx:PivotGridField>
                                                        <dx:PivotGridField Area="ColumnArea" AreaIndex="1" FieldName="Range" ID="fieldRange">
                                                            <CellStyle HorizontalAlign="Center"></CellStyle>
                                                            <HeaderStyle HorizontalAlign="Center" />
                                                        </dx:PivotGridField>
                                                        <dx:PivotGridField Area="RowArea" AreaIndex="0" FieldName="ShopName" ID="fieldShopName" Options-AllowExpand="False" />
                                                        <dx:PivotGridField Area="RowArea" AreaIndex="1" FieldName="Account" ID="fieldAccount" Options-AllowExpand="False" />
                                                        <dx:PivotGridField Area="RowArea" AreaIndex="2" FieldName="Region" ID="fieldRegion" Options-AllowExpand="False" />
                                                        <dx:PivotGridField Area="RowArea" AreaIndex="3" FieldName="City" ID="fieldCity" Options-AllowExpand="False" />
                                                        <dx:PivotGridField Area="RowArea" AreaIndex="4" FieldName="ReportDate" ID="fieldReportDate" ValueFormat-FormatString="yyyy-MM-dd" ValueFormat-FormatType="DateTime">
                                                        </dx:PivotGridField>
                                                        <dx:PivotGridField ID="fieldDisplay" Area="DataArea" AreaIndex="4" FieldName="Display">
                                                        </dx:PivotGridField>
                                                    </Fields>
                                                    <OptionsView HorizontalScrollBarMode="Auto" ShowColumnGrandTotals="False" ShowRowTotals="False" ShowRowGrandTotals="False" />
                                                    <OptionsFilter NativeCheckBoxes="False" ShowOnlyAvailableItems="true" />
                                                </dx:ASPxPivotGrid>
                                            </dx:ContentControl>
                                        </ContentCollection>
                                    </dx:TabPage>
                                    <dx:TabPage Text="Raw data">
                                        <ContentCollection>
                                            <dx:ContentControl runat="server">
                                                <div class="row">
                                                    <div class="col-md-12">
                                                        <uc1:ToolbarExport runat="server" ID="ToolbarExport2" OnItemClick="ToolbarExport_ItemClick" />
                                                        <dx:ASPxGridViewExporter ID="ASPxGridViewExporter1" runat="server" ExportSelectedRowsOnly="true" GridViewID="gridstockdisplay">
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
                                                                        <ClientSideEvents Click="function(s, e) { gridstockdisplay.SelectRows(); }" />
                                                                    </dx:ASPxButton>
                                                                </td>
                                                                <td style="padding-right: 4px">
                                                                    <dx:ASPxButton ID="btnSelectAllOnPage" runat="server" Text="Chọn 1 trang"
                                                                        UseSubmitBehavior="False" AutoPostBack="false">
                                                                        <ClientSideEvents Click="function(s, e) { gridstockdisplay.SelectAllRowsOnPage(); }" />
                                                                    </dx:ASPxButton>
                                                                </td>
                                                                <td style="padding-right: 4px">
                                                                    <dx:ASPxButton ID="btnUnselectAll" runat="server" Text="Bỏ chọn" UseSubmitBehavior="False"
                                                                        AutoPostBack="false">
                                                                        <ClientSideEvents Click="function(s, e) { gridstockdisplay.UnselectRows(); gvSale.UnselectAllRowsOnPage(); }" />
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
                                                <dx:ASPxGridView runat="server" AutoGenerateColumns="False" ID="gridstockdisplay" ClientInstanceName="gridstockdisplay" Width="1200px"
                                                    KeyFieldName="Id" OnLoad="gridstockdisplay_Load" DataSourceID="odsSale"
                                                    OnRowUpdating="gridstockdisplay_RowUpdating" 
                                                    OnRowDeleting="gridstockdisplay_RowDeleting" 
                                                    OnRowInserting="gridstockdisplay_RowInserting">
                                                    <SettingsCommandButton>
                                                        <NewButton Text="New"></NewButton>
                                                        <DeleteButton Text="Delete"></DeleteButton>
                                                        <EditButton Text="Edit"></EditButton>
                                                    </SettingsCommandButton>
                                                    <SettingsBehavior ConfirmDelete="true" AllowFocusedRow="True" AutoExpandAllGroups="true" />
                                                    <SettingsText ConfirmDelete="Are you sure?" />
                                                    <SettingsEditing EditFormColumnCount="2" Mode="EditForm" NewItemRowPosition="Top" />
                                                    <Settings HorizontalScrollBarMode="Visible" ShowTitlePanel="true" />
                                                    <SettingsPopup>
                                                        <EditForm Width="600" HorizontalAlign="Center" VerticalAlign="Middle" />
                                                    </SettingsPopup>
                                                    <Styles>
                                                        <FixedColumn BackColor="LightYellow"></FixedColumn>
                                                        <Header Wrap="True" VerticalAlign="Middle" HorizontalAlign="Center"></Header>
                                                        <Cell Wrap="True" VerticalAlign="Middle"></Cell>
                                                        <AlternatingRow Enabled="true" />
                                                    </Styles>
                                                    <Columns>
                                                        <dx:GridViewCommandColumn ShowSelectCheckbox="True" VisibleIndex="0" FixedStyle="Left" />
                                                        <dx:GridViewDataTextColumn FieldName="Region" VisibleIndex="1" FixedStyle="Left">
                                                            <EditFormSettings Visible="False" />
                                                        </dx:GridViewDataTextColumn>
                                                        <dx:GridViewDataComboBoxColumn FieldName="ShopName" VisibleIndex="2" FixedStyle="Left">
                                                            <EditFormSettings VisibleIndex="0"  />
                                                            <EditItemTemplate>
                                                                <dx:ASPxComboBox runat="server" ID="eCbxOutlets" 
                                                                    Enabled="false"
                                                                    ClientInstanceName="eCbxOutlets" OnInit="eCbxOutlets_Init" Width="100%"
                                                                    DataSourceID="odsEOutlets" EnableCallbackMode="true" CallbackPageSize="10" NullText="Please choose shop name"
                                                                    ValueField="ShopId" ValueType="System.Int32"
                                                                    DropDownStyle="DropDownList">
                                                                    <Columns>
                                                                        <dx:ListBoxColumn FieldName="ShopName" Width="150px" />
                                                                    </Columns>
                                                                </dx:ASPxComboBox>
                                                                <validationsettings display="Dynamic" errordisplaymode="Text" errortextposition="Bottom">
                                                                    <RequiredField IsRequired="true" ErrorText="Bạn chưa nhập cửa hàng." />
                                                                </validationsettings>
                                                            </EditItemTemplate>
                                                        </dx:GridViewDataComboBoxColumn>
                                                        <dx:GridViewDataComboBoxColumn FieldName="EmployeeName" Caption="Employee" VisibleIndex="3" FixedStyle="Left">
                                                            <EditFormSettings VisibleIndex="1"  />
                                                            <EditItemTemplate>
                                                                <dx:ASPxComboBox runat="server" ID="cbeditEmployee"
                                                                     Enabled="false"
                                                                    OnInit="cbeditEmployee_Init" Width="100%"
                                                                    ValueType="System.Int32" NullText="Choose to filter by Employee person" ValueField="EmployeeId"
                                                                    ClientInstanceName="cbeditEmployee" CallbackPageSize="10" DataSourceID="odsEditemployee"
                                                                    IncrementalFilteringMode="Contains" TextFormatString="{0}" EnableCallbackMode="true" DropDownStyle="DropDownList">
                                                                    <ClearButton DisplayMode="OnHover"></ClearButton>
                                                                    <Columns>
                                                                        <dx:ListBoxColumn FieldName="EmployeeName" />
                                                                    </Columns>
                                                                </dx:ASPxComboBox>
                                                                <validationsettings display="Dynamic" errordisplaymode="Text" errortextposition="Bottom">
                                                                    <RequiredField IsRequired="true" ErrorText="Bạn chưa nhập cửa hàng." />
                                                                </validationsettings>
                                                            </EditItemTemplate>
                                                        </dx:GridViewDataComboBoxColumn>

                                                        <dx:GridViewDataDateColumn FieldName="ReportDate" Caption="Report date" VisibleIndex="4" FixedStyle="Left">
                                                            <EditFormSettings VisibleIndex="2" />
                                                            <EditItemTemplate>
                                                                <dx:ASPxDateEdit runat="server" 
                                                                     Enabled="false"
                                                                    ID="txtReportDate" OnInit="txtReportDate_Init" DisplayFormatString="yyyy-MM-dd"
                                                                    EditFormat="Custom" EditFormatString="yyyy-MM-dd">
                                                                    <ClearButton DisplayMode="OnHover"></ClearButton>
                                                                </dx:ASPxDateEdit>
                                                            </EditItemTemplate>
                                                            <EditFormSettings VisibleIndex="2" />
                                                        </dx:GridViewDataDateColumn>
                                                        <dx:GridViewDataColumn FieldName="Range" VisibleIndex="6" FixedStyle="Left">
                                                            <EditFormSettings Visible="False" />
                                                        </dx:GridViewDataColumn>
                                                        <dx:GridViewDataColumn FieldName="Product" VisibleIndex="7" FixedStyle="Left">
                                                            <EditFormSettings VisibleIndex="2"  />
                                                            <EditItemTemplate>
                                                                <dx:ASPxComboBox runat="server" ID="cbeProduct" ValueType="System.String" 
                                                                    Enabled="false" NullText="Chọn Product" Width="100%"
                                                                    DataSourceID="odseProduct" ValueField="Model" OnInit="cbeProduct_Init" Value='<%# Eval("Product") %>'
                                                                    ClientInstanceName="cbeProduct" CallbackPageSize="5">
                                                                    <ClearButton DisplayMode="OnHover"></ClearButton>
                                                                    <Columns>
                                                                        <dx:ListBoxColumn FieldName="Model" />
                                                                    </Columns>
                                                                </dx:ASPxComboBox>
                                                                <validationsettings display="Dynamic" errordisplaymode="Text" errortextposition="Bottom">
                                                                    <RequiredField IsRequired="true" ErrorText="Bạn chưa nhập Model." />
                                                                </validationsettings>
                                                                <asp:ObjectDataSource ID="odseProduct" runat="server" SelectMethod="getDivision" TypeName="LogicTier.Controllers.ProductsBL">
                                                                    <SelectParameters>
                                                                        <asp:Parameter DefaultValue="Type" Name="fieldName" Type="String" />
                                                                        <asp:Parameter Name="fieldValue" Type="String" />
                                                                        <asp:Parameter DefaultValue="Model" Name="fieldDisplay" Type="String" />
                                                                    </SelectParameters>
                                                                </asp:ObjectDataSource>
                                                            </EditItemTemplate>
                                                        </dx:GridViewDataColumn>
                                                        <dx:GridViewDataColumn FieldName="Model" VisibleIndex="8" FixedStyle="Left">
                                                            <EditFormSettings VisibleIndex="3"  />
                                                            <EditItemTemplate>
                                                                <dx:ASPxComboBox runat="server" ID="cbeModel" ValueType="System.String" 
                                                                     Enabled="false" NullText="Chọn Model" Width="100%"
                                                                    DataSourceID="odseModel" ValueField="Model" OnInit="cbeModel_Init" Value='<%# Eval("Model") %>'
                                                                    ClientInstanceName="cbeModel" CallbackPageSize="5">
                                                                    <ClearButton DisplayMode="OnHover"></ClearButton>
                                                                    <Columns>
                                                                        <dx:ListBoxColumn FieldName="Model" />
                                                                    </Columns>
                                                                </dx:ASPxComboBox>
                                                                <validationsettings display="Dynamic" errordisplaymode="Text" errortextposition="Bottom">
                                                                    <RequiredField IsRequired="true" ErrorText="Bạn chưa nhập Model." />
                                                                </validationsettings>
                                                                <asp:ObjectDataSource ID="odseModel" runat="server" SelectMethod="getDivision" TypeName="LogicTier.Controllers.ProductsBL">
                                                                    <SelectParameters>
                                                                        <asp:Parameter DefaultValue="Type" Name="fieldName" Type="String" />
                                                                        <asp:Parameter Name="fieldValue" Type="String" />
                                                                        <asp:Parameter DefaultValue="Model" Name="fieldDisplay" Type="String" />
                                                                    </SelectParameters>
                                                                </asp:ObjectDataSource>
                                                            </EditItemTemplate>
                                                        </dx:GridViewDataColumn>
                                                        <dx:GridViewDataSpinEditColumn FieldName="Display" VisibleIndex="9">
                                                            <PropertiesSpinEdit DisplayFormatString="g"></PropertiesSpinEdit>

                                                            <EditFormSettings VisibleIndex="4" />
                                                            <EditItemTemplate>
                                                                <dx:ASPxSpinEdit runat="server" ID="txeDisplay" Text='<%#Eval("Display") %>' MinValue="0" MaxValue="99">
                                                                    <SpinButtons ShowIncrementButtons="false"></SpinButtons>
                                                                </dx:ASPxSpinEdit>
                                                            </EditItemTemplate>
                                                        </dx:GridViewDataSpinEditColumn>

                                                        <dx:GridViewDataSpinEditColumn FieldName="City" VisibleIndex="9">
                                                            <PropertiesSpinEdit DisplayFormatString="g"></PropertiesSpinEdit>
                                                            <EditFormSettings Visible="False" />
                                                        </dx:GridViewDataSpinEditColumn>
                                                        <dx:GridViewCommandColumn ShowNewButtonInHeader="true" ShowEditButton="true" ShowDeleteButton="true" VisibleIndex="10">
                                                        </dx:GridViewCommandColumn>
                                                        <dx:GridViewDataSpinEditColumn Visible="false" FieldName="ShopId" VisibleIndex="11">
                                                            <PropertiesSpinEdit DisplayFormatString="g"></PropertiesSpinEdit>
                                                            <EditFormSettings Visible="False" />

                                                        </dx:GridViewDataSpinEditColumn>
                                                    </Columns>
                                                    <Templates>
                                                        <EditForm>
                                                            <div style="padding: 4px 4px 3px 4px">
                                                                <dx:ASPxGridViewTemplateReplacement ID="IDEditors" runat="server" ReplacementType="EditFormEditors" />
                                                            </div>

                                                            <div style="text-align: right; padding: 2px 2px 2px 2px">
                                                                <dx:ASPxHyperLink ID="UpdateLink" runat="server" CssClass="edInline" ClientEnabled="true" Text="Update" ClientInstanceName="btnupdate"
                                                                    NavigateUrl="javascript:return false;" ValidationSettings-ValidationGroup="<%# Container.ValidationGroup %>">
                                                                    <ClientSideEvents Click="function(s, e) {gridstockdisplay.UpdateEdit();}" />
                                                                </dx:ASPxHyperLink>
                                                                <dx:ASPxHyperLink ID="ASPxHyperLink1" runat="server" CssClass="edInline" ClientEnabled="true" Text="Cancel"
                                                                    NavigateUrl="javascript:return false;">
                                                                    <ClientSideEvents Click="function(s, e) {gridstockdisplay.CancelEdit();}" />
                                                                </dx:ASPxHyperLink>
                                                            </div>
                                                        </EditForm>
                                                    </Templates>
                                                </dx:ASPxGridView>
                                            </dx:ContentControl>
                                        </ContentCollection>
                                    </dx:TabPage>
                                    <dx:TabPage Text="Weekly Report">
                                        <ContentCollection>
                                            <dx:ContentControl runat="server">
                                                <div class="row marginTop20">
                                                    <div class="col-md-12" style="min-height: 500px; margin-top: 30px">
                                                        <dx:ASPxFormLayout ID="ASPxFormLayout1" runat="server" UseDefaultPaddings="false">
                                                            <SettingsItems Width="100%" />
                                                            <SettingsItemCaptions Location="Top" />
                                                            <Items>
                                                                <dx:LayoutGroup Caption="" ColCount="5">
                                                                    <Items>
                                                                        <dx:LayoutItem Caption="Year">
                                                                            <LayoutItemNestedControlCollection>
                                                                                <dx:LayoutItemNestedControlContainer>
                                                                                    <dx:ASPxComboBox runat="server" ID="ddlYear">
                                                                                        <Items>
                                                                                            <dx:ListEditItem Text="2018" Value="2018" />
                                                                                            <dx:ListEditItem Text="2019" Value="2019" />
                                                                                            <dx:ListEditItem Text="2020" Value="2020" />
                                                                                        </Items>
                                                                                        <ClientSideEvents SelectedIndexChanged="function(s, e) {  ddlWeek.PerformCallback(); }" />
                                                                                    </dx:ASPxComboBox>
                                                                                </dx:LayoutItemNestedControlContainer>
                                                                            </LayoutItemNestedControlCollection>
                                                                        </dx:LayoutItem>
                                                                        <dx:LayoutItem Caption="Week">
                                                                            <LayoutItemNestedControlCollection>
                                                                                <dx:LayoutItemNestedControlContainer>
                                                                                    <dx:ASPxComboBox runat="server" ID="ddlWeek" OnCallback="ddlWeek_Callback" Width="200px"
                                                                                        ValueType="System.Int32" ValueField="WeekByYear"
                                                                                        ClientInstanceName="ddlWeek" CallbackPageSize="100" DataSourceID="odsweek"
                                                                                        IncrementalFilteringMode="Contains" TextFormatString="{0}" EnableCallbackMode="true" DropDownStyle="DropDownList">
                                                                                        <ClearButton DisplayMode="OnHover"></ClearButton>
                                                                                        <Columns>
                                                                                            <dx:ListBoxColumn FieldName="Name" />
                                                                                        </Columns>
                                                                                    </dx:ASPxComboBox>
                                                                                    <asp:ObjectDataSource ID="odsweek" runat="server" SelectMethod="GetWeek" TypeName="LogicTier.Controllers.WeekBL">
                                                                                        <SelectParameters>
                                                                                            <asp:ControlParameter ControlID="ddlYear" Name="Year" PropertyName="Value" Type="Int32" />
                                                                                        </SelectParameters>
                                                                                    </asp:ObjectDataSource>
                                                                                </dx:LayoutItemNestedControlContainer>
                                                                            </LayoutItemNestedControlCollection>
                                                                        </dx:LayoutItem>
                                                                        <dx:LayoutItem ShowCaption="False">
                                                                            <LayoutItemNestedControlCollection>
                                                                                <dx:LayoutItemNestedControlContainer>
                                                                                    <dx:ASPxButton ID="ASPxButton1" AutoPostBack="false" runat="server" Text="Export">
                                                                                        <ClientSideEvents Click="function(s, e) {  ImageExcelCallbackPanel.PerformCallback(); }"></ClientSideEvents>
                                                                                    </dx:ASPxButton>
                                                                                    <dx:ASPxCallbackPanel runat="server" ID="ImageExcelCallbackPanel" Width="100%" ClientInstanceName="ImageExcelCallbackPanel"
                                                                                        OnCallback="ImageExcelCallbackPanel_Callback" SettingsLoadingPanel-Text="Exporting Data, please wait.">
                                                                                        <PanelCollection>
                                                                                            <dx:PanelContent ID="PanelContent3" runat="server">
                                                                                                <asp:HyperLink ID="hplexcel" runat="server"></asp:HyperLink>
                                                                                            </dx:PanelContent>
                                                                                        </PanelCollection>
                                                                                    </dx:ASPxCallbackPanel>
                                                                                </dx:LayoutItemNestedControlContainer>
                                                                            </LayoutItemNestedControlCollection>
                                                                        </dx:LayoutItem>
                                                                    </Items>
                                                                </dx:LayoutGroup>
                                                            </Items>
                                                        </dx:ASPxFormLayout>
                                                    </div>
                                                </div>
                                            </dx:ContentControl>
                                        </ContentCollection>
                                    </dx:TabPage>
                                </TabPages>
                            </dx:ASPxPageControl>
                            <asp:ObjectDataSource ID="odsSale" runat="server" SelectMethod="dataRaw" TypeName="LogicTier.Controllers.StockDisplayBL">
                                <SelectParameters>
                                    <asp:Parameter Name="Id" Type="Int64" />
                                    <asp:Parameter Name="Region" Type="String" />
                                    <asp:Parameter Name="ObjectId" Type="Int32" />
                                    <asp:Parameter Name="ShopId" Type="Int32" />
                                    <asp:Parameter Name="shopCode" Type="String" />
                                    <asp:Parameter Name="District" Type="String" />
                                    <asp:Parameter Name="city" Type="String" />
                                    <asp:Parameter Name="FromDate" Type="String" />
                                    <asp:Parameter Name="ToDate" Type="String" />
                                    <asp:Parameter Name="ParentId" Type="Int32" />
                                    <asp:Parameter Name="EmployeeId" Type="Int32" />
                                    <asp:Parameter Name="EmployeeCode" Type="String" />
                                    <asp:Parameter Name="product" Type="String" />
                                    <asp:Parameter Name="model" Type="String" />
                                    <asp:Parameter Name="BlockStatus" Type="Int32" />
                                    <asp:Parameter Name="userName" Type="String" />
                                </SelectParameters>
                            </asp:ObjectDataSource>
                            <asp:ObjectDataSource ID="odsEOutlets" runat="server" SelectMethod="getByEmployee" TypeName="LogicTier.Controllers.OutletBL">
                                <SelectParameters>
                                    <asp:Parameter Name="empId" Type="Int32" />
                                    <asp:Parameter Name="activeDate" Type="String" />
                                </SelectParameters>
                            </asp:ObjectDataSource>
                            <asp:ObjectDataSource ID="odsEditemployee" runat="server" 
                                SelectMethod="getList" TypeName="LogicTier.Controllers.EmployeeBL">
                                <SelectParameters>
                                    <asp:Parameter Name ="AccountId" Type ="Int32" />
                                    <asp:Parameter Name="empId" Type="Int32" />
                                    <asp:Parameter Name="empCode" Type="String" />
                                    <asp:Parameter Name="pos" Type="String" />
                                    <asp:Parameter Name="parentId" Type="Int32" />
                                    <asp:Parameter Name="emplName" Type="Int32" />
                                    <asp:Parameter Name="Option" Type="Int32" DefaultValue="0" />
                                    <asp:Parameter Name="userId" Type="String" />
                                </SelectParameters>
                            </asp:ObjectDataSource>
                        </div>
                    </div>
                </dx:PanelContent>
            </PanelCollection>
        </dx:ASPxCallbackPanel>
    </div>
    <dx:ASPxPopupControl ID="pcImport" runat="server" Width="320" CloseAction="CloseButton" CloseOnEscape="true" Modal="True"
        PopupHorizontalAlign="WindowCenter" PopupVerticalAlign="WindowCenter" ClientInstanceName="pcImport"
        HeaderText="Import Target" AllowDragging="True" PopupAnimationType="None" EnableViewState="False" AutoUpdatePosition="true">
        <ContentCollection>
            <dx:PopupControlContentControl runat="server">
                <dx:ASPxFormLayout runat="server" ID="ASPxFormLayout2" Width="100%" Height="100%">
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
                                                        pcImport.Hide();
                                                   }}" />
                                        <ProgressBarSettings ShowPosition="true" DisplayMode="Percentage" />
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
                                                <ClientSideEvents Click="function(s, e) { upload.UploadFile();}" />
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
            </dx:PopupControlContentControl>
        </ContentCollection>
        <ContentStyle>
            <Paddings PaddingBottom="5px" />
        </ContentStyle>
    </dx:ASPxPopupControl>
    <dx:ASPxHiddenField ID="hdfKey" ClientInstanceName="hdfKey" runat="server"></dx:ASPxHiddenField>
</asp:Content>