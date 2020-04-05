<%@ Page Title="Sale Out Report" Language="C#" MasterPageFile="~/Layout.master" AutoEventWireup="true" CodeBehind="SummaryReport.aspx.cs" Inherits="WebApplication.Pages.SummaryReport" Async="true" %>

<%@ Register Assembly="DevExpress.Web.ASPxPivotGrid.v17.1, Version=17.1.6.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.ASPxPivotGrid" TagPrefix="dx" %>
<%@ Register Src="~/UserControls/ToolbarExport.ascx" TagPrefix="uc1" TagName="ToolbarExport" %>

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
                                                    <dx:ASPxDateEdit runat="server" ID="fFromDate" DisplayFormatString="yyyy-MM-dd" Width="100%"
                                                        EditFormat="Custom" EditFormatString="yyyy-MM-dd">
                                                        <ClearButton DisplayMode="OnHover"></ClearButton>
                                                    </dx:ASPxDateEdit>
                                                </div>
                                                <div class="col-md-3">
                                                    <label>To</label>
                                                    <dx:ASPxDateEdit runat="server" ID="fToDate" DisplayFormatString="yyyy-MM-dd" Width="100%"
                                                        EditFormat="Custom" EditFormatString="yyyy-MM-dd">
                                                        <ClearButton DisplayMode="OnHover"></ClearButton>
                                                    </dx:ASPxDateEdit>
                                                </div>
                                                <div class="col-md-3">
                                                    <label>Region</label>
                                                    <dx:ASPxComboBox runat="server" ID="cbRegion" ValueField="Region" Width="100%"
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
                                                    <dx:ASPxComboBox runat="server" ID="cbCity" OnCallback="cbCity_Callback" Width="100%"
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
                                                    <dx:ASPxComboBox runat="server" ID="cbAccount" ValueType="System.Int32" NullText="Choose to select Dealer" Width="100%"
                                                        DataSourceID="odsAccount" TextField="Account" ValueField="ObjectId"
                                                        ClientInstanceName="cbAccount" CallbackPageSize="10">
                                                        <ClearButton DisplayMode="OnHover"></ClearButton>
                                                        <ClientSideEvents SelectedIndexChanged="function(s,e){cbOutlet.PerformCallback(cbRegion.GetValue()+';'+cbCity.GetValue()+';'+cbAccount.GetValue());}" />
                                                    </dx:ASPxComboBox>
                                                    <asp:ObjectDataSource ID="odsAccount" runat="server" SelectMethod="getAccountGroup" TypeName="LogicTier.Controllers.SaleOutBL"></asp:ObjectDataSource>
                                                </div>
                                                <div class="col-md-3">
                                                    <label>Outlets</label>
                                                    <dx:ASPxComboBox runat="server" ID="cbOutlet" ValueField="ShopId" Width="100%"
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
                                                    <label>Suppervisor</label>
                                                    <dx:ASPxComboBox runat="server" ID="cbLearder" ValueField="EmployeeId" Width="100%"
                                                        ValueType="System.Int32" NullText="Choose to filter by Leader person" OnCallback="cbLearder_Callback"
                                                        ClientInstanceName="cbLearder" CallbackPageSize="10" DataSourceID="odsLeader" OnInit="cbLearder_Init"
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
                                                            <asp:Parameter Name="emplName" Type="String" DefaultValue="" ConvertEmptyStringToNull="true" />
                                                            <asp:ControlParameter ControlID="AddCommentFormLayout$OptionRadioButtonList" Name="Option" Type="Int32" PropertyName="Value" />
                                                            <asp:Parameter Name="userId" Type="Int32" />
                                                        </SelectParameters>
                                                    </asp:ObjectDataSource>
                                                </div>
                                                <div class="col-md-3">
                                                    <label>Employee</label>
                                                    <dx:ASPxComboBox runat="server" ID="cbEmployee" OnCallback="cbEmployee_Callback" Width="100%"
                                                        ValueType="System.Int32" NullText="Choose to filter by Employee person" 
                                                        ValueField="EmployeeId"
                                                        ClientInstanceName="cbEmployee"  DataSourceID="odsEmployee"
                                                        IncrementalFilteringMode="Contains" TextFormatString="{0}" EnableCallbackMode="true" DropDownStyle="DropDownList">
                                                        <ClearButton DisplayMode="OnHover"></ClearButton>
                                                        <Columns>
                                                            <dx:ListBoxColumn FieldName="EmployeeName" />
                                                        </Columns>
                                                    </dx:ASPxComboBox>
                                                    <asp:ObjectDataSource ID="odsEmployee" 
                                                        runat="server" SelectMethod="getList" TypeName="LogicTier.Controllers.EmployeeBL">
                                                        <SelectParameters>
                                                            <asp:Parameter Name="AccountId" Type="Int32" DefaultValue="" ConvertEmptyStringToNull="true" />
                                                            <asp:Parameter Name="empId" Type="Int32" />
                                                            <asp:Parameter Name="empCode" Type="String" />
                                                            <asp:Parameter Name="pos" Type="String" />
                                                            <asp:Parameter Name="parentId" Type="Int32" />
                                                            <asp:Parameter Name="emplName" Type="String" DefaultValue="" ConvertEmptyStringToNull="true" />
                                                            <asp:ControlParameter ControlID="AddCommentFormLayout$OptionRadioButtonList" Name="Option" Type="Int32" PropertyName="Value" />
                                                            <asp:Parameter Name="userId" Type="Int32" />
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
                                                    <dx:ASPxComboBox runat="server" ID="cbRange" OnCallback="cbRange_Callback" Width="100%"
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
                                                    <dx:ASPxComboBox runat="server" ID="cbCapacity" ValueType="System.String" NullText="Chọn Capacity" Width="100%"
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
                                                    <dx:ASPxComboBox runat="server" ID="cbType" ValueType="System.String" NullText="Chọn Type" Width="100%"
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
                                                <div class="col-md-3">
                                                    <label>Model</label>
                                                    <dx:ASPxComboBox runat="server" ID="cbModel" ValueType="System.Int32" NullText="Chọn Model" Width="100%"
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
                                            </div>
                                            <div class="row marginTop20">
                                                <div class="col-md-3">
                                                    <label>Type report</label>
                                                    <dx:ASPxComboBox runat="server" ID="cbreporttype" ValueType="System.String" NullText="Chọn Type" Width="100%"
                                                        TextField="Type" ValueField="Type"
                                                        ClientInstanceName="cbType" CallbackPageSize="10"
                                                        IncrementalFilteringMode="Contains" TextFormatString="{0}" EnableCallbackMode="true" DropDownStyle="DropDownList">
                                                        <ClearButton DisplayMode="OnHover"></ClearButton>
                                                        <Items>
                                                            <dx:ListEditItem Selected="true" Text="Sales Out" Value="1" />
                                                            <dx:ListEditItem Text="Displays" Value="2" />
                                                            <dx:ListEditItem Text="Display Images" Value="3" />
                                                            <dx:ListEditItem Text="Stock In" Value="4" />
                                                            <dx:ListEditItem Text="Issued" Value="5" />
                                                            <dx:ListEditItem Text="Competitor" Value="6" />
                                                            <dx:ListEditItem Text="WorkingPlan" Value="7" />
                                                        </Items>
                                                    </dx:ASPxComboBox>
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
                                                <div class="col-md-6">
                                                    <label></label>
                                                    <br />
                                                    <dx:ASPxButton ID="ASPxButton1" AutoPostBack="false" runat="server" CssClass="btn btn-primary" Text="Filter">
                                                        <ClientSideEvents Click="function(s, e) {summayCallbackPanel.PerformCallback('filter'); }"></ClientSideEvents>
                                                    </dx:ASPxButton>
                                                    <dx:ASPxButton ID="FilterButton" AutoPostBack="false" runat="server" CssClass="btn btn-warning" Text="Export">
                                                        <ClientSideEvents Click="function(s, e) {ExportCallbackPanel.PerformCallback('filter'); }"></ClientSideEvents>
                                                    </dx:ASPxButton>
                                                    <dx:ASPxCallbackPanel runat="server" ID="ExportASPxCallbackPanel" Width="100%" ClientInstanceName="ExportCallbackPanel"
                                                        OnCallback="ExportASPxCallbackPanel_Callback" SettingsLoadingPanel-Text="Exporting data, please wait.">
                                                        <PanelCollection>
                                                            <dx:PanelContent ID="PanelContent2" runat="server">
                                                                <asp:HyperLink ID="hpExport" Style="float: right; margin-right: 8px;" runat="server"></asp:HyperLink>
                                                            </dx:PanelContent>
                                                        </PanelCollection>
                                                    </dx:ASPxCallbackPanel>
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
        <dx:ASPxCallbackPanel ID="SummaryCallbackPanel" runat="server" Width="100%"
            ClientInstanceName="summayCallbackPanel" OnCallback="SummaryCallbackPanel_Callback">
            <PanelCollection>
                <dx:PanelContent runat="server">
                    <div class="row marginTop20">
                        <div class="col-md-12">
                            <dx:ASPxPageControl ID="ASPxPageControl1" runat="server" ActiveTabIndex="0" Width="100%">
                                <TabPages>
                                    <dx:TabPage Text="Summary">
                                        <ContentCollection>
                                            <dx:ContentControl runat="server">
                                                <dx:ASPxPivotGrid ID="gvSummarySale" runat="server" OnLoad="gvSummarySale_Load" OnCustomFieldSort="gvSummarySale_CustomFieldSort"
                                                    DataSourceID="odsSale" Width="100%" ClientIDMode="AutoID">
                                                    <Fields>
                                                        <dx:PivotGridField Area="ColumnArea" AreaIndex="0" FieldName="Product" ID="fieldProduct" SortMode="Custom">
                                                            <CellStyle HorizontalAlign="Center"></CellStyle>
                                                            <HeaderStyle HorizontalAlign="Center" />
                                                        </dx:PivotGridField>
                                                        <dx:PivotGridField Area="RowArea" AreaIndex="0" FieldName="ShopName" ID="fieldShopName" Options-AllowExpand="False" />
                                                        <dx:PivotGridField Area="RowArea" AreaIndex="1" FieldName="Account" ID="fieldAccount" Options-AllowExpand="False" />
                                                        <dx:PivotGridField Area="RowArea" AreaIndex="2" FieldName="Region" ID="fieldRegion" Options-AllowExpand="False" />
                                                        <dx:PivotGridField ID="fieldDisplay" Area="DataArea" AreaIndex="3" CellFormat-FormatType="Numeric" CellFormat-FormatString="N0" FieldName="amount">
                                                        </dx:PivotGridField>
                                                        <%--<dx:PivotGridField ID="fieldSORTORDER" FieldName="Sortorder" Visible="False"></dx:PivotGridField>--%>
                                                    </Fields>
                                                    <OptionsView HorizontalScrollBarMode="Auto" ShowColumnGrandTotals="True" ShowRowTotals="False" ShowRowGrandTotals="True" />
                                                    <OptionsFilter NativeCheckBoxes="False" ShowOnlyAvailableItems="true" />
                                                </dx:ASPxPivotGrid>
                                            </dx:ContentControl>
                                        </ContentCollection>
                                    </dx:TabPage>
                                </TabPages>
                            </dx:ASPxPageControl>
                        </div>
                    </div>
                </dx:PanelContent>
            </PanelCollection>
        </dx:ASPxCallbackPanel>
        <dx:ASPxCallbackPanel ID="ASPxCallbackPanel1" runat="server" Width="100%"
            ClientInstanceName="cp" OnCallback="ASPxCallbackPanel_Callback">
            <ClientSideEvents EndCallback="OnEndCallback" />
            <PanelCollection>
                <dx:PanelContent runat="server">
                    <div class="row">
                    </div>
                    <div class="row marginTop20">
                        <div class="col-md-12">
                            <asp:ObjectDataSource ID="odsEOutlets" runat="server" SelectMethod="getByEmployee" TypeName="LogicTier.Controllers.OutletBL">
                                <SelectParameters>
                                    <asp:Parameter Name="empId" Type="Int32" />
                                    <asp:Parameter Name="activeDate" Type="String" />
                                </SelectParameters>
                            </asp:ObjectDataSource>
                        </div>
                    </div>
                </dx:PanelContent>
            </PanelCollection>
        </dx:ASPxCallbackPanel>
    </div>
    <asp:ObjectDataSource ID="odsSale" runat="server" SelectMethod="dataRaw" TypeName="LogicTier.Controllers.SaleOutBL">
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
        </SelectParameters>
    </asp:ObjectDataSource>
</asp:Content>
