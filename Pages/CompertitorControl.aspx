<%@ Page Title="Compertitor Report" Language="C#" MasterPageFile="~/Layout.master" AutoEventWireup="true" CodeBehind="CompertitorControl.aspx.cs" Inherits="WebApplication.Pages.CompertitorControl" Async="true" %>

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
            if (s.cpCompertitor != '') {
                alert(s.cpCompertitor);
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
                                                    <dx:ASPxComboBox runat="server" ID="cbAccount" ValueType="System.Int32" NullText="Choose to select Account Group" Width="100%"
                                                        DataSourceID="odsAccount" TextField="Account" ValueField="ObjectId"
                                                        ClientInstanceName="cbAccount" CallbackPageSize="10">
                                                        <ClientSideEvents SelectedIndexChanged="function(s,e){cbOutlet.PerformCallback(s.GetValue()+';'+cbCity.GetValue());}" />
                                                        <ClearButton DisplayMode="OnHover"></ClearButton>
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
                                                    <label>Leader</label>
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
                                                            <asp:Parameter Name="emplName" Type="String" />
                                                            <asp:ControlParameter ControlID="AddCommentFormLayout$OptionRadioButtonList" Name="Option" Type="Int32" PropertyName="Value" />
                                                            <asp:Parameter Name="userId" />
                                                        </SelectParameters>
                                                    </asp:ObjectDataSource>
                                                </div>
                                                <div class="col-md-3">
                                                    <label>Employee</label>
                                                    <dx:ASPxComboBox runat="server" ID="cbEmployee" OnCallback="cbEmployee_Callback" Width="100%"
                                                        ValueType="System.Int32"
                                                        NullText="Choose to filter by Employee person" ValueField="EmployeeId"
                                                        ClientInstanceName="cbEmployee" DataSourceID="odsEmployee"
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
                                                    <label>Option</label>
                                                    <dx:ASPxRadioButtonList ID="radioButtonList" runat="server" Paddings-PaddingLeft="1" Paddings-PaddingRight="1" Paddings-PaddingBottom="1" Paddings-PaddingTop="1" RepeatColumns="2" Width="100%"
                                                        RepeatLayout="UnorderedList">
                                                        <Items>
                                                            <dx:ListEditItem Selected="true" Text="All" Value="0" />
                                                            <dx:ListEditItem Text="Display" Value="1" />
                                                            <dx:ListEditItem Text="Price" Value="2" />
                                                        </Items>
                                                    </dx:ASPxRadioButtonList>
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
                        <dx:ASPxPageControl ID="ASPxPageControl1" runat="server" ActiveTabIndex="1" Width="100%">
                            <TabPages>
                                <dx:TabPage Text="Summary">
                                    <ContentCollection>
                                        <dx:ContentControl runat="server">
                                            <dx:ASPxPivotGrid ID="gvSale" runat="server" OnLoad="gvSale_Load" OnCustomFieldSort="gvSale_CustomFieldSort"
                                                DataSourceID="odsCompertitor" Width="100%" ClientIDMode="AutoID">
                                                <Fields>
                                                    <dx:PivotGridField Area="ColumnArea" AreaIndex="0" FieldName="Product" ID="fieldProduct" SortMode="Custom">
                                                        <CellStyle HorizontalAlign="Center"></CellStyle>
                                                        <HeaderStyle HorizontalAlign="Center" />
                                                    </dx:PivotGridField>
                                                    <dx:PivotGridField Area="RowArea" AreaIndex="0" FieldName="ShopName" ID="fieldShopName" Options-AllowExpand="False" />
                                                    <dx:PivotGridField Area="RowArea" AreaIndex="1" FieldName="Account" ID="fieldAccount" Options-AllowExpand="False" />
                                                    <dx:PivotGridField Area="RowArea" AreaIndex="2" FieldName="Region" ID="fieldRegion" Options-AllowExpand="False" />
                                                    <dx:PivotGridField Area="RowArea" AreaIndex="3" FieldName="ReportDate" ID="fieldReportDate" ValueFormat-FormatString="yyyy-MM-dd" ValueFormat-FormatType="DateTime">
                                                    </dx:PivotGridField>
                                                    <dx:PivotGridField ID="fieldQuantity" Area="DataArea" AreaIndex="4" FieldName="Quantity">
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
                                                    <uc1:ToolbarExport runat="server" ID="ToolbarExport1" OnItemClick="ToolbarExport1_ItemClick" />
                                                    <dx:ASPxGridViewExporter ID="ASPxGridViewExporter1" runat="server" ExportSelectedRowsOnly="true" GridViewID="gvCompertitor">
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
                                                                    <ClientSideEvents Click="function(s, e) { gvCompertitor.SelectRows(); }" />
                                                                </dx:ASPxButton>
                                                            </td>
                                                            <td style="padding-right: 4px">
                                                                <dx:ASPxButton ID="btnSelectAllOnPage" runat="server" Text="Chọn 1 trang"
                                                                    UseSubmitBehavior="False" AutoPostBack="false">
                                                                    <ClientSideEvents Click="function(s, e) { gvCompertitor.SelectAllRowsOnPage(); }" />
                                                                </dx:ASPxButton>
                                                            </td>
                                                            <td style="padding-right: 4px">
                                                                <dx:ASPxButton ID="btnUnselectAll" runat="server" Text="Bỏ chọn" UseSubmitBehavior="False"
                                                                    AutoPostBack="false">
                                                                    <ClientSideEvents Click="function(s, e) { gvCompertitor.UnselectRows(); gvCompertitor.UnselectAllRowsOnPage(); }" />
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
                                            <div class="row marginTop20">
                                                <div class="col-md-12">
                                                    <dx:ASPxGridView runat="server" AutoGenerateColumns="False" ID="gvCompertitor" ClientInstanceName="gvCompertitor" Width="100%"
                                                        KeyFieldName="CompertitorId" OnLoad="gvCompertitor_Load" OnRowUpdating="gvCompertitor_RowUpdating" OnRowInserting="gvCompertitor_RowInserting"
                                                        OnRowDeleting="gvCompertitor_RowDeleting" DataSourceID="odsCompertitor">
                                                        <ClientSideEvents EndCallback="gvEndCallback" />
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
                                                            <EditForm Width="800" HorizontalAlign="Center" VerticalAlign="Middle" />
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
                                                                <div style="text-align: center; padding: 8px 8px 8px">
                                                                    <dx:ASPxButton runat="server" ID="btUpdate" Text="Update" CssClass="btn btn-link" AutoPostBack="false">
                                                                        <ClientSideEvents Click="function(s,e){gvCompertitor.UpdateEdit();}" />
                                                                    </dx:ASPxButton>
                                                                    <dx:ASPxButton runat="server" ID="btCancel" Text="Cancel" CssClass="btn btn-link" AutoPostBack="false">
                                                                        <ClientSideEvents Click="function(s,e){gvCompertitor.CancelEdit();}" />
                                                                    </dx:ASPxButton>
                                                                </div>
                                                            </EditForm>
                                                        </Templates>
                                                        <Columns>
                                                            <dx:GridViewCommandColumn ShowSelectCheckbox="True" VisibleIndex="0" Width="40" FixedStyle="Left" />
                                                            <dx:GridViewDataTextColumn FieldName="Region" VisibleIndex="1" FixedStyle="Left">
                                                                <EditFormSettings Visible="False" />
                                                            </dx:GridViewDataTextColumn>
                                                            <dx:GridViewDataTextColumn FieldName="Account" VisibleIndex="2" FixedStyle="Left">
                                                                <EditFormSettings Visible="False" />
                                                            </dx:GridViewDataTextColumn>
                                                            <dx:GridViewDataComboBoxColumn FieldName="ShopName" VisibleIndex="3" FixedStyle="Left" Width="160px">
                                                                <EditFormSettings VisibleIndex="0" />
                                                                <EditItemTemplate>
                                                                    <dx:ASPxComboBox runat="server" ID="eCbxOutlets" ClientInstanceName="eCbxOutlets" OnInit="eCbxOutlets_Init"
                                                                        DataSourceID="odsEOutlets" EnableCallbackMode="true" CallbackPageSize="10" NullText="Please choose shop name"
                                                                        ValueField="ShopId" ValueType="System.Int32"
                                                                        DropDownStyle="DropDownList">
                                                                        <Columns>
                                                                            <dx:ListBoxColumn FieldName="ShopName" Width="250px" />
                                                                            <dx:ListBoxColumn FieldName="District" />
                                                                        </Columns>
                                                                    </dx:ASPxComboBox>
                                                                    <validationsettings display="Dynamic" errordisplaymode="Text" errortextposition="Bottom">
                                                                            <RequiredField IsRequired="true" ErrorText="Bạn chưa nhập cửa hàng." />
                                                                        </validationsettings>

                                                                </EditItemTemplate>
                                                            </dx:GridViewDataComboBoxColumn>
                                                            <dx:GridViewDataDateColumn FieldName="ReportDate" Caption="Purcharsing Date" VisibleIndex="4" FixedStyle="Left">
                                                                <PropertiesDateEdit DisplayFormatString="yyyy-MM-dd">
                                                                    <ValidationSettings Display="Dynamic" ErrorDisplayMode="Text" ErrorTextPosition="Bottom">
                                                                        <RequiredField IsRequired="true" ErrorText="Bạn chưa nhập ngày báo cáo." />
                                                                    </ValidationSettings>
                                                                </PropertiesDateEdit>
                                                                <EditFormSettings Visible="True" />

                                                            </dx:GridViewDataDateColumn>
                                                            <dx:GridViewDataTextColumn FieldName="EmployeeName" VisibleIndex="5">
                                                                <EditItemTemplate>
                                                                    <dx:ASPxComboBox runat="server" ID="cbeditEmployee" OnInit="cbeditEmployee_Init" Width="100%"
                                                                        ValueType="System.Int32" NullText="Choose to filter by Employee person" ValueField="EmployeeId"
                                                                        ClientInstanceName="cbeditEmployee" CallbackPageSize="10" DataSourceID="odsEditemployee"
                                                                        IncrementalFilteringMode="Contains" TextFormatString="{0}" EnableCallbackMode="true" DropDownStyle="DropDownList">
                                                                        <ClearButton DisplayMode="OnHover"></ClearButton>
                                                                        <Columns>
                                                                            <dx:ListBoxColumn FieldName="EmployeeName" />
                                                                        </Columns>
                                                                    </dx:ASPxComboBox>
                                                                    <validationsettings display="Dynamic" errordisplaymode="Text" errortextposition="Bottom">
                                                                    <RequiredField IsRequired="true" ErrorText="Bạn chưa nhập nhân viên." />
                                                                </validationsettings>
                                                                </EditItemTemplate>
                                                            </dx:GridViewDataTextColumn>
                                                            <dx:GridViewDataComboBoxColumn FieldName="Brand" Caption="Compertitor" VisibleIndex="6">
                                                                <EditFormSettings VisibleIndex="1" />
                                                                <PropertiesComboBox DataSourceID="odsECcompertitor" ValueField="ObjectName" ValueType="System.String" TextField="ObjectName" NullText="Please choose Brand name">
                                                                    <ValidationSettings Display="Dynamic" ErrorDisplayMode="Text" ErrorTextPosition="Bottom">
                                                                        <RequiredField IsRequired="true" ErrorText="Bạn chưa nhập brand." />
                                                                    </ValidationSettings>
                                                                    <ValidationSettings Display="Dynamic" ErrorDisplayMode="Text" ErrorTextPosition="Bottom">
                                                                        <RequiredField IsRequired="true" ErrorText="Bạn chưa nhập brand." />
                                                                    </ValidationSettings>
                                                                </PropertiesComboBox>

                                                            </dx:GridViewDataComboBoxColumn>
                                                            <dx:GridViewDataComboBoxColumn FieldName="Product" VisibleIndex="7">
                                                                <EditFormSettings VisibleIndex="3" />
                                                                <PropertiesComboBox>
                                                                    <Items>
                                                                        <dx:ListEditItem Value="REF" Text="REF" />
                                                                        <dx:ListEditItem Value="WM" Text="WM" />
                                                                        <dx:ListEditItem Value="RAC" Text="RAC" />
                                                                        <dx:ListEditItem Value="VC" Text="VC" />
                                                                        <dx:ListEditItem Value="RC" Text="RC" />
                                                                        <dx:ListEditItem Value="AP" Text="AP" />
                                                                    </Items>
                                                                    <ValidationSettings Display="Dynamic" ErrorDisplayMode="Text" ErrorTextPosition="Bottom">
                                                                        <RequiredField IsRequired="true" ErrorText="Bạn chưa nhập product." />
                                                                    </ValidationSettings>
                                                                </PropertiesComboBox>

                                                            </dx:GridViewDataComboBoxColumn>
                                                            <dx:GridViewDataColumn FieldName="Type" VisibleIndex="8">
                                                            </dx:GridViewDataColumn>
                                                            <dx:GridViewDataColumn FieldName="Model" VisibleIndex="9">
                                                            </dx:GridViewDataColumn>
                                                            <dx:GridViewDataTextColumn FieldName="Quantity" VisibleIndex="10">
                                                                <EditFormSettings VisibleIndex="4" />
                                                                <EditItemTemplate>
                                                                    <dx:ASPxSpinEdit runat="server" ID="txQuantity" ClientInstanceName="txQuantity" Width="100%" MaxLength="2" Text='<%# Eval("Quantity") %>'>
                                                                        <SpinButtons ShowIncrementButtons="false"></SpinButtons>
                                                                    </dx:ASPxSpinEdit>
                                                                </EditItemTemplate>
                                                            </dx:GridViewDataTextColumn>
                                                            <dx:GridViewDataColumn FieldName="ConfirmBy" VisibleIndex="11">
                                                                <EditFormSettings Visible="False" />
                                                            </dx:GridViewDataColumn>
                                                            <dx:GridViewCommandColumn ShowNewButtonInHeader="true" ShowEditButton="true" ShowDeleteButton="true" VisibleIndex="12">
                                                            </dx:GridViewCommandColumn>
                                                            <dx:GridViewDataColumn FieldName="BlockStatus" Visible="false" VisibleIndex="13">
                                                                <EditFormSettings Visible="False" />
                                                            </dx:GridViewDataColumn>
                                                        </Columns>
                                                    </dx:ASPxGridView>


                                                    <asp:ObjectDataSource ID="odsCompertitor" runat="server" SelectMethod="dataRaw" TypeName="LogicTier.Controllers.CompertitorBL">
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
                                                            <asp:Parameter Name="BlockStatus" Type="Int32" />
                                                            <asp:Parameter Name="userName" Type="String" />
                                                            <asp:Parameter Name="reporttype" Type="Int32" />
                                                        </SelectParameters>
                                                    </asp:ObjectDataSource>
                                                    <asp:ObjectDataSource ID="odsEditemployee" runat="server" SelectMethod="getList" TypeName="LogicTier.Controllers.EmployeeBL">
                                                        <SelectParameters>
                                                            <asp:Parameter Name="empId" Type="Int32" />
                                                            <asp:Parameter Name="empCode" Type="String" />
                                                            <asp:Parameter Name="pos" Type="String" />
                                                            <asp:Parameter Name="parentId" Type="Int32" />
                                                            <asp:Parameter Name="userName" Type="String" />
                                                        </SelectParameters>
                                                    </asp:ObjectDataSource>
                                                    <asp:ObjectDataSource ID="odsEOutlets" runat="server" SelectMethod="getByEmployee" TypeName="LogicTier.Controllers.OutletBL">
                                                        <SelectParameters>
                                                            <asp:Parameter Name="empId" Type="Int32" />
                                                            <asp:Parameter Name="activeDate" Type="String" />
                                                        </SelectParameters>
                                                    </asp:ObjectDataSource>
                                                    <asp:ObjectDataSource ID="odsECcompertitor" runat="server" SelectMethod="getlist" TypeName="LogicTier.Controllers.ObjectDataBL">
                                                        <SelectParameters>
                                                            <asp:Parameter Name="objId" Type="Int32" />
                                                            <asp:Parameter Name="objType" Type="String" DefaultValue="Compertitor" />
                                                        </SelectParameters>
                                                    </asp:ObjectDataSource>
                                                </div>
                                            </div>
                                        </dx:ContentControl>
                                    </ContentCollection>
                                </dx:TabPage>
                            </TabPages>
                        </dx:ASPxPageControl>
                    </div>
                </dx:PanelContent>
            </PanelCollection>
        </dx:ASPxCallbackPanel>
    </div>
</asp:Content>
