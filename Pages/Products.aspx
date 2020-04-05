<%@ Page Title="Products" Language="C#" MasterPageFile="~/Layout.master" AutoEventWireup="true" CodeBehind="Products.aspx.cs" Inherits="WebApplication.Pages.Products" %>

<%@ Register Src="~/UserControls/ToolbarExport.ascx" TagPrefix="uc1" TagName="ToolbarExport" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Content" runat="server">
    <script>
        function OnEndCallback(s, e) {
            if (s.cpAlert != '') {
                alert(s.cpAlert);
            }
        }
        function gvproductEndCallback(s, e) {
            if (s.cpempAlert != '') {
                alert(s.cpempAlert);
            }
        }
    </script>
    <script type="text/javascript">
        $(document).ready(function () {
            $("#TopPanel_NavMenu ul li:eq(6)").addClass("dxm-selected");
        })
    </script>
    <div class="container">
        <div class="row marginTop20">
            <div class="col-md-12">
                <dx:ASPxFormLayout ID="AddCommentFormLayout" runat="server" UseDefaultPaddings="false">
                    <SettingsItems Width="100%" />
                    <SettingsItemCaptions Location="Top" />
                    <Items>
                        <dx:LayoutGroup Caption="Products">
                            <Items>
                                <dx:LayoutItem ShowCaption="False">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer>
                                            <div class="row">
                                                <div class="col-md-3">
                                                    <label>Product</label>
                                                    <dx:ASPxComboBox runat="server" Width="100%" ID="cbProduct" ValueField="Product"
                                                        ValueType="System.String" NullText="Choose to filter by Product"
                                                        ClientInstanceName="cbProduct" CallbackPageSize="10" DataSourceID="odsProduct">
                                                        <ClearButton DisplayMode="OnHover"></ClearButton>
                                                        <ClientSideEvents SelectedIndexChanged="function(s,e){cbRange.PerformCallback(s.GetValue());}" />
                                                        <Columns>
                                                            <dx:ListBoxColumn FieldName="Product" />
                                                        </Columns>
                                                    </dx:ASPxComboBox>
                                                </div>
                                                <div class="col-md-3">
                                                    <label>Range</label>
                                                    <dx:ASPxComboBox runat="server" Width="100%" ID="cbRange" OnCallback="cbRange_Callback"
                                                        ValueType="System.String" NullText="Choose to filter by Range" ValueField="Range"
                                                        ClientInstanceName="cbRange" CallbackPageSize="10" DataSourceID="odsRange">
                                                        <ClearButton DisplayMode="OnHover"></ClearButton>
                                                        <ClientSideEvents SelectedIndexChanged="function(s,e){cbCapacity.PerformCallback(s.GetValue());}" />
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
                                                    <dx:ASPxComboBox runat="server" Width="100%" ID="cbCapacity" ValueType="System.String" NullText="Choose to select Capacity"
                                                        DataSourceID="odsCapacity" TextField="Capacity" ValueField="Capacity" OnCallback="cbCapacity_Callback"
                                                        ClientInstanceName="cbCapacity" CallbackPageSize="10">
                                                        <ClearButton DisplayMode="OnHover"></ClearButton>
                                                        <ClientSideEvents SelectedIndexChanged="function(s,e){cbType.PerformCallback(s.GetValue());}" />
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
                                                    <dx:ASPxComboBox runat="server" ID="cbType" Width="100%" ValueType="System.String" NullText="Choose to select Type"
                                                        DataSourceID="odsType" TextField="Type" ValueField="Type" OnCallback="cbType_Callback"
                                                        ClientInstanceName="cbType" CallbackPageSize="10">
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
                                                    <dx:ASPxButtonEdit runat="server" Width="100%" ID="txModel">
                                                        <ClearButton DisplayMode="OnHover"></ClearButton>
                                                    </dx:ASPxButtonEdit>
                                                </div>
                                                <div class="col-md-1">
                                                    <label>Đã xóa</label><br />
                                                    <dx:ASPxCheckBox runat="server" Checked="false" ID="chkfilter"></dx:ASPxCheckBox>
                                                </div>
                                                <div class="col-md-6">
                                                    <label style="color: white"></label>
                                                    <br />
                                                    <dx:ASPxButton ID="FilterButton" AutoPostBack="false" runat="server" CssClass="btn btn-primary" Text="Tìm kiếm">
                                                        <ClientSideEvents Click="function(s, e) {  cp.PerformCallback('filter'); }"></ClientSideEvents>
                                                    </dx:ASPxButton>
                                                    <dx:ASPxButton ID="btnopen" AutoPostBack="false" runat="server" 
                                                        CssClass="btn btn-warning" Text="List Price">
                                                        <ClientSideEvents Click="function(s, e) { pcImport.Show(); }" />
                                                    </dx:ASPxButton>
                                                    <a id="link1" runat="server" href='/Pages/DownTemp.aspx?type=listprice' target="_blank">List Price Template</a>
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
                                    <dx:ASPxGridViewExporter ID="ASPxGridViewExporter1" runat="server" ExportSelectedRowsOnly="true" GridViewID="gvProduct">
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
                                                    <ClientSideEvents Click="function(s, e) { gvProduct.SelectRows(); }" />
                                                </dx:ASPxButton>
                                            </td>
                                            <td style="padding-right: 4px">
                                                <dx:ASPxButton ID="btnSelectAllOnPage" runat="server" Text="Chọn 1 trang"
                                                    UseSubmitBehavior="False" AutoPostBack="false">
                                                    <ClientSideEvents Click="function(s, e) { gvProduct.SelectAllRowsOnPage(); }" />
                                                </dx:ASPxButton>
                                            </td>
                                            <td style="padding-right: 4px">
                                                <dx:ASPxButton ID="btnUnselectAll" runat="server" Text="Bỏ chọn" UseSubmitBehavior="False"
                                                    AutoPostBack="false">
                                                    <ClientSideEvents Click="function(s, e) { gvProduct.UnselectRows(); gvProduct.UnselectAllRowsOnPage(); }" />
                                                </dx:ASPxButton>
                                            </td>
                                        </tr>
                                    </table>
                                </div>
                            </div>
                            <div class="row marginTop20">
                                <div class="col-md-12">
                                    <dx:ASPxGridView runat="server" AutoGenerateColumns="False" ID="gvProduct" ClientInstanceName="gvProduct" Width="100%"
                                        KeyFieldName="ProductId" OnLoad="gvProduct_Load"
                                        OnRowInserting="gvProduct_RowInserting"
                                        OnRowUpdating="gvProduct_RowUpdating"
                                        OnRowDeleting="gvProduct_RowDeleting" DataSourceID="odsProductList">
                                        <ClientSideEvents EndCallback="gvproductEndCallback" />
                                        <SettingsCommandButton>
                                            <DeleteButton Text="Delete"></DeleteButton>
                                            <EditButton Text="Edit"></EditButton>
                                        </SettingsCommandButton>
                                        <SettingsBehavior ConfirmDelete="true" AllowFocusedRow="True" />
                                        <SettingsText ConfirmDelete="Bạn có muốn xóa không?" />

                                        <SettingsEditing EditFormColumnCount="3" NewItemRowPosition="Top" />
                                        <Styles Header-Wrap="True">
                                            <Header Wrap="True"></Header>
                                            <AlternatingRow Enabled="true" />
                                        </Styles>
                                        <Columns>
                                            <dx:GridViewCommandColumn ShowSelectCheckbox="True" VisibleIndex="0" />
                                            <dx:GridViewDataTextColumn FieldName="Product" VisibleIndex="1">
                                                <EditFormSettings VisibleIndex="0" />
                                                <EditItemTemplate>
                                                    <dx:ASPxComboBox runat="server" DataSourceID="odsProduct" ValueType="System.String" ValueField="Product" ValidationSettings-ValidationGroup="<%# Container.ValidationGroup %>"
                                                        TextField="Product" Value='<%# Eval("Product") %>' ID="cbProductedit">
                                                        <ValidationSettings Display="Dynamic" ErrorDisplayMode="Text" ErrorTextPosition="Bottom">
                                                            <RequiredField IsRequired="true" ErrorText="Please choose Product." />
                                                        </ValidationSettings>
                                                        <ClientSideEvents SelectedIndexChanged="function(s,e){cbrangeedit.PerformCallback(s.GetValue());}" />
                                                    </dx:ASPxComboBox>
                                                </EditItemTemplate>
                                            </dx:GridViewDataTextColumn>
                                            <dx:GridViewDataTextColumn FieldName="Range" VisibleIndex="2">
                                                <EditFormSettings VisibleIndex="1" />
                                                <EditItemTemplate>
                                                    <dx:ASPxComboBox runat="server" ValueType="System.String" ValueField="Range" ClientInstanceName="cbrangeedit" DataSourceID="odsrangeedit" ValidationSettings-ValidationGroup="<%# Container.ValidationGroup %>"
                                                        TextField="Range" Value='<%# Eval("Range") %>' ID="cbRangeedit" OnCallback="cbRangeedit_Callback">
                                                        <ClientSideEvents SelectedIndexChanged="function(s,e){cbcapacityedit.PerformCallback(s.GetValue());}" />
                                                        <ValidationSettings Display="Dynamic" ErrorDisplayMode="Text" ErrorTextPosition="Bottom">
                                                            <RequiredField IsRequired="true" ErrorText="Please choose Range." />
                                                        </ValidationSettings>
                                                    </dx:ASPxComboBox>
                                                </EditItemTemplate>
                                            </dx:GridViewDataTextColumn>
                                            <dx:GridViewDataTextColumn FieldName="Model" VisibleIndex="3">
                                                <EditFormSettings VisibleIndex="2" />
                                                <EditItemTemplate>
                                                    <dx:ASPxTextBox ID="txtModel" runat="server" MaxLength="32" Width="170" Value='<%# Eval("Model") %>' ValidationSettings-ValidationGroup="<%# Container.ValidationGroup %>">
                                                        <ValidationSettings Display="Dynamic" ErrorDisplayMode="Text" ErrorTextPosition="Bottom">
                                                            <RequiredField IsRequired="true" ErrorText="Bạn phải nhập model." />
                                                        </ValidationSettings>
                                                    </dx:ASPxTextBox>
                                                </EditItemTemplate>
                                            </dx:GridViewDataTextColumn>
                                            <dx:GridViewDataColumn FieldName="Capacity" VisibleIndex="4">
                                                <EditFormSettings VisibleIndex="3" />
                                                <EditItemTemplate>
                                                    <dx:ASPxComboBox runat="server" ValueType="System.String" ValueField="Capacity" ClientInstanceName="cbcapacityedit" DataSourceID="odsCapacityedit" ValidationSettings-ValidationGroup="<%# Container.ValidationGroup %>"
                                                        TextField="Capacity" Value='<%# Eval("Capacity") %>' ID="cboCapacityedit" OnCallback="cboCapacity_Callback">
                                                        <ClientSideEvents SelectedIndexChanged="function(s,e){cbtypeedit.PerformCallback(s.GetValue());}" />
                                                        <ValidationSettings Display="Dynamic" ErrorDisplayMode="Text" ErrorTextPosition="Bottom">
                                                            <RequiredField IsRequired="true" ErrorText="Please choose Capacity." />
                                                        </ValidationSettings>
                                                    </dx:ASPxComboBox>
                                                </EditItemTemplate>
                                            </dx:GridViewDataColumn>
                                            <dx:GridViewDataColumn FieldName="Type" VisibleIndex="5">
                                                <EditFormSettings VisibleIndex="4" />
                                                <EditItemTemplate>
                                                    <dx:ASPxComboBox runat="server" ValueType="System.String" ValueField="Type" ClientInstanceName="cbtypeedit" DataSourceID="odstypedit" ValidationSettings-ValidationGroup="<%# Container.ValidationGroup %>"
                                                        TextField="Type" Value='<%# Eval("Type") %>' ID="cbtypeedit" OnCallback="cbtype_Callback1">
                                                        <ValidationSettings Display="Dynamic" ErrorDisplayMode="Text" ErrorTextPosition="Bottom">
                                                            <RequiredField IsRequired="true" ErrorText="Please choose Type." />
                                                        </ValidationSettings>
                                                    </dx:ASPxComboBox>
                                                </EditItemTemplate>
                                            </dx:GridViewDataColumn>
                                            <dx:GridViewDataTextColumn FieldName="Description" VisibleIndex="6" Visible="false">
                                                <EditFormSettings VisibleIndex="5" />
                                                <EditItemTemplate>
                                                    <dx:ASPxTextBox runat="server" Text='<%# Eval("Description") %>' ID="txtDescription"></dx:ASPxTextBox>
                                                </EditItemTemplate>
                                            </dx:GridViewDataTextColumn>
                                            <dx:GridViewDataTextColumn Caption="RangeSellout" FieldName="RangeSellout" Settings-ShowFilterRowMenu="True" Settings-AllowAutoFilter="True" VisibleIndex="7">
                                                <EditItemTemplate>
                                                <EditFormSettings VisibleIndex="6" />
                                                    <dx:ASPxTextBox ID="txtRangeSellout" runat="server" MaxLength="128" Width="170" Value='<%# Eval("RangeSellout") %>' ValidationSettings-ValidationGroup="<%# Container.ValidationGroup %>">
                                                        <ValidationSettings Display="Dynamic" ErrorDisplayMode="Text" ErrorTextPosition="Bottom">
                                                            <RequiredField IsRequired="true" ErrorText="Bạn phải nhập RangeSellout." />
                                                        </ValidationSettings>
                                                    </dx:ASPxTextBox>
                                                </EditItemTemplate>
                                            </dx:GridViewDataTextColumn>
                                            <dx:GridViewDataTextColumn Caption="RangeDisplay" FieldName="RangeDisplay" Settings-ShowFilterRowMenu="True" Settings-AllowAutoFilter="True" VisibleIndex="8">
                                                <EditItemTemplate>
                                                    <EditFormSettings VisibleIndex="7" />
                                                    <dx:ASPxTextBox ID="txtRangeDisplay" runat="server" MaxLength="128" Width="170" Value='<%# Eval("RangeDisplay") %>' ValidationSettings-ValidationGroup="<%# Container.ValidationGroup %>">
                                                        <ValidationSettings Display="Dynamic" ErrorDisplayMode="Text" ErrorTextPosition="Bottom">
                                                            <RequiredField IsRequired="true" ErrorText="Bạn phải nhập RangeDisplay." />
                                                        </ValidationSettings>
                                                    </dx:ASPxTextBox>
                                                </EditItemTemplate>
                                            </dx:GridViewDataTextColumn>
                                            <dx:GridViewDataTextColumn Caption="Cat" FieldName="GroupRange" Settings-ShowFilterRowMenu="True" Settings-AllowAutoFilter="True" VisibleIndex="9">
                                                <EditItemTemplate>
                                                    <EditFormSettings VisibleIndex="8" />
                                                    <dx:ASPxTextBox ID="txtGroupRange" runat="server" MaxLength="128" Width="170" Value='<%# Eval("GroupRange") %>' ValidationSettings-ValidationGroup="<%# Container.ValidationGroup %>">
                                                        <ValidationSettings Display="Dynamic" ErrorDisplayMode="Text" ErrorTextPosition="Bottom">
                                                            <RequiredField IsRequired="true" ErrorText="Bạn phải nhập Cat." />
                                                        </ValidationSettings>
                                                    </dx:ASPxTextBox>
                                                </EditItemTemplate>
                                            </dx:GridViewDataTextColumn>
                                            <dx:GridViewDataCheckColumn Caption="Status" FieldName="Deleted" Settings-ShowFilterRowMenu="True" Settings-AllowAutoFilter="True" VisibleIndex="10">
                                                <EditItemTemplate>
                                                    <dx:ASPxCheckBox runat="server" ValueType="System.Boolean" Value='<%# Eval("Deleted") %>' ID="chkDeleted"></dx:ASPxCheckBox>
                                                </EditItemTemplate>
                                            </dx:GridViewDataCheckColumn>
                                            <dx:GridViewDataCheckColumn Caption="IsNew" FieldName="IsNew" Settings-ShowFilterRowMenu="True" Settings-AllowAutoFilter="True" VisibleIndex="11">
                                                <EditItemTemplate>
                                                    <dx:ASPxCheckBox runat="server" ValueType="System.Boolean" Value='<%# Eval("IsNew") %>' ID="chkIsNew"></dx:ASPxCheckBox>
                                                </EditItemTemplate>
                                            </dx:GridViewDataCheckColumn>
                                            <dx:GridViewCommandColumn ShowEditButton="true" ShowNewButtonInHeader="true" ShowDeleteButton="true">
                                            </dx:GridViewCommandColumn>
                                        </Columns>
                                        <Templates>
                                            <EditForm>
                                                <div style="padding: 4px 4px 3px 4px">
                                                    <dx:ASPxGridViewTemplateReplacement runat="server" ReplacementType="EditFormEditors" />
                                                </div>
                                                <div style="text-align: right; padding: 2px 2px 2px 2px">
                                                    <dx:ASPxHyperLink ID="UpdateLink" runat="server" CssClass="edInline" ClientEnabled="true" Text="Update" ClientInstanceName="btnupdate"
                                                        NavigateUrl="javascript:return false;" ValidationSettings-ValidationGroup="<%# Container.ValidationGroup %>">
                                                        <ClientSideEvents Click="function(s, e) {gvProduct.UpdateEdit();}" />
                                                    </dx:ASPxHyperLink>
                                                    <dx:ASPxHyperLink ID="ASPxHyperLink1" runat="server" CssClass="edInline" ClientEnabled="true" Text="Cancel"
                                                        NavigateUrl="javascript:return false;">
                                                        <ClientSideEvents Click="function(s, e) {gvProduct.CancelEdit();}" />
                                                    </dx:ASPxHyperLink>
                                                </div>
                                            </EditForm>
                                        </Templates>
                                        <SettingsCommandButton>
                                            <EditButton Text="Sửa" />
                                        </SettingsCommandButton>
                                    </dx:ASPxGridView>
                                </div>
                            </div>
                        </div>
                    </div>
                </dx:PanelContent>
            </PanelCollection>
        </dx:ASPxCallbackPanel>
        <asp:ObjectDataSource ID="odsProductPrice" runat="server" SelectMethod="GetPrice" TypeName="Beko.BLL.ProductsController">
            <SelectParameters>
                <asp:SessionParameter Name="EffectiveDate" SessionField="EffectiveDate" Type="String" />
            </SelectParameters>
        </asp:ObjectDataSource>
        <asp:ObjectDataSource ID="odsProductList" runat="server" 
            SelectMethod="getList" TypeName="LogicTier.Controllers.ProductsBL">
            <SelectParameters>
                <asp:Parameter Name="productId" Type="Int32" />
                <asp:Parameter Name="product" Type="String" />
                <asp:Parameter Name="range" Type="String" />
                <asp:Parameter Name="model" Type="String" />
                <asp:Parameter Name="capacity" Type="String" />
                <asp:Parameter Name="type" Type="String" />
                <asp:Parameter Name="status" Type="Boolean" ConvertEmptyStringToNull="true" />
            </SelectParameters>
        </asp:ObjectDataSource>
        <asp:ObjectDataSource ID="odsProduct" runat="server" SelectMethod="getDivision" TypeName="LogicTier.Controllers.ProductsBL">
            <SelectParameters>
                <asp:Parameter DefaultValue="Product" Name="fieldName" Type="String" />
                <asp:Parameter Name="fieldValue" Type="String" />
                <asp:Parameter DefaultValue="Product" Name="fieldDisplay" Type="String" />
            </SelectParameters>
        </asp:ObjectDataSource>
        <asp:ObjectDataSource ID="odsrangeedit" runat="server" SelectMethod="getDivision" TypeName="LogicTier.Controllers.ProductsBL">
            <SelectParameters>
                <asp:Parameter DefaultValue="Product" Name="fieldName" Type="String" />
                <asp:Parameter Name="fieldValue" Type="String" />
                <asp:Parameter DefaultValue="Range" Name="fieldDisplay" Type="String" />
            </SelectParameters>
        </asp:ObjectDataSource>
        <asp:ObjectDataSource ID="odsCapacityedit" runat="server" SelectMethod="getDivision" TypeName="LogicTier.Controllers.ProductsBL">
            <SelectParameters>
                <asp:Parameter DefaultValue="Range" Name="fieldName" Type="String" />
                <asp:Parameter Name="fieldValue" Type="String" />
                <asp:Parameter DefaultValue="Capacity" Name="fieldDisplay" Type="String" />
            </SelectParameters>
        </asp:ObjectDataSource>
        <asp:ObjectDataSource ID="odstypedit" runat="server" SelectMethod="getDivision" TypeName="LogicTier.Controllers.ProductsBL">
            <SelectParameters>
                <asp:Parameter DefaultValue="Capacity" Name="fieldName" Type="String" />
                <asp:Parameter Name="fieldValue" Type="String" />
                <asp:Parameter DefaultValue="Type" Name="fieldDisplay" Type="String" />
            </SelectParameters>
        </asp:ObjectDataSource>
    </div>
    <dx:ASPxPopupControl ID="pcImport" runat="server" Width="320" CloseAction="CloseButton" CloseOnEscape="true" Modal="True"
        PopupHorizontalAlign="WindowCenter" PopupVerticalAlign="WindowCenter" ClientInstanceName="pcImport"
        HeaderText="Import List Price" AllowDragging="True" PopupAnimationType="None" EnableViewState="False" AutoUpdatePosition="true">
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
                                                <dx:ASPxUploadControl ID="uploadPrice" runat="server" ClientInstanceName="uploadPrice"
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
                                                            <ClientSideEvents Click="function(s, e) { uploadPrice.UploadFile();}" />
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