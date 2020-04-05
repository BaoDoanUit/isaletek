<%@ Page Title="Outlets" Language="C#" MasterPageFile="~/Layout.master" AutoEventWireup="true" CodeBehind="Outlets.aspx.cs" Inherits="WebApplication.Pages.Outlets" %>

<%@ Register Assembly="DevExpress.Web.ASPxPivotGrid.v17.1, Version=17.1.6.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.ASPxPivotGrid" TagPrefix="dx" %>
<%@ Register Src="~/UserControls/ToolbarExport.ascx" TagPrefix="uc1" TagName="ToolbarExport" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Content" runat="server">
    <script async defer src="https://maps.googleapis.com/maps/api/js?key=AIzaSyBAZuhZ81_5dAP3fJrOR0XytTMoXc5dUgk"></script>
    <script type="text/javascript">
        function AddSelectedItems() {
            MoveSelectedItems(lbAvailable, lbChoosen);
            UpdateButtonState();
        }
        function AddAllItems() {
            MoveAllItems(lbAvailable, lbChoosen);
            UpdateButtonState();
        }
        function RemoveSelectedItems() {
            MoveSelectedItems(lbChoosen, lbAvailable);
            UpdateButtonState();
        }
        function RemoveAllItems() {
            MoveAllItems(lbChoosen, lbAvailable);
            UpdateButtonState();
        }
        function MoveSelectedItems(srcListBox, dstListBox) {
            srcListBox.BeginUpdate();
            dstListBox.BeginUpdate();
            var items = srcListBox.GetSelectedItems();
            for (var i = items.length - 1; i >= 0; i = i - 1) {
                var itemText = GetSplitText(items[i].text);
                dstListBox.AddItem(itemText, items[i].value);
                srcListBox.RemoveItem(items[i].index);
            }
            srcListBox.EndUpdate();
            dstListBox.EndUpdate();
        }
        function MoveAllItems(srcListBox, dstListBox) {
            srcListBox.BeginUpdate();
            var count = srcListBox.GetItemCount();
            for (var i = 0; i < count; i++) {
                var item = srcListBox.GetItem(i);
                var itemText = GetSplitText(item.text);
                dstListBox.AddItem(itemText, item.value);
            }
            srcListBox.EndUpdate();
            srcListBox.ClearItems();
        }
        function UpdateButtonState() {
            btnMoveAllItemsToRight.SetEnabled(lbAvailable.GetItemCount() > 0);
            btnMoveAllItemsToLeft.SetEnabled(lbChoosen.GetItemCount() > 0);
            btnMoveSelectedItemsToRight.SetEnabled(lbAvailable.GetSelectedItems().length > 0);
            btnMoveSelectedItemsToLeft.SetEnabled(lbChoosen.GetSelectedItems().length > 0);
        }

        function GetSplitText(text) {
            var splitedText = text.split(';');
            var index = 0;
            for (str in splitedText) {
                if (index != 0) {
                    splitedText[index] = splitedText[index].slice(1);
                }
                index++;
            }
            return splitedText;
        }

        function OnEndCallback(s, e) {
            if (s.cpAlert != '') {
                alert(s.cpAlert);
            }
        }

        function onEndCallbackgvEmployee(s, e) {
            if (s.cpEmp != '') {
                alert(s.cpEmp);
            }
        }
        function gvShopEndCallback(s, e) {
            if (s.cpShopAlert != '') {
                alert(s.cpShopAlert);
            }
        }

        //geocode address
        var geocoder;
        function initMap() {
            geocoder = new google.maps.Geocoder();
            document.getElementById('submit').addEventListener('click', function () {
                geocodeAddress();
            });
        }
        function geocodeAddress() {
            var address = eAddress.GetText();
            geocoder.geocode({ 'address': address }, function (results, status) {
                if (status === 'OK') {
                    eLat.SetText(results[0].geometry.location.lat());
                    eLng.SetText(results[0].geometry.location.lng());
                } else {
                    alert('Geocode was not successful for the following reason: ' + status);
                }
            });
        }
        function getGPS() {
            var geocoder = new google.maps.Geocoder();
            var address = eAddress.GetText();
            geocoder.geocode({ 'address': address }, function (results, status) {
                if (status == google.maps.GeocoderStatus.OK) {
                    eLat.SetText(results[0].geometry.location.lat());
                    eLng.SetText(results[0].geometry.location.lng());
                }
            });
        }
    </script>
    <script type="text/javascript">
        $(document).ready(function () {
            $("#TopPanel_NavMenu ul li:eq(6)").addClass("dxm-selected");
        })
    </script>
    <style type="text/css">
        .dxeRadioButtonList_Moderno td.dxe, .dxeCheckBoxList_Moderno td.dxe {
            padding: 0 !important
        }
    </style>
    <div class="container">
        <asp:ObjectDataSource ID="odsregion" runat="server" SelectMethod="getDivision" TypeName="LogicTier.Controllers.OutletBL">
            <SelectParameters>
                <asp:Parameter DefaultValue="Region" Name="fieldName" Type="String" />
                <asp:Parameter Name="fieldValue" Type="String" />
                <asp:Parameter DefaultValue="Region" Name="fieldDisplay" Type="String" />
            </SelectParameters>
        </asp:ObjectDataSource>
        <asp:ObjectDataSource ID="odsCity" runat="server" SelectMethod="getDivision" TypeName="LogicTier.Controllers.OutletBL">
            <SelectParameters>
                <asp:Parameter DefaultValue="City" Name="fieldName" Type="String" />
                <asp:Parameter Name="fieldValue" Type="String" />
                <asp:Parameter DefaultValue="City" Name="fieldDisplay" Type="String" />
            </SelectParameters>
        </asp:ObjectDataSource>
        <div class="row marginTop20">
            <div class="col-md-12">
                <dx:ASPxFormLayout ID="AddCommentFormLayout" runat="server" UseDefaultPaddings="false">
                    <SettingsItems Width="100%" />
                    <SettingsItemCaptions Location="Top" />
                    <Items>
                        <dx:LayoutGroup Caption="Outlets">
                            <Items>
                                <dx:LayoutItem ShowCaption="False">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer>
                                            <div class="row">
                                                <div class="col-md-3">
                                                    <label>Account</label>
                                                    <dx:ASPxComboBox runat="server" ID="cbAcc" Width="100%" ValueType="System.Int32" NullText="--ALL--">
                                                        <Items>
                                                            <dx:ListEditItem Text="HL" Value="1" />
                                                            <dx:ListEditItem Text="GH" Value="2" />
                                                        </Items>
                                                        <ClearButton DisplayMode="OnHover"></ClearButton>
                                                    </dx:ASPxComboBox>
                                                </div>
                                                <div class="col-md-3">
                                                    <label>Region</label>
                                                    <dx:ASPxComboBox runat="server" ID="cbRegion" Width="100%" DataSourceID="odsregion"
                                                        ValueType="System.String" TextField="Region" ValueField="Region" NullText="Choose to filter by Region"
                                                        ClientInstanceName="cbRegion" CallbackPageSize="10">
                                                        <ClearButton DisplayMode="OnHover"></ClearButton>
                                                    </dx:ASPxComboBox>
                                                </div>
                                                <div class="col-md-3">
                                                    <label>Dealer</label>
                                                    <dx:ASPxComboBox runat="server" ID="cbAccount" Width="100%" ValueType="System.Int32" NullText="Choose to select Dealer"
                                                        DataSourceID="odsAccount" TextField="Account" ValueField="ObjectId"
                                                        ClientInstanceName="cbAccount" CallbackPageSize="10">
                                                        <ClearButton DisplayMode="OnHover"></ClearButton>
                                                    </dx:ASPxComboBox>
                                                    <asp:ObjectDataSource ID="odsAccount" runat="server" 
                                                        SelectMethod="getAccountGroup" TypeName="LogicTier.Controllers.SaleOutBL"></asp:ObjectDataSource>
                                                </div>
                                                <div class="col-md-3">
                                                    <label>Shop Code/Mã CH</label>
                                                    <dx:ASPxButtonEdit runat="server" Width="100%" ID="ShopCode">
                                                        <ClearButton DisplayMode="OnHover"></ClearButton>
                                                    </dx:ASPxButtonEdit>
                                                </div>
                                            </div>
                                            <div class="row marginTop20">
                                                <div class="col-md-3">
                                                    <label>Outtlets/Cửa hàng</label>
                                                    <dx:ASPxButtonEdit runat="server" Width="100%" ID="ShopName">
                                                        <ClearButton DisplayMode="OnHover"></ClearButton>
                                                    </dx:ASPxButtonEdit>
                                                </div>
                                                <div class="col-md-3">
                                                    <label>Month/target Outlet</label>
                                                    <dx:ASPxComboBox runat="server" ID="cbMonth" Width="100%" DataSourceID="odsMonth" ValueField="MonthCycle" ValueType="System.String" NullText="--All--"
                                                        ClientInstanceName="cbMonth" EnableCallbackMode="true" DropDownStyle="DropDownList">
                                                        <ClearButton DisplayMode="OnHover"></ClearButton>
                                                        <Columns>
                                                            <dx:ListBoxColumn FieldName="MonthCycle" Caption="Month" />
                                                        </Columns>
                                                    </dx:ASPxComboBox>
                                                    <asp:ObjectDataSource ID="odsMonth" runat="server" SelectMethod="getMonth" TypeName="LogicTier.Controllers.TermController">
                                                        <SelectParameters>
                                                            <asp:Parameter Name="Id" Type="Int32" ConvertEmptyStringToNull="true" />
                                                        </SelectParameters>
                                                    </asp:ObjectDataSource>
                                                </div>
                                                <div class="col-md-6">
                                                    <label>Status/Trạng thái</label>
                                                    <dx:ASPxRadioButtonList ID="rbStatusF" RepeatDirection="Horizontal" ClientInstanceName="rbStatusF" runat="server">
                                                        <Items>
                                                            <dx:ListEditItem Text="Đang hoạt động" Value="0" Selected="true" />
                                                            <dx:ListEditItem Text="Ngưng hoạt động" Value="1" />
                                                        </Items>
                                                    </dx:ASPxRadioButtonList>
                                                </div>
                                            </div>
                                            <div class="row marginTop20">
                                                <div class="col-md-12">
                                                    <label style="color: #fff">Action</label><br />
                                                    <dx:ASPxButton ID="FilterButton" AutoPostBack="false" runat="server" CssClass="btn btn-primary" Text="Tìm kiếm">
                                                        <ClientSideEvents Click="function(s, e) {  cp.PerformCallback('filter'); }"></ClientSideEvents>
                                                    </dx:ASPxButton>
                                                    <dx:ASPxButton ID="btImport" AutoPostBack="false" runat="server" Text="Import Target Shop" CssClass="btn btn-warning">
                                                        <ClientSideEvents Click="function(s, e) { pcImport.Show(); }" />
                                                    </dx:ASPxButton>
                                                    <dx:ASPxButton ID="ASPxButton5" AutoPostBack="false" runat="server" Text="Import Target SO" CssClass="btn btn-warning">
                                                        <ClientSideEvents Click="function(s, e) { pcImport2.Show(); }" />
                                                    </dx:ASPxButton>
                                                    <dx:ASPxButton ID="ASPxButton7" AutoPostBack="false" runat="server" Text="Shop Master" CssClass="btn btn-warning">
                                                        <ClientSideEvents Click="function(s, e) { pcImport3.Show(); }" />
                                                    </dx:ASPxButton>
                                                    <dx:ASPxButton ID="ASPxButton12" AutoPostBack="false" runat="server" 
                                                        Text="Dealer Info" CssClass="btn btn-warning">
                                                        <ClientSideEvents Click="function(s, e) { pcImportDealer.Show(); }" />
                                                    </dx:ASPxButton>
                                                    <dx:ASPxButton ID="ASPxButton4" AutoPostBack="false" runat="server" Visible="false" Text="Del Target" CssClass="btn btn-danger">
                                                        <ClientSideEvents Click="function(s, e) { pcDelete.Show();}" />
                                                    </dx:ASPxButton>

                                                    <a id="link1" runat="server" href="/Content/template/Shop_Target_Month.xlsx">Target Shop</a>
                                                    &nbsp;&nbsp;&nbsp;<a id="link2" runat="server"  href="/Content/template/Shop_Target_Product.xlsx">Target SO</a>
                                                    &nbsp;&nbsp;&nbsp;<a id="link3" runat="server" href='/Pages/DownTemp.aspx?type=outlet' target="_blank">Shop Master</a>
                                                    &nbsp;&nbsp;&nbsp;<a id="link4" runat="server" href='/Pages/DownTemp.aspx?type=DealerInfo' target="_blank">Dealer Info</a>

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
        <div class="row marginTop20">
            <div class="col-md-12">
                <dx:ASPxCallbackPanel ID="ASPxCallbackPanel1" runat="server" Width="100%"
                    ClientInstanceName="cp" OnCallback="ASPxCallbackPanel1_Callback">
                    <ClientSideEvents EndCallback="OnEndCallback" />
                    <PanelCollection>
                        <dx:PanelContent runat="server">
                            <dx:ASPxPageControl ID="ASPxPageControl1" runat="server" ActiveTabIndex="0" Width="100%">
                                <TabPages>
                                    <dx:TabPage Text="Danh sách outlet">
                                        <ContentCollection>
                                            <dx:ContentControl runat="server">
                                                <div class="row">
                                                    <div class="col-md-10">
                                                        <uc1:ToolbarExport runat="server" ID="ToolbarExport1" OnItemClick="ToolbarExport1_ItemClick" />
                                                        <dx:ASPxGridViewExporter ID="ASPxGridViewExporter1" runat="server" ExportSelectedRowsOnly="true" GridViewID="gvOutlet">
                                                        </dx:ASPxGridViewExporter>
                                                    </div>
                                                    <div class="col-md-2 text-right" style="padding-right: 30px; color: orangered; font-weight: 600">
                                                        <asp:Label ID="lbcode" runat="server" Text=""></asp:Label>
                                                    </div>
                                                </div>
                                                <div class="row">
                                                    <div class="col-md-12">
                                                        <table class="OptionsBottomMargin">
                                                            <tr>
                                                                <td style="padding-right: 4px">
                                                                    <dx:ASPxButton ID="btnSelectAll" runat="server" Text="Chọn tất cả" UseSubmitBehavior="False"
                                                                        AutoPostBack="false">
                                                                        <ClientSideEvents Click="function(s, e) { gvOutlet.SelectRows(); }" />
                                                                    </dx:ASPxButton>
                                                                </td>
                                                                <td style="padding-right: 4px">
                                                                    <dx:ASPxButton ID="btnSelectAllOnPage" runat="server" Text="Chọn 1 trang"
                                                                        UseSubmitBehavior="False" AutoPostBack="false">
                                                                        <ClientSideEvents Click="function(s, e) { gvOutlet.SelectAllRowsOnPage(); }" />
                                                                    </dx:ASPxButton>
                                                                </td>
                                                                <td style="padding-right: 4px">
                                                                    <dx:ASPxButton ID="btnUnselectAll" runat="server" Text="Bỏ chọn" UseSubmitBehavior="False"
                                                                        AutoPostBack="false">
                                                                        <ClientSideEvents Click="function(s, e) { gvOutlet.UnselectRows(); gvOutlet.UnselectAllRowsOnPage(); }" />
                                                                    </dx:ASPxButton>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </div>
                                                </div>
                                                <div class="row marginTop20">
                                                    <div class="col-md-12">
                                                        <dx:ASPxGridView runat="server" AutoGenerateColumns="False" ID="gvOutlet" ClientInstanceName="gvOutlet" Width="100%"
                                                            KeyFieldName="ShopId" OnLoad="gvOutlet_Load"
                                                            OnRowInserting="gvOutlet_RowInserting"
                                                            OnRowUpdating="gvOutlet_RowUpdating"
                                                            OnRowDeleting="gvOutlet_RowDeleting" DataSourceID="odsOutlets">
                                                            <ClientSideEvents EndCallback="gvShopEndCallback" />
                                                            <SettingsCommandButton>
                                                                <DeleteButton Text="Delete"></DeleteButton>
                                                                <EditButton Text="Edit"></EditButton>
                                                            </SettingsCommandButton>
                                                            <SettingsBehavior ConfirmDelete="true" AllowFocusedRow="True" />
                                                            <SettingsText ConfirmDelete="Bạn có muốn xóa không?" />
                                                            <SettingsEditing EditFormColumnCount="3" />
                                                            <Styles Header-Wrap="True">
                                                                <Header Wrap="True"></Header>
                                                                <AlternatingRow Enabled="true" />
                                                            </Styles>
                                                            <Templates>
                                                                <EditForm>
                                                                    <dx:ASPxPageControl ID="ASPxPageControl1" runat="server" ActiveTabIndex="0" Width="100%">
                                                                        <TabPages>
                                                                            <dx:TabPage Text="Thông tin cửa hàng">
                                                                                <ContentCollection>
                                                                                    <dx:ContentControl runat="server">
                                                                                        <dx:ASPxGridViewTemplateReplacement runat="server" ReplacementType="EditFormEditors" />
                                                                                    </dx:ContentControl>
                                                                                </ContentCollection>
                                                                            </dx:TabPage>
                                                                            <dx:TabPage Text="Thông tin PC">
                                                                                <ContentCollection>
                                                                                    <dx:ContentControl runat="server">
                                                                                        <div class="col-md-12">
                                                                                            <dx:ASPxGridView runat="server" ID="gvEmployee" ClientInstanceName="gvEmployee" AutoGenerateColumns="false"
                                                                                                KeyFieldName="ShopId;EmployeeId;ActiveDate" DataSourceID="odsEmployee"
                                                                                                OnBeforePerformDataSelect="gvEmployee_BeforePerformDataSelect" OnLoad="gvEmployee_Load"
                                                                                                OnRowDeleting="gvEmployee_RowDeleting" OnRowInserting="gvEmployee_RowInserting">
                                                                                                <ClientSideEvents EndCallback="onEndCallbackgvEmployee" />
                                                                                                <SettingsCommandButton>
                                                                                                    <DeleteButton Text="Delete"></DeleteButton>
                                                                                                </SettingsCommandButton>
                                                                                                <SettingsBehavior ConfirmDelete="true" AllowFocusedRow="True" />
                                                                                                <SettingsText ConfirmDelete="Bạn có muốn xóa không?" />
                                                                                                <SettingsEditing EditFormColumnCount="3" />
                                                                                                <Styles Header-Wrap="True">
                                                                                                    <Header Wrap="True"></Header>
                                                                                                </Styles>
                                                                                                <Templates>
                                                                                                    <EditForm>
                                                                                                        <div class="row">
                                                                                                            <div class="col-md-5">
                                                                                                                <dx:ASPxListBox ID="lbAvailable" runat="server" ClientInstanceName="lbAvailable"
                                                                                                                    Width="100%" Height="240px" SelectionMode="Multiple" Caption="Available" DataSourceID="odsAvailable"
                                                                                                                    TextField="EmployeeName" ValueField="EmployeeId">
                                                                                                                    <CaptionSettings Position="Top" />
                                                                                                                    <ClientSideEvents SelectedIndexChanged="function(s, e) { UpdateButtonState(); }" />
                                                                                                                    <Columns>
                                                                                                                        <dx:ListBoxColumn FieldName="EmployeeId" Visible="false" />
                                                                                                                        <dx:ListBoxColumn FieldName="EmployeeCode" Caption="Mã nhân viên" />
                                                                                                                        <dx:ListBoxColumn FieldName="EmployeeName" Caption="Tên nhân viên" />
                                                                                                                        <dx:ListBoxColumn FieldName="nDate" Caption="Ngày hiệu lực" />
                                                                                                                    </Columns>
                                                                                                                </dx:ASPxListBox>
                                                                                                                <asp:ObjectDataSource ID="odsAvailable" runat="server" SelectMethod="Available" TypeName="LogicTier.Controllers.EmployeeByShopBL"></asp:ObjectDataSource>
                                                                                                            </div>
                                                                                                            <div class="col-md-2">
                                                                                                                <div class="row" style="padding-top: 80px;">
                                                                                                                    <dx:ASPxButton ID="btnMoveSelectedItemsToRight" runat="server" ClientInstanceName="btnMoveSelectedItemsToRight"
                                                                                                                        AutoPostBack="False" Text="Add >" Width="150px" ClientEnabled="False"
                                                                                                                        ToolTip="Add selected items">
                                                                                                                        <ClientSideEvents Click="function(s, e) { AddSelectedItems(); }" />
                                                                                                                    </dx:ASPxButton>
                                                                                                                </div>
                                                                                                                <div class="row" style="padding-top: 5px;">
                                                                                                                    <dx:ASPxButton ID="btnMoveAllItemsToRight" runat="server" ClientInstanceName="btnMoveAllItemsToRight"
                                                                                                                        AutoPostBack="False" Text="Add All >>" Width="150px" ToolTip="Add all items">
                                                                                                                        <ClientSideEvents Click="function(s, e) { AddAllItems(); }" />
                                                                                                                    </dx:ASPxButton>
                                                                                                                </div>
                                                                                                                <div class="row" style="padding-top: 5px;">
                                                                                                                    <dx:ASPxButton ID="btnMoveSelectedItemsToLeft" runat="server" ClientInstanceName="btnMoveSelectedItemsToLeft"
                                                                                                                        AutoPostBack="False" Text="< Remove" Width="150px" ClientEnabled="False"
                                                                                                                        ToolTip="Remove selected items">
                                                                                                                        <ClientSideEvents Click="function(s, e) { RemoveSelectedItems(); }" />
                                                                                                                    </dx:ASPxButton>
                                                                                                                </div>
                                                                                                                <div class="row" style="padding-top: 5px;">
                                                                                                                    <dx:ASPxButton ID="btnMoveAllItemsToLeft" runat="server" ClientInstanceName="btnMoveAllItemsToLeft"
                                                                                                                        AutoPostBack="False" Text="<< Remove All" Width="150px" ClientEnabled="False"
                                                                                                                        ToolTip="Remove all items">
                                                                                                                        <ClientSideEvents Click="function(s, e) { RemoveAllItems(); }" />
                                                                                                                    </dx:ASPxButton>
                                                                                                                </div>
                                                                                                            </div>
                                                                                                            <div class="col-md-5">
                                                                                                                <dx:ASPxListBox ID="lbChoosen" runat="server" ClientInstanceName="lbChoosen" Width="100%" OnInit="lbChoosen_Init"
                                                                                                                    Height="240px" SelectionMode="Multiple" Caption="Chosen" DataSourceID="odsChosen"
                                                                                                                    TextField="ActiveDate" ValueField="EmployeeId">
                                                                                                                    <Columns>
                                                                                                                        <dx:ListBoxColumn FieldName="EmployeeId" Visible="false" />
                                                                                                                        <dx:ListBoxColumn FieldName="EmployeeCode" Caption="Mã nhân viên" />
                                                                                                                        <dx:ListBoxColumn FieldName="EmployeeName" Caption="Tên nhân viên" />
                                                                                                                        <dx:ListBoxColumn FieldName="nDate" Caption="Ngày hiệu lực" />
                                                                                                                    </Columns>
                                                                                                                    <CaptionSettings Position="Top" />
                                                                                                                    <ClientSideEvents SelectedIndexChanged="function(s, e) { UpdateButtonState(); }"></ClientSideEvents>
                                                                                                                </dx:ASPxListBox>
                                                                                                            </div>
                                                                                                        </div>
                                                                                                        <div style="text-align: right; padding: 8px 8px 8px">
                                                                                                            <dx:ASPxGridViewTemplateReplacement runat="server" ReplacementType="EditFormUpdateButton" />
                                                                                                            <dx:ASPxGridViewTemplateReplacement runat="server" ReplacementType="EditFormCancelButton" />
                                                                                                        </div>
                                                                                                    </EditForm>
                                                                                                </Templates>
                                                                                                <Columns>
                                                                                                    <dx:GridViewDataBinaryImageColumn FieldName="Pic" Caption="Ảnh đại diện" VisibleIndex="0">
                                                                                                        <PropertiesBinaryImage ImageHeight="80px" ImageWidth="80px" ImageAlign="AbsMiddle">
                                                                                                        </PropertiesBinaryImage>
                                                                                                        <EditFormSettings Visible="False" />
                                                                                                    </dx:GridViewDataBinaryImageColumn>
                                                                                                    <dx:GridViewDataColumn FieldName="EmployeeCode" Caption="Mã nhân viên" VisibleIndex="1">
                                                                                                        <EditFormSettings Visible="False" />
                                                                                                    </dx:GridViewDataColumn>
                                                                                                    <dx:GridViewDataDateColumn FieldName="EmployeeName" Caption="Tên nhân viên" VisibleIndex="2">
                                                                                                        <EditFormSettings Visible="False" />
                                                                                                    </dx:GridViewDataDateColumn>
                                                                                                    <dx:GridViewDataColumn FieldName="Mobile" VisibleIndex="3"></dx:GridViewDataColumn>
                                                                                                    <dx:GridViewCommandColumn ShowNewButtonInHeader="true" ShowApplyFilterButton="true" ShowEditButton="false" ShowDeleteButton="true" VisibleIndex="4">
                                                                                                    </dx:GridViewCommandColumn>
                                                                                                </Columns>
                                                                                            </dx:ASPxGridView>
                                                                                            <asp:ObjectDataSource runat="server" ID="odsEmployee" SelectMethod="Chosen" TypeName="LogicTier.Controllers.EmployeeByShopBL" DataObjectTypeName="LogicTier.Models.EmployeeByShop" DeleteMethod="Delete" InsertMethod="Insert">
                                                                                                <DeleteParameters>
                                                                                                    <asp:Parameter Name="shopId" Type="Int32" />
                                                                                                    <asp:Parameter Name="empId" Type="Int32" />
                                                                                                    <asp:Parameter Name="acDate" Type="String" />
                                                                                                </DeleteParameters>
                                                                                                <SelectParameters>
                                                                                                    <asp:SessionParameter Name="shopId" SessionField="shopid" Type="Int32" />
                                                                                                </SelectParameters>
                                                                                            </asp:ObjectDataSource>
                                                                                        </div>
                                                                                    </dx:ContentControl>
                                                                                </ContentCollection>
                                                                            </dx:TabPage>
                                                                        </TabPages>
                                                                    </dx:ASPxPageControl>
                                                                    <div style="text-align: right; padding: 8px 8px 8px">
                                                                        <dx:ASPxGridViewTemplateReplacement runat="server" ReplacementType="EditFormUpdateButton" />
                                                                        <dx:ASPxGridViewTemplateReplacement runat="server" ReplacementType="EditFormCancelButton" />
                                                                    </div>
                                                                </EditForm>
                                                            </Templates>
                                                            <Columns>
                                                                <dx:GridViewCommandColumn ShowSelectCheckbox="True" VisibleIndex="0" />
                                                                <dx:GridViewDataBinaryImageColumn FieldName="Pic" VisibleIndex="1" Visible="false">
                                                                    <EditFormSettings VisibleIndex="0" RowSpan="5" Visible="True" />
                                                                    <EditItemTemplate>
                                                                        <dx:ASPxBinaryImage ID="ASPxBinaryImage1" runat="server"
                                                                            Value='<%# Eval("Pic") %>' Width="150px" Height="150px"
                                                                            ShowLoadingImage="true">
                                                                            <EditingSettings Enabled="true">
                                                                                <UploadSettings>
                                                                                    <UploadValidationSettings MaxFileSize="4194304" AllowedFileExtensions=".jpe, .jpeg, .jpg, .gif, .png"></UploadValidationSettings>
                                                                                </UploadSettings>
                                                                            </EditingSettings>
                                                                        </dx:ASPxBinaryImage>
                                                                    </EditItemTemplate>
                                                                </dx:GridViewDataBinaryImageColumn>
                                                                <dx:GridViewDataTextColumn FieldName="ShopCode" Caption="Mã CH" VisibleIndex="2">
                                                                    <EditFormSettings VisibleIndex="1" />
                                                                    <EditItemTemplate>
                                                                        <dx:ASPxTextBox runat="server" ID="eShopCode" Text='<%# Eval("ShopCode") %>' ValidationSettings-ValidationGroup="<%# Container.ValidationGroup %>">
                                                                            <ValidationSettings Display="Dynamic" ErrorDisplayMode="Text" ErrorTextPosition="Bottom">
                                                                                <RequiredField IsRequired="true" ErrorText="Bạn chưa nhập Mã cửa hàng." />
                                                                            </ValidationSettings>
                                                                        </dx:ASPxTextBox>
                                                                    </EditItemTemplate>
                                                                </dx:GridViewDataTextColumn>
                                                                <dx:GridViewDataTextColumn FieldName="ShopName" VisibleIndex="3" Caption="Tên cửa hàng PMNS">
                                                                    <EditFormSettings VisibleIndex="2" />
                                                                    <PropertiesTextEdit>
                                                                        <ValidationSettings Display="Dynamic" ErrorDisplayMode="Text" ErrorTextPosition="Bottom">
                                                                            <RequiredField IsRequired="true" ErrorText="Bạn chưa nhập Tên cửa hàng." />
                                                                        </ValidationSettings>
                                                                    </PropertiesTextEdit>
                                                                </dx:GridViewDataTextColumn>
                                                                <dx:GridViewDataTextColumn FieldName="Address" VisibleIndex="4" Caption="Địa chỉ cửa hàng">
                                                                    <EditFormSettings VisibleIndex="3" ColumnSpan="2" />
                                                                    <EditItemTemplate>
                                                                        <div class="col-md-10" style="padding: 0;">
                                                                            <dx:ASPxTextBox runat="server" ID="eAddress" ClientInstanceName="eAddress" Text='<%# Eval("Address") %>' ValidationSettings-ValidationGroup="<%# Container.ValidationGroup %>"
                                                                                Width="100%">
                                                                                <ValidationSettings Display="Dynamic" ErrorDisplayMode="Text" ErrorTextPosition="Bottom">
                                                                                    <RequiredField IsRequired="true" ErrorText="Bạn chưa nhập địa chỉ CH." />
                                                                                </ValidationSettings>
                                                                            </dx:ASPxTextBox>
                                                                        </div>
                                                                        <div class="col-md-2" style="padding-left: 3px;">
                                                                            <input type="button" id="geoGPS" onclick="getGPS();" value="Get GPS" class="btn-primary" style="height: 33px;" />
                                                                        </div>
                                                                    </EditItemTemplate>
                                                                </dx:GridViewDataTextColumn>
                                                                <dx:GridViewDataColumn FieldName="Account" Caption="Dealer" VisibleIndex="5">
                                                                    <EditFormSettings VisibleIndex="4" />
                                                                    <EditItemTemplate>
                                                                        <dx:ASPxComboBox runat="server" ID="cbAccount" ValueType="System.Int32" NullText="Choose to select Dealer"
                                                                            DataSourceID="odsAccount" TextField="Account" ValueField="ObjectId" Value='<%#Eval("ObjectId") %>'
                                                                            ClientInstanceName="cbAccount" CallbackPageSize="10">
                                                                            <ClearButton DisplayMode="OnHover"></ClearButton>
                                                                        </dx:ASPxComboBox>
                                                                        <asp:ObjectDataSource ID="odsAccount" runat="server" SelectMethod="getAccountGroup" TypeName="LogicTier.Controllers.SaleOutBL"></asp:ObjectDataSource>
                                                                    </EditItemTemplate>
                                                                </dx:GridViewDataColumn>
                                                                <dx:GridViewDataColumn FieldName="Region" VisibleIndex="6">
                                                                    <EditFormSettings VisibleIndex="5" />
                                                                    <EditItemTemplate>
                                                                        <dx:ASPxComboBox runat="server" ID="cbRegion" DataSourceID="odsregion" Value='<%#Eval("Region") %>'
                                                                            ValueType="System.String" ValueField="Region" TextField="Region" NullText="Choose to filter by Region"
                                                                            ClientInstanceName="cbRegion" CallbackPageSize="10">
                                                                            <ClearButton DisplayMode="OnHover"></ClearButton>
                                                                        </dx:ASPxComboBox>
                                                                    </EditItemTemplate>
                                                                </dx:GridViewDataColumn>
                                                                <dx:GridViewDataTextColumn FieldName="City" VisibleIndex="7" Caption="Tỉnh/Tp">
                                                                    <EditFormSettings VisibleIndex="6" />
                                                                    <EditItemTemplate>
                                                                        <dx:ASPxComboBox runat="server" ID="cbCitedit" Value='<%#Eval("City") %>' DataSourceID="odsObject"
                                                                            ValueField="ObjectName" TextField="ObjectName" ValueType="System.String" NullText="Choose to province">
                                                                            <ClearButton DisplayMode="OnHover"></ClearButton>
                                                                        </dx:ASPxComboBox>
                                                                    </EditItemTemplate>
                                                                </dx:GridViewDataTextColumn>
                                                                <dx:GridViewDataTextColumn FieldName="District" VisibleIndex="8" Caption="Quận/Huyện">
                                                                    <EditFormSettings VisibleIndex="7" />
                                                                </dx:GridViewDataTextColumn>
                                                                <dx:GridViewDataColumn FieldName="Latitude" VisibleIndex="9" >
                                                                    <EditFormSettings VisibleIndex="8" Visible="True" />
                                                                    <EditItemTemplate>
                                                                        <dx:ASPxTextBox runat="server" ID="eLat" ClientInstanceName="eLat" Text='<%# Eval("Latitude") %>' Width="100%"></dx:ASPxTextBox>
                                                                    </EditItemTemplate>
                                                                </dx:GridViewDataColumn>
                                                                <dx:GridViewDataColumn FieldName="Longitude" VisibleIndex="10" >
                                                                    <EditFormSettings VisibleIndex="9" Visible="True" />
                                                                    <EditItemTemplate>
                                                                        <dx:ASPxTextBox runat="server" ID="eLng" ClientInstanceName="eLng" Text='<%# Eval("Longitude") %>' Width="100%"></dx:ASPxTextBox>
                                                                    </EditItemTemplate>
                                                                </dx:GridViewDataColumn>
                                                                <dx:GridViewDataColumn FieldName="StatusName" Caption="Trạng thái" VisibleIndex="11">
                                                                    <EditItemTemplate>
                                                                        <dx:ASPxComboBox runat="server" ID="cbStatus" Value='<%#Eval("IsDelete") %>' NullText="-Chọn trạng thái-"
                                                                            ClientInstanceName="cbStatus" ValueType="System.Int32" CallbackPageSize="10">
                                                                            <ClearButton DisplayMode="OnHover"></ClearButton>
                                                                            <Items>
                                                                                <dx:ListEditItem Text="Đang hoạt động" Value="0" Selected="true" />
                                                                                <dx:ListEditItem Text="Ngưng hoạt động" Value="1" />
                                                                            </Items>
                                                                        </dx:ASPxComboBox>
                                                                    </EditItemTemplate>
                                                                </dx:GridViewDataColumn>
                                                                <dx:GridViewDataTextColumn FieldName="FromDate" Caption="Ngày hoạt động" Visible="false">
                                                                    <EditFormSettings VisibleIndex="12" Visible="True" />
                                                                    <EditItemTemplate>
                                                                        <dx:ASPxDateEdit runat="server" ID="fDate" ClientInstanceName="fDate" Width="100%" DisplayFormatString="yyyy-MM-dd"
                                                                            EditFormat="Custom" EditFormatString="yyyy-MM-dd">
                                                                            <ClearButton DisplayMode="OnHover"></ClearButton>
                                                                        </dx:ASPxDateEdit>
                                                                    </EditItemTemplate>
                                                                </dx:GridViewDataTextColumn>
                                                                <dx:GridViewDataTextColumn FieldName="ToDate" Caption="Ngày ngưng h.động" Visible="false">
                                                                    <EditFormSettings VisibleIndex="13" Visible="True" />
                                                                    <EditItemTemplate>
                                                                        <dx:ASPxDateEdit runat="server" ID="tDate" Width="100%" ClientInstanceName="tDate" DisplayFormatString="yyyy-MM-dd"
                                                                            EditFormat="Custom" EditFormatString="yyyy-MM-dd">
                                                                            <ClearButton DisplayMode="OnHover"></ClearButton>
                                                                        </dx:ASPxDateEdit>
                                                                    </EditItemTemplate>
                                                                </dx:GridViewDataTextColumn>
                                                                <dx:GridViewDataTextColumn FieldName="ShopNotice" Caption="Ghi chú" Visible="false">
                                                                    <EditFormSettings VisibleIndex="14" ColumnSpan="2" Visible="True" />
                                                                    <EditItemTemplate>
                                                                        <div class="col-md-12" style="padding: 0;">
                                                                            <dx:ASPxTextBox runat="server" ID="eNotice" ClientInstanceName="eNotice" Text='<%# Eval("ShopNotice") %>' Width="100%">
                                                                            </dx:ASPxTextBox>
                                                                        </div>
                                                                    </EditItemTemplate>
                                                                </dx:GridViewDataTextColumn>
                                                                <dx:GridViewDataColumn FieldName="tgShop" VisibleIndex="11" Caption="Chỉ tiêu" Visible="false">
                                                                    <EditFormSettings Visible="False" />
                                                                </dx:GridViewDataColumn>
                                                                <dx:GridViewDataSpinEditColumn FieldName="orderby" VisibleIndex="11" Caption="Stt.Danh sách" Visible="false">
                                                                    <EditFormSettings Visible="False" />
                                                                    <EditFormSettings VisibleIndex="10" />
                                                                </dx:GridViewDataSpinEditColumn>
                                                                <dx:GridViewCommandColumn ShowNewButtonInHeader="true" ShowApplyFilterButton="true" ShowEditButton="true" ShowDeleteButton="true" VisibleIndex="12">
                                                                </dx:GridViewCommandColumn>
                                                            </Columns>
                                                        </dx:ASPxGridView>
                                                        <asp:ObjectDataSource ID="odsOutlets" runat="server" SelectMethod="getOutletWithReference" TypeName="LogicTier.Controllers.OutletBL" DataObjectTypeName="LogicTier.Models.Outlet" DeleteMethod="Delete" InsertMethod="Insert" UpdateMethod="Update">
                                                            <DeleteParameters>
                                                                <asp:Parameter Name="shopId" Type="Int32" />
                                                            </DeleteParameters>
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
                                                        <asp:ObjectDataSource ID="odsChosen" runat="server" SelectMethod="Chosen" TypeName="LogicTier.Controllers.EmployeeByShopBL">
                                                            <SelectParameters>
                                                                <asp:Parameter Name="shopId" Type="Int32" />
                                                            </SelectParameters>
                                                        </asp:ObjectDataSource>
                                                    </div>
                                                </div>
                                            </dx:ContentControl>
                                        </ContentCollection>
                                    </dx:TabPage>
                                    <dx:TabPage Text="Target Qty">
                                        <ContentCollection>
                                            <dx:ContentControl runat="server">
                                                <div class="row marginTop20">
                                                    <div class="col-md-12">
                                                        <dx:ASPxButton ID="ASPxButton1" AutoPostBack="false" runat="server" CssClass="btn btn-primary" Text="Export">
                                                            <ClientSideEvents Click="function(s, e) {  ImageExcelCallbackPanel.PerformCallback(); }"></ClientSideEvents>
                                                        </dx:ASPxButton>
                                                        <dx:ASPxCallbackPanel runat="server" ID="ImageExcelCallbackPanel" Style="margin-right: 10px; margin-top: 5px;" ClientInstanceName="ImageExcelCallbackPanel"
                                                            OnCallback="ImageExcelCallbackPanel_Callback" SettingsLoadingPanel-Text="Exporting Data, please wait.">
                                                            <PanelCollection>
                                                                <dx:PanelContent ID="PanelContent1" runat="server">
                                                                    <asp:HyperLink ID="hplexcel" runat="server"></asp:HyperLink>
                                                                </dx:PanelContent>
                                                            </PanelCollection>
                                                        </dx:ASPxCallbackPanel>
                                                        <dx:ASPxPivotGrid ID="gvtargetshop" runat="server"
                                                            DataSourceID="odstarget" Width="100%" ClientIDMode="AutoID">
                                                            <Fields>
                                                                <dx:PivotGridField Area="ColumnArea" AreaIndex="0" FieldName="ProductName" ID="fieldProduct" SortMode="Custom">
                                                                    <CellStyle HorizontalAlign="Center"></CellStyle>
                                                                </dx:PivotGridField>
                                                                <dx:PivotGridField Area="ColumnArea" AreaIndex="1" FieldName="RangeSellout" ID="fieldRange">
                                                                    <CellStyle HorizontalAlign="Center"></CellStyle>
                                                                </dx:PivotGridField>
                                                                <dx:PivotGridField Area="RowArea" AreaIndex="0" FieldName="ShopCode" ID="fieldShopCode" Options-AllowExpand="False" />
                                                                <dx:PivotGridField Area="RowArea" AreaIndex="1" FieldName="ShopName" ID="fieldShopName" Options-AllowExpand="False" />
                                                                <dx:PivotGridField Area="DataArea" AreaIndex="0" FieldName="TargetQty" ID="fieldTarget" SummaryType="SUM">
                                                                    <CellStyle HorizontalAlign="Center"></CellStyle>
                                                                </dx:PivotGridField>
                                                            </Fields>
                                                            <OptionsView HorizontalScrollBarMode="Auto" ShowColumnGrandTotals="False" ShowRowTotals="False" ShowRowGrandTotals="False" />
                                                            <OptionsFilter NativeCheckBoxes="False" ShowOnlyAvailableItems="true" />
                                                        </dx:ASPxPivotGrid>
                                                        <asp:ObjectDataSource ID="odstarget" runat="server" SelectMethod="getListQty" TypeName="LogicTier.Controllers.TargetForOutletBL" DataObjectTypeName="LogicTier.Models.TargetForOutlet">
                                                            <SelectParameters>
                                                                <asp:Parameter Name="AccountId" Type="Int32" />
                                                                <asp:Parameter Name="shopCode" Type="String" />
                                                                <asp:Parameter Name="ActiveMonth" Type="Int32" />
                                                                <asp:Parameter Name="ActiveYear" Type="Int32" />
                                                            </SelectParameters>
                                                        </asp:ObjectDataSource>
                                                    </div>
                                                </div>
                                            </dx:ContentControl>
                                        </ContentCollection>
                                    </dx:TabPage>
                                    <dx:TabPage Text="Target Amt">
                                        <ContentCollection>
                                            <dx:ContentControl runat="server">
                                                <div class="row marginTop20">
                                                    <div class="col-md-12">
                                                        <dx:ASPxButton ID="ASPxButton6" AutoPostBack="false" runat="server" CssClass="btn btn-primary" Text="Export">
                                                            <ClientSideEvents Click="function(s, e) {  ImageExcelCallbackPanel2.PerformCallback(); }"></ClientSideEvents>
                                                        </dx:ASPxButton>
                                                        <dx:ASPxCallbackPanel runat="server" ID="ImageExcelCallbackPanel2" Style="margin-right: 10px; margin-top: 5px;" ClientInstanceName="ImageExcelCallbackPanel2"
                                                            OnCallback="ImageExcelCallbackPanel2_Callback" SettingsLoadingPanel-Text="Exporting Data, please wait.">
                                                            <PanelCollection>
                                                                <dx:PanelContent ID="PanelContent3" runat="server">
                                                                    <asp:HyperLink ID="hplexcel2" runat="server"></asp:HyperLink>
                                                                </dx:PanelContent>
                                                            </PanelCollection>
                                                        </dx:ASPxCallbackPanel>
                                                        <dx:ASPxPivotGrid ID="gvtargetshopAmt" runat="server"
                                                            DataSourceID="odstargetAmt" Width="100%" ClientIDMode="AutoID">
                                                            <Fields>
                                                                <dx:PivotGridField Area="ColumnArea" AreaIndex="0" FieldName="ProductName" ID="fieldProductAmt" SortMode="Custom">
                                                                    <CellStyle HorizontalAlign="Center"></CellStyle>
                                                                </dx:PivotGridField>
                                                                <dx:PivotGridField Area="ColumnArea" AreaIndex="1" FieldName="RangeSellout" ID="fieldRangeAmt">
                                                                    <CellStyle HorizontalAlign="Center"></CellStyle>
                                                                </dx:PivotGridField>
                                                                <dx:PivotGridField Area="RowArea" AreaIndex="0" FieldName="ShopCode" ID="fieldShopCodeAmt" Options-AllowExpand="False" />
                                                                <dx:PivotGridField Area="RowArea" AreaIndex="1" FieldName="ShopName" ID="fieldShopNameAmt" Options-AllowExpand="False" />
                                                                <dx:PivotGridField Area="DataArea" AreaIndex="0" FieldName="TargetAmt" ID="fieldTargetAmt" SummaryType="SUM">
                                                                    <CellStyle HorizontalAlign="Center"></CellStyle>
                                                                </dx:PivotGridField>
                                                            </Fields>
                                                            <OptionsView HorizontalScrollBarMode="Auto" ShowColumnGrandTotals="False" ShowRowTotals="False" ShowRowGrandTotals="False" />
                                                            <OptionsFilter NativeCheckBoxes="False" ShowOnlyAvailableItems="true" />
                                                        </dx:ASPxPivotGrid>
                                                        <asp:ObjectDataSource ID="odstargetAmt" runat="server" SelectMethod="getListAmt" TypeName="LogicTier.Controllers.TargetForOutletBL" DataObjectTypeName="LogicTier.Models.TargetForOutlet">
                                                            <SelectParameters>
                                                                <asp:Parameter Name="AccountId" Type="Int32" />
                                                                <asp:Parameter Name="shopCode" Type="String" />
                                                                <asp:Parameter Name="ActiveMonth" Type="Int32" />
                                                                <asp:Parameter Name="ActiveYear" Type="Int32" />
                                                            </SelectParameters>
                                                        </asp:ObjectDataSource>
                                                    </div>
                                                </div>
                                            </dx:ContentControl>
                                        </ContentCollection>
                                    </dx:TabPage>
                                </TabPages>
                            </dx:ASPxPageControl>
                        </dx:PanelContent>
                    </PanelCollection>
                </dx:ASPxCallbackPanel>
            </div>
        </div>
    </div>
    <dx:ASPxPopupControl ID="pcImport" runat="server" Width="320" CloseAction="CloseButton" CloseOnEscape="true" Modal="True"
        PopupHorizontalAlign="WindowCenter" PopupVerticalAlign="WindowCenter" ClientInstanceName="pcImport"
        HeaderText="Import Target Shop" AllowDragging="True" PopupAnimationType="None" EnableViewState="False" AutoUpdatePosition="true">
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
                                                <dx:ASPxUploadControl ID="UploadControl" runat="server" ClientInstanceName="uploadTshop"
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
                                                            <ClientSideEvents Click="function(s, e) { uploadTshop.UploadFile();}" />
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
    <dx:ASPxPopupControl ID="pcImport2" runat="server" Width="320" CloseAction="CloseButton" CloseOnEscape="true" Modal="True"
        PopupHorizontalAlign="WindowCenter" PopupVerticalAlign="WindowCenter" ClientInstanceName="pcImport2"
        HeaderText="Import Target SO" AllowDragging="True" PopupAnimationType="None" EnableViewState="False" AutoUpdatePosition="true">
        <ContentCollection>
            <dx:PopupControlContentControl runat="server">
                <dx:ASPxPanel ID="ASPxPanel2" runat="server" DefaultButton="btOK">
                    <PanelCollection>
                        <dx:PanelContent runat="server">
                            <dx:ASPxFormLayout runat="server" ID="ASPxFormLayout3" Width="100%" Height="100%">
                                <Items>
                                    <dx:LayoutItem ShowCaption="False">
                                        <LayoutItemNestedControlCollection>
                                            <dx:LayoutItemNestedControlContainer>
                                                <dx:ASPxUploadControl ID="ASPxUploadControl1" runat="server" ClientInstanceName="uploadTSO"
                                                    NullText="Bấm để chọn file excel..." OnFileUploadComplete="UploadControl2_FileUploadComplete">
                                                    <AdvancedModeSettings EnableMultiSelect="false" EnableDragAndDrop="true" />
                                                    <ValidationSettings MaxFileSize="4194304" AllowedFileExtensions=".xls, .xlsx" ShowErrors="false"></ValidationSettings>
                                                    <ClientSideEvents FileUploadComplete="function(s,e){ 
                                                    if (e.callbackData != '') {
                                                       alert(e.callbackData); pcImport2.Hide();
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
                                                        <dx:ASPxButton ID="ASPxButton8" runat="server" Text="Import" Width="80px" AutoPostBack="False" CssClass="btn btn-primary">
                                                            <ClientSideEvents Click="function(s, e) { uploadTSO.UploadFile();}" />
                                                        </dx:ASPxButton>
                                                        &nbsp;
                                                        <dx:ASPxButton ID="ASPxButton9" runat="server" Text="Cancel" Width="80px" AutoPostBack="False">
                                                            <ClientSideEvents Click="function(s, e) { pcImport2.Hide(); }" />
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
    <dx:ASPxPopupControl ID="pcImport3" runat="server" Width="320" CloseAction="CloseButton" CloseOnEscape="true" Modal="True"
        PopupHorizontalAlign="WindowCenter" PopupVerticalAlign="WindowCenter" ClientInstanceName="pcImport3"
        HeaderText="Import Shop Master" AllowDragging="True" PopupAnimationType="None" EnableViewState="False" AutoUpdatePosition="true">
        <ContentCollection>
            <dx:PopupControlContentControl runat="server">
                <dx:ASPxPanel ID="ASPxPanel3" runat="server" DefaultButton="btOK">
                    <PanelCollection>
                        <dx:PanelContent runat="server">
                            <dx:ASPxFormLayout runat="server" ID="ASPxFormLayout4" Width="100%" Height="100%">
                                <Items>
                                    <dx:LayoutItem ShowCaption="False">
                                        <LayoutItemNestedControlCollection>
                                            <dx:LayoutItemNestedControlContainer>
                                                <dx:ASPxUploadControl ID="ASPxUploadControl2" runat="server" ClientInstanceName="uploadSInfo"
                                                    NullText="Bấm để chọn file excel..." OnFileUploadComplete="UploadControl3_FileUploadComplete">
                                                    <AdvancedModeSettings EnableMultiSelect="false" EnableDragAndDrop="true" />
                                                    <ValidationSettings MaxFileSize="4194304" AllowedFileExtensions=".xls, .xlsx" ShowErrors="false"></ValidationSettings>
                                                    <ClientSideEvents FileUploadComplete="function(s,e){ 
                                                    if (e.callbackData != '') {
                                                       alert(e.callbackData); pcImport3.Hide();
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
                                                        <dx:ASPxButton ID="ASPxButton10" runat="server" Text="Import" Width="80px" AutoPostBack="False" CssClass="btn btn-primary">
                                                            <ClientSideEvents Click="function(s, e) { uploadSInfo.UploadFile();}" />
                                                        </dx:ASPxButton>
                                                        &nbsp;
                                                        <dx:ASPxButton ID="ASPxButton11" runat="server" Text="Cancel" Width="80px" AutoPostBack="False">
                                                            <ClientSideEvents Click="function(s, e) { pcImport3.Hide(); }" />
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

    <dx:ASPxPopupControl ID="pcImportDealer" 
        runat="server" Width="320" CloseAction="CloseButton" CloseOnEscape="true" Modal="True"
        PopupHorizontalAlign="WindowCenter" PopupVerticalAlign="WindowCenter" ClientInstanceName="pcImportDealer"
        HeaderText="Import Dealer Info" AllowDragging="True" PopupAnimationType="None" EnableViewState="False" AutoUpdatePosition="true">
        <ContentCollection>
            <dx:PopupControlContentControl runat="server">
                <dx:ASPxPanel ID="ASPxPanel4" runat="server" DefaultButton="btOK">
                    <PanelCollection>
                        <dx:PanelContent runat="server">
                            <dx:ASPxFormLayout runat="server" ID="ASPxFormLayout5" Width="100%" Height="100%">
                                <Items>
                                    <dx:LayoutItem ShowCaption="False">
                                        <LayoutItemNestedControlCollection>
                                            <dx:LayoutItemNestedControlContainer>
                                                <dx:ASPxUploadControl ID="UploadDealer" runat="server" 
                                                    ClientInstanceName="UploadDealer"
                                                    NullText="Bấm để chọn file excel..." 
                                                    OnFileUploadComplete="UploadDealer_FileUploadComplete">
                                                    <AdvancedModeSettings EnableMultiSelect="false" EnableDragAndDrop="true" />
                                                    <ValidationSettings MaxFileSize="4194304" AllowedFileExtensions=".xls, .xlsx" ShowErrors="false"></ValidationSettings>
                                                    <ClientSideEvents FileUploadComplete="function(s,e){ 
                                                    if (e.callbackData != '') {
                                                       alert(e.callbackData); pcImportDealer.Hide();
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
                                                        <dx:ASPxButton ID="ASPxButton13" runat="server" 
                                                            Text="Import" Width="80px" AutoPostBack="False" CssClass="btn btn-primary">
                                                            <ClientSideEvents Click="function(s, e) { UploadDealer.UploadFile();}" />
                                                        </dx:ASPxButton>
                                                        &nbsp;
                                                        <dx:ASPxButton ID="ASPxButton14" runat="server" Text="Cancel" Width="80px" AutoPostBack="False">
                                                            <ClientSideEvents Click="function(s, e) { pcImportDealer.Hide(); }" />
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
    <asp:ObjectDataSource ID="odsObject" runat="server" SelectMethod="getlist" TypeName="LogicTier.Controllers.ObjectDataBL" DataObjectTypeName="LogicTier.Models.ObjectData">
        <SelectParameters>
            <asp:Parameter Name="objId" Type="Int32" ConvertEmptyStringToNull="true" DefaultValue="" />
            <asp:Parameter Name="objType" Type="String" DefaultValue="Province" />
        </SelectParameters>
    </asp:ObjectDataSource>
    <dx:ASPxPopupControl ID="pcDelete" runat="server" Width="320" CloseAction="CloseButton" CloseOnEscape="true" Modal="True"
        PopupHorizontalAlign="WindowCenter" PopupVerticalAlign="WindowCenter" ClientInstanceName="pcDelete"
        HeaderText="Delete Target" AllowDragging="True" PopupAnimationType="None" EnableViewState="False" AutoUpdatePosition="true">
        <ContentCollection>
            <dx:PopupControlContentControl runat="server">
                <dx:ASPxPanel ID="ASPxPanel1" runat="server" DefaultButton="btOK">
                    <PanelCollection>
                        <dx:PanelContent runat="server">
                            <dx:ASPxFormLayout runat="server" ID="ASPxFormLayout2" Width="100%" Height="100%">
                                <Items>
                                    <dx:LayoutItem Caption="Month (*)">
                                        <LayoutItemNestedControlCollection>
                                            <dx:LayoutItemNestedControlContainer>
                                                <dx:ASPxComboBox runat="server" ID="cbMonthDelete" Width="100%" DataSourceID="odsMonthDelete" ValueField="MonthCycle" ValueType="System.String" NullText="--All--"
                                                    ClientInstanceName="cbMonthDelete" EnableCallbackMode="true" DropDownStyle="DropDownList">
                                                    <ClearButton DisplayMode="OnHover"></ClearButton>
                                                    <Columns>
                                                        <dx:ListBoxColumn FieldName="MonthCycle" Caption="Month" />
                                                    </Columns>
                                                </dx:ASPxComboBox>
                                                <asp:ObjectDataSource ID="odsMonthDelete" runat="server" SelectMethod="getMonth" TypeName="LogicTier.Controllers.TermController">
                                                    <SelectParameters>
                                                        <asp:Parameter Name="Id" Type="Int32" ConvertEmptyStringToNull="true" />
                                                    </SelectParameters>
                                                </asp:ObjectDataSource>
                                            </dx:LayoutItemNestedControlContainer>
                                        </LayoutItemNestedControlCollection>
                                    </dx:LayoutItem>
                                    <dx:LayoutItem Caption="Shop/Product (*)">
                                        <LayoutItemNestedControlCollection>
                                            <dx:LayoutItemNestedControlContainer>
                                                <dx:ASPxComboBox runat="server" ID="cbDelete" Width="100%" ValueType="System.Int32" NullText="--ALL--">
                                                    <Items>
                                                        <dx:ListEditItem Text="Target Shop" Value="1" />
                                                        <dx:ListEditItem Text="Target SaleOut" Value="2" />
                                                    </Items>
                                                    <ClearButton DisplayMode="OnHover"></ClearButton>
                                                </dx:ASPxComboBox>
                                            </dx:LayoutItemNestedControlContainer>
                                        </LayoutItemNestedControlCollection>
                                    </dx:LayoutItem>
                                    <dx:LayoutItem ShowCaption="False">
                                        <LayoutItemNestedControlCollection>
                                            <dx:LayoutItemNestedControlContainer>
                                                <div class="row marginTop20">
                                                    <div class="col-md-12 text-center">
                                                        <dx:ASPxButton ID="ASPxButton2" runat="server" Text="Delete" Width="80px" AutoPostBack="False" CssClass="btn btn-primary">
                                                            <ClientSideEvents Click="function(s, e) { if(confirm('Bạn có chắc chắn muốn xóa dữ liệu?')){cp.PerformCallback('delete');}}" />
                                                        </dx:ASPxButton>
                                                        &nbsp;
                                                        <dx:ASPxButton ID="ASPxButton3" runat="server" Text="Cancel" Width="80px" AutoPostBack="False">
                                                            <ClientSideEvents Click="function(s, e) { pcDelete.Hide(); }" />
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
    <dx:ASPxHiddenField ID="hdfKey" ClientInstanceName="hdfKey" runat="server"></dx:ASPxHiddenField>
</asp:Content>
