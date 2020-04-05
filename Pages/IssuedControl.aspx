<%@ Page Title="Issued Report" Language="C#" MasterPageFile="~/Layout.master" AutoEventWireup="true" CodeBehind="IssuedControl.aspx.cs" Inherits="WebApplication.Pages.IssuedControl" %>

<%@ Register Src="~/UserControls/ToolbarExport.ascx" TagPrefix="uc1" TagName="ToolbarExport" %>
<asp:Content ID="Content1" ContentPlaceHolderID="Content" runat="server">
    <script>
        function OnEndCallback(s, e) {
            if (s.cpAlert != '') {
                alert(s.cpAlert);
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
                                                    <dx:ASPxComboBox runat="server" ID="cbRegion" ValueField="Region"
                                                        ValueType="System.String" NullText="Choose to filter by Region" Width="100%"
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
                                                    <dx:ASPxComboBox runat="server" ID="cbLearder" ValueField="EmployeeId" Width="100%"
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
                                                            <asp:Parameter Name="emplName" Type="String" DefaultValue="" ConvertEmptyStringToNull="true" />
                                                            <asp:ControlParameter ControlID="AddCommentFormLayout$OptionRadioButtonList" Name="Option" Type="Int32" PropertyName="Value" />
                                                        </SelectParameters>
                                                    </asp:ObjectDataSource>
                                                </div>
                                                <div class="col-md-3">
                                                    <label>Issued</label>
                                                    <dx:ASPxComboBox runat="server" ID="cbIssuedState" ValueField="ObjectId" Width="100%"
                                                        ValueType="System.Int32" NullText="Chọn loại Issued"
                                                        ClientInstanceName="cbIssuedState" CallbackPageSize="10" DataSourceID="odsissueState">
                                                        <ClearButton DisplayMode="OnHover"></ClearButton>
                                                        <ClientSideEvents SelectedIndexChanged="function(s, e) {  cp.PerformCallback('filter'); }" />
                                                        <Columns>
                                                            <dx:ListBoxColumn FieldName="ObjectName" Caption="Loại Issued" />
                                                        </Columns>
                                                    </dx:ASPxComboBox>
                                                    <asp:ObjectDataSource ID="odsissueState" runat="server" SelectMethod="getlist" TypeName="LogicTier.Controllers.ObjectDataBL">
                                                        <SelectParameters>
                                                            <asp:Parameter Name="objId" Type="Int32" />
                                                            <asp:Parameter Name="objType" Type="String" DefaultValue="Issued" />
                                                        </SelectParameters>
                                                    </asp:ObjectDataSource>
                                                </div>
                                                <div class="col-md-3">
                                                    <label>Product</label>
                                                    <dx:ASPxComboBox runat="server" ID="cboProduct" Width="100%" NullText="Chọn Product"
                                                        ValueType="System.String" SelectedIndex="0"
                                                        EnableCallbackMode="false" ClientInstanceName="cboproduct" CallbackPageSize="10">
                                                        <ClearButton DisplayMode="OnHover"></ClearButton>
                                                        <Items>
                                                            <dx:ListEditItem Text="--None--" Value="0" />
                                                            <dx:ListEditItem Text="REF" Value="REF" />
                                                            <dx:ListEditItem Text="RAC" Value="RAC" />
                                                            <dx:ListEditItem Text="AP" Value="AP" />
                                                        </Items>
                                                    </dx:ASPxComboBox>
                                                </div>
                                                <div class="col-md-3">
                                                    <label style="color: white">Tool</label><br />
                                                    <dx:ASPxButton ID="FilterButton" AutoPostBack="false" CssClass="btn btn-primary" runat="server" Text="Tìm kiếm">
                                                        <ClientSideEvents Click="function(s, e) {  cp.PerformCallback('filter'); }"></ClientSideEvents>
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
                                        </tr>
                                    </table>
                                </div>
                            </div>
                            <div class="row marginBot20 marginTop20">
                                <div class="col-md-12">
                                    <dx:ASPxGridView runat="server"
                                        ID="gvSale" ClientInstanceName="gvSale"
                                        Width="100%" DataSourceID="odsSale" OnRowUpdating="gvSale_RowUpdating" OnRowDeleting="gvSale_RowDeleting"
                                        AutoGenerateColumns="False"
                                        KeyFieldName="ShopId;EmployeeId;ReportDate;IssueId" OnLoad="gvSale_Load">
                                        <SettingsCommandButton>
                                            <DeleteButton Text="Delete"></DeleteButton>
                                            <EditButton Text="Update status"></EditButton>
                                        </SettingsCommandButton>
                                        <SettingsEditing EditFormColumnCount="2" Mode="PopupEditForm" />
                                        <SettingsBehavior ConfirmDelete="true" AllowFocusedRow="True" />
                                        <SettingsText ConfirmDelete="Bạn có muốn xóa không?" />
                                        <Styles Header-Wrap="True">
                                            <Header Wrap="True" VerticalAlign="Middle" HorizontalAlign="Center"></Header>
                                            <Cell Wrap="True" VerticalAlign="Middle"></Cell>
                                            <AlternatingRow Enabled="true" />
                                        </Styles>
                                        <SettingsDetail ShowDetailRow="true" />
                                        <ClientSideEvents FocusedRowChanged="function(s, e) {s.ExpandDetailRow(s.GetFocusedRowIndex());}" />
                                        <SettingsDetail ExportMode="All" ShowDetailRow="True" AllowOnlyOneMasterRowExpanded="True" />
                                        <Templates>
                                            <DetailRow>
                                                <asp:Repeater runat="server" ID="rpImage" OnLoad="rpImage_Load" DataSourceID="odsbyImg">
                                                    <HeaderTemplate>
                                                        <div class="row">
                                                    </HeaderTemplate>
                                                    <ItemTemplate>
                                                        <div class="col-md-3">
                                                            <div class="thumbnail">
                                                                <dx:ASPxBinaryImage ID="BinaryImg" runat="server" ClientInstanceName="BinaryImg"
                                                                    Value='<%# Eval("BinaryImg") %>' ImageAlign="AbsMiddle">
                                                                </dx:ASPxBinaryImage>
                                                                <div style="margin-top: 4px;">
                                                                    <dx:ASPxLabel runat="server" ID="lbComment" Text='<%# Eval("Comment") %>'></dx:ASPxLabel>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </ItemTemplate>
                                                    <FooterTemplate>
                                                        </div>
                                                    </FooterTemplate>
                                                </asp:Repeater>
                                            </DetailRow>
                                        </Templates>
                                        <Columns>
                                            <dx:GridViewCommandColumn ShowSelectCheckbox="True" VisibleIndex="0" FixedStyle="Left" />
                                            <dx:GridViewCommandColumn ShowEditButton="true" ShowDeleteButton="true" VisibleIndex="0">
                                            </dx:GridViewCommandColumn>
                                            <dx:GridViewDataTextColumn FieldName="Region" VisibleIndex="1">
                                                <EditFormSettings Visible="False" />
                                            </dx:GridViewDataTextColumn>
                                            <dx:GridViewDataTextColumn FieldName="Account" VisibleIndex="2">
                                                <EditFormSettings Visible="False" />
                                            </dx:GridViewDataTextColumn>
                                            <dx:GridViewDataComboBoxColumn FieldName="ShopName" VisibleIndex="3">
                                                <EditFormSettings Visible="False" />
                                            </dx:GridViewDataComboBoxColumn>
                                            <dx:GridViewDataTextColumn FieldName="ReportDate" VisibleIndex="4">
                                                <EditFormSettings Visible="False" />
                                                <PropertiesTextEdit DisplayFormatString="yyyy-MM-dd">
                                                </PropertiesTextEdit>
                                            </dx:GridViewDataTextColumn>
                                            <dx:GridViewDataTextColumn FieldName="IssuedState" VisibleIndex="5">
                                                <EditFormSettings Visible="False" />
                                            </dx:GridViewDataTextColumn>
                                            <dx:GridViewDataComboBoxColumn FieldName="statusid" Caption="Status" VisibleIndex="6">
                                                <PropertiesComboBox>
                                                    <Items>
                                                        <dx:ListEditItem Selected="true" Value="0" Text="N/A" />
                                                        <dx:ListEditItem Value="1" Text="Pending" />
                                                        <dx:ListEditItem Value="2" Text="Done" />
                                                    </Items>
                                                </PropertiesComboBox>
                                            </dx:GridViewDataComboBoxColumn>
                                            <dx:GridViewDataMemoColumn FieldName="Note" Caption="Admin note" VisibleIndex="7"></dx:GridViewDataMemoColumn>
                                        </Columns>
                                    </dx:ASPxGridView>
                                    <asp:ObjectDataSource ID="odsSale" runat="server" SelectMethod="getImage" TypeName="LogicTier.Controllers.IssuedBL">
                                        <SelectParameters>
                                            <asp:Parameter Name="Id" Type="Int64" />
                                            <asp:Parameter Name="ShopId" Type="Int32" />
                                            <asp:Parameter Name="FromDate" Type="String" />
                                            <asp:Parameter Name="ToDate" Type="String" />
                                            <asp:ControlParameter ControlID="AddCommentFormLayout$cboProduct" Name="Product" Type="String" PropertyName="Value" />
                                            <asp:Parameter Name="userName" Type="String" />
                                            <asp:ControlParameter ControlID="AddCommentFormLayout$cbRegion" Name="Region" Type="String" PropertyName="Value" ConvertEmptyStringToNull="true" />
                                            <asp:ControlParameter ControlID="AddCommentFormLayout$cbIssuedState" Name="ObjectId" Type="Int32" PropertyName="Value" ConvertEmptyStringToNull="true" />
                                            <asp:Parameter Name="District" Type="String" ConvertEmptyStringToNull="true" DefaultValue="" />
                                            <asp:Parameter Name="City" Type="String" ConvertEmptyStringToNull="true" DefaultValue="" />
                                            <asp:Parameter Name="issuedId" Type="String" ConvertEmptyStringToNull="true" DefaultValue="" />
                                        </SelectParameters>
                                    </asp:ObjectDataSource>
                                    <asp:ObjectDataSource ID="odsbyImg" runat="server" SelectMethod="dataRaw" TypeName="LogicTier.Controllers.IssuedBL">
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
                                            <asp:Parameter Name="issuedId" Type="Int32" />
                                            <asp:Parameter Name="BlockStatus" Type="Int32" />
                                            <asp:ControlParameter ControlID="AddCommentFormLayout$cboProduct" Name="Product" Type="String" PropertyName="Value" />
                                            <asp:Parameter Name="userName" Type="String" />
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
</asp:Content>
