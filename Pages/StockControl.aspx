<%@ Page Title="Stock Report" Language="C#" MasterPageFile="~/Layout.master" Async="true" AutoEventWireup="true" CodeBehind="StockControl.aspx.cs" Inherits="WebApplication.Pages.StockControl" %>

<%@ Register Src="~/UserControls/ToolbarExport.ascx" TagPrefix="uc1" TagName="ToolbarExport" %>
<asp:Content ID="Content1" ContentPlaceHolderID="Content" runat="server">
    <script>
        function OnEndCallback(s, e) {
            if (s.cpAlert != '') {
                alert(s.cpAlert);
            }
        }
        function gvEndCallback(s, e) {
            if (s.cpStock != '') {
                alert(s.cpStock);
            }
        }
        function productChange(s, e) {
            cbModel.PerformCallback(s.GetValue());
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
                                                    <dx:ASPxDateEdit runat="server" Width="100%" ID="fFromDate" DisplayFormatString="yyyy-MM-dd"
                                                        EditFormat="Custom" EditFormatString="yyyy-MM-dd">
                                                        <ClearButton DisplayMode="OnHover"></ClearButton>
                                                    </dx:ASPxDateEdit>
                                                </div>
                                                <div class="col-md-3">
                                                    <label>To</label>
                                                    <dx:ASPxDateEdit runat="server" Width="100%" ID="fToDate" DisplayFormatString="yyyy-MM-dd"
                                                        EditFormat="Custom" EditFormatString="yyyy-MM-dd">
                                                        <ClearButton DisplayMode="OnHover"></ClearButton>
                                                    </dx:ASPxDateEdit>
                                                </div>
                                                <div class="col-md-3">
                                                    <label>Region</label>
                                                    <dx:ASPxComboBox runat="server" Width="100%" ID="cbRegion" ValueField="Region"
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
                                                    <asp:ObjectDataSource ID="odsAccount" runat="server" SelectMethod="getAccountGroup" TypeName="LogicTier.Controllers.StockBL"></asp:ObjectDataSource>
                                                </div>
                                                <div class="col-md-3">
                                                    <label>Outlets</label>
                                                    <dx:ASPxComboBox runat="server" Width="100%" ID="cbOutlet" ValueField="ShopId"
                                                        ValueType="System.Int32" NullText="Choose to filter by Outlet" OnCallback="cbOutlet_Callback"
                                                        ClientInstanceName="cbOutlet" CallbackPageSize="10" DataSourceID="obsgetOutlet"
                                                        IncrementalFilteringMode="Contains" TextFormatString="{0}" EnableCallbackMode="true" DropDownStyle="DropDownList">
                                                        <ClearButton DisplayMode="OnHover"></ClearButton>
                                                        <Columns>
                                                            <dx:ListBoxColumn FieldName="ShopName" Width="100%" />
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
                                                            <asp:ControlParameter ControlID="AddCommentFormLayout$OptionRadioButtonList" Name="Option" Type="Int32" PropertyName="Value" />
                                                        </SelectParameters>
                                                    </asp:ObjectDataSource>
                                                </div>
                                            </div>
                                            <div class="row marginTop20">
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
                                                    <asp:ObjectDataSource ID="odsEmployee" runat="server" SelectMethod="getList"
                                                        TypeName="LogicTier.Controllers.EmployeeBL">
                                                        <SelectParameters>

                                                            <asp:Parameter Name="AccountId" Type="Int32" />
                                                            <asp:Parameter Name="empId" Type="Int32" />
                                                            <asp:Parameter Name="empCode" Type="String" />
                                                            <asp:Parameter Name="pos" Type="String" />
                                                            <asp:Parameter Name="parentId" Type="Int32" />
                                                            <asp:Parameter Name="emplName" Type="Int32" />
                                                            <asp:Parameter Name="userId" Type="String" />

                                                            
                                                            <asp:Parameter Name="emplName" Type="String" DefaultValue="" ConvertEmptyStringToNull="true" />
                                                            <asp:ControlParameter ControlID="AddCommentFormLayout$OptionRadioButtonList" Name="Option" Type="Int32" PropertyName="Value" />
                                                        </SelectParameters>
                                                    </asp:ObjectDataSource>
                                                </div>
                                                <div class="col-md-3">
                                                    <label>Product</label>
                                                    <dx:ASPxComboBox runat="server" ID="cbProduct" ValueField="Product" Width="100%"
                                                        ValueType="System.String" NullText="Chọn Product"
                                                        ClientInstanceName="cbProduct" CallbackPageSize="10" DataSourceID="odsProduct"
                                                        IncrementalFilteringMode="Contains" TextFormatString="{0}" EnableCallbackMode="true" DropDownStyle="DropDownList">
                                                        <ClearButton DisplayMode="OnHover"></ClearButton>
                                                        <ClientSideEvents SelectedIndexChanged="productChange" />
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
                                                    <label>Model</label>
                                                    <dx:ASPxComboBox runat="server" ID="cbModel" ValueType="System.Int32" NullText="Chọn Model" Width="100%"
                                                        DataSourceID="odsModel" ValueField="ProductId" OnCallback="cbModel_Callback"
                                                        ClientInstanceName="cbModel" CallbackPageSize="10"
                                                        IncrementalFilteringMode="Contains" TextFormatString="{0}" EnableCallbackMode="true" DropDownStyle="DropDownList">
                                                        <ClearButton DisplayMode="OnHover"></ClearButton>
                                                        <ClientSideEvents SelectedIndexChanged="
                                                function(s,e){
                                                    ASPxCallbackPanel1.PerformCallback('product;'+s.GetValue());
                                                }" />
                                                        <Columns>
                                                            <dx:ListBoxColumn FieldName="Model" />
                                                        </Columns>
                                                    </dx:ASPxComboBox>
                                                    <asp:ObjectDataSource ID="odsModel" runat="server" SelectMethod="getList" TypeName="LogicTier.Controllers.ProductsBL">
                                                        <SelectParameters>
                                                            <asp:Parameter Name="productId" Type="Int32" />
                                                            <asp:Parameter Name="product" Type="String" />
                                                            <asp:Parameter Name="range" Type="String" />
                                                            <asp:Parameter Name="model" Type="String" />
                                                            <asp:Parameter Name="capacity" Type="String" />
                                                            <asp:Parameter Name="type" Type="String" />
                                                            <asp:Parameter Name="status" Type="Boolean" />
                                                        </SelectParameters>
                                                    </asp:ObjectDataSource>
                                                </div>
                                                <div class="col-md-3">
                                                    <label style="color: white">Tool</label><br />
                                                    <dx:ASPxButton ID="FilterButton" AutoPostBack="false" CssClass="btn btn-primary" runat="server" Text="Tìm kiếm">
                                                        <ClientSideEvents Click="function(s, e) {cp.PerformCallback('filter'); }"></ClientSideEvents>
                                                    </dx:ASPxButton>
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
                            <div class="row marginTop20">
                                <div class="col-md-12">
                                    <uc1:ToolbarExport runat="server" ID="ToolbarExport1" OnItemClick="ToolbarExport1_ItemClick" />
                                    <dx:ASPxGridViewExporter ID="ASPxGridViewExporter1" runat="server" ExportSelectedRowsOnly="true" GridViewID="gvStock">
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
                                                    <ClientSideEvents Click="function(s, e) { gvStock.SelectRows(); }" />
                                                </dx:ASPxButton>
                                            </td>
                                            <td style="padding-right: 4px">
                                                <dx:ASPxButton ID="btnSelectAllOnPage" runat="server" Text="Chọn 1 trang"
                                                    UseSubmitBehavior="False" AutoPostBack="false">
                                                    <ClientSideEvents Click="function(s, e) { gvStock.SelectAllRowsOnPage(); }" />
                                                </dx:ASPxButton>
                                            </td>
                                            <td style="padding-right: 4px">
                                                <dx:ASPxButton ID="btnUnselectAll" runat="server" Text="Bỏ chọn" UseSubmitBehavior="False"
                                                    AutoPostBack="false">
                                                    <ClientSideEvents Click="function(s, e) { gvStock.UnselectRows(); gvStock.UnselectAllRowsOnPage(); }" />
                                                </dx:ASPxButton>
                                            </td>
                                            <td style="padding-right: 4px">
                                                <dx:ASPxButton ID="btnConfirm" runat="server" Text="Confirm Data" UseSubmitBehavior="False" CssClass="btn btn-danger"
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
                                    <dx:ASPxGridView runat="server" AutoGenerateColumns="False" ID="gvStock" ClientInstanceName="gvStock" Width="100%"
                                        KeyFieldName="StockId;EmployeeId;StockDate;BlockStatus;ShopId;ProductId" OnLoad="gvStock_Load" OnCustomCallback="gvStock_CustomCallback"
                                        OnRowDeleting="gvStock_RowDeleting" DataSourceID="odsStock">
                                        <ClientSideEvents EndCallback="gvEndCallback" />
                                        <SettingsCommandButton>
                                            <DeleteButton Text="Delete"></DeleteButton>
                                            <EditButton Text="Edit"></EditButton>
                                            <NewButton Text="New"></NewButton>
                                        </SettingsCommandButton>
                                        <SettingsBehavior ConfirmDelete="true" AllowFocusedRow="True" AutoExpandAllGroups="true" />
                                        <SettingsText ConfirmDelete="Are you sure?" />
                                        <SettingsEditing EditFormColumnCount="2" Mode="PopupEditForm" NewItemRowPosition="Top" />
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
                                                        <ClientSideEvents Click="function(s,e){gvStock.PerformCallback('update');}" />
                                                    </dx:ASPxButton>
                                                    <dx:ASPxButton runat="server" ID="btCancel" Text="Cancel" CssClass="btn btn-link" AutoPostBack="false">
                                                        <ClientSideEvents Click="function(s,e){gvStock.PerformCallback('cancel');}" />
                                                    </dx:ASPxButton>
                                                </div>
                                            </EditForm>
                                        </Templates>
                                        <Columns>
                                            <dx:GridViewCommandColumn ShowSelectCheckbox="True" VisibleIndex="0" FixedStyle="Left" />
                                            <dx:GridViewDataTextColumn FieldName="Region" VisibleIndex="1" FixedStyle="Left">
                                                <EditFormSettings Visible="False" />
                                            </dx:GridViewDataTextColumn>
                                            <dx:GridViewDataTextColumn FieldName="Account" Caption="Dealer" VisibleIndex="2" FixedStyle="Left">
                                                <EditFormSettings Visible="False" />
                                            </dx:GridViewDataTextColumn>
                                            <dx:GridViewDataComboBoxColumn FieldName="ShopName" VisibleIndex="3" FixedStyle="Left" Width="250px">
                                                <EditFormSettings VisibleIndex="0" />
                                                <EditItemTemplate>
                                                    <dx:ASPxComboBox runat="server" ID="eCbxOutlets" ClientInstanceName="eCbxOutlets" OnInit="eCbxOutlets_Init"
                                                        DataSourceID="odsEOutlets" EnableCallbackMode="true" CallbackPageSize="10" NullText="Please choose shop name"
                                                        ValueField="ShopId" ValueType="System.Int32"
                                                        DropDownStyle="DropDownList">
                                                        <Columns>
                                                            <dx:ListBoxColumn FieldName="ShopName" Width="250px" />
                                                        </Columns>
                                                    </dx:ASPxComboBox>
                                                </EditItemTemplate>
                                            </dx:GridViewDataComboBoxColumn>
                                            <dx:GridViewDataTextColumn FieldName="StockDate" VisibleIndex="4" FixedStyle="Left">
                                                <PropertiesTextEdit DisplayFormatString="{0:yyyy-MM-dd}"></PropertiesTextEdit>
                                                <EditFormSettings VisibleIndex="2" />
                                                <EditItemTemplate>
                                                    <dx:ASPxDateEdit runat="server" ID="txStockDate" OnInit="txStockDate_Init" DisplayFormatString="yyyy-MM-dd"
                                                        EditFormat="Custom" EditFormatString="yyyy-MM-dd">
                                                        <ClearButton DisplayMode="OnHover"></ClearButton>
                                                    </dx:ASPxDateEdit>
                                                </EditItemTemplate>
                                            </dx:GridViewDataTextColumn>
                                            <dx:GridViewDataTextColumn FieldName="Product" VisibleIndex="5">
                                                <EditFormSettings Visible="False" />
                                            </dx:GridViewDataTextColumn>
                                            <dx:GridViewDataColumn FieldName="Range" VisibleIndex="6">
                                                <EditFormSettings Visible="False" />
                                            </dx:GridViewDataColumn>
                                            <dx:GridViewDataColumn FieldName="Capacity" VisibleIndex="7">
                                                <EditFormSettings Visible="False" />
                                            </dx:GridViewDataColumn>
                                            <dx:GridViewDataTextColumn FieldName="Type" VisibleIndex="8">
                                                <EditFormSettings Visible="False" />
                                            </dx:GridViewDataTextColumn>
                                            <dx:GridViewDataColumn FieldName="Model" VisibleIndex="9">
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

                                                </EditItemTemplate>
                                            </dx:GridViewDataColumn>
                                            <dx:GridViewDataColumn FieldName="Quantity" VisibleIndex="11">
                                                <EditFormSettings VisibleIndex="3" />
                                                <EditItemTemplate>
                                                    <dx:ASPxSpinEdit runat="server" ID="txeQuantity" Text='<%#Eval("Quantity") %>'>
                                                        <SpinButtons ShowIncrementButtons="false"></SpinButtons>
                                                    </dx:ASPxSpinEdit>
                                                </EditItemTemplate>
                                            </dx:GridViewDataColumn>
                                            <dx:GridViewDataTextColumn FieldName="EmployeeCode" VisibleIndex="16">
                                                <EditFormSettings Visible="False" />
                                            </dx:GridViewDataTextColumn>
                                            <dx:GridViewDataTextColumn FieldName="EmployeeName" VisibleIndex="17">
                                                <EditFormSettings Visible="False" />
                                            </dx:GridViewDataTextColumn>
                                            <dx:GridViewDataColumn FieldName="ConfirmBy" VisibleIndex="18">
                                                <EditFormSettings Visible="False" />
                                            </dx:GridViewDataColumn>
                                            <dx:GridViewCommandColumn ShowNewButtonInHeader="true" ShowEditButton="true" ShowDeleteButton="true" VisibleIndex="19">
                                            </dx:GridViewCommandColumn>
                                        </Columns>
                                    </dx:ASPxGridView>
                                    <asp:ObjectDataSource ID="odsStock" runat="server" SelectMethod="dataRaw" TypeName="LogicTier.Controllers.StockBL">
                                        <SelectParameters>
                                            <asp:Parameter Name="StockId" Type="Int64" />
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
                                    <asp:ObjectDataSource ID="odseModel" runat="server" SelectMethod="getDivision" TypeName="LogicTier.Controllers.ProductsBL">
                                        <SelectParameters>
                                            <asp:Parameter DefaultValue="Type" Name="fieldName" Type="String" />
                                            <asp:Parameter Name="fieldValue" Type="String" />
                                            <asp:Parameter DefaultValue="Model" Name="fieldDisplay" Type="String" />
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
</asp:Content>
