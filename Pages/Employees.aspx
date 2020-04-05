<%@ Page Title="Employee" Language="C#" MasterPageFile="~/Layout.master" AutoEventWireup="true" CodeBehind="Employees.aspx.cs" Inherits="WebApplication.Pages.Employees" %>

<%@ Register Assembly="DevExpress.Web.ASPxPivotGrid.v17.1, Version=17.1.6.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.ASPxPivotGrid" TagPrefix="dx" %>
<%@ Register Src="~/UserControls/ToolbarExport.ascx" TagPrefix="uc1" TagName="ToolbarExport" %>
<asp:Content ID="Content1" ContentPlaceHolderID="Content" runat="server">
    <style type="text/css">
        .templateTable {
            border-collapse: collapse;
            width: 100%;
        }

            .templateTable td {
                border: solid 1px #C2D4DA;
                padding: 6px;
            }

                .templateTable td.value {
                    font-weight: bold;
                }

        .imageCell {
            width: 160px;
        }
    </style>
    <script>
        function OnEndCallback(s, e) {
            if (s.cpAlert != '') {
                alert(s.cpAlert);
            }
        }
        function OnEndCallbackInner(s, e) {
            if (s.cpalert != '') {
                alert(s.cpalert);
            }
        }
        function OnEndCallbackempShop(s, e) {
            if (s.cpEmpShop != '') {
                alert(s.cpEmpShop);
            }
        }
        function gvEmpEndCallback(s, e) {
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
                        <dx:LayoutGroup Caption="Employees">
                            <Items>
                                <dx:LayoutItem ShowCaption="False">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer>
                                            <div class="row">
                                                <div class="col-md-3">
                                                    <label>Mã nhân viên</label>
                                                    <dx:ASPxButtonEdit runat="server" Width="100%" ID="fEmployeeCode">
                                                        <ClearButton DisplayMode="OnHover"></ClearButton>
                                                    </dx:ASPxButtonEdit>
                                                </div>
                                                <div class="col-md-3">
                                                    <label>Họ Tên</label>
                                                    <dx:ASPxButtonEdit runat="server" Width="100%" ID="txtFulname">
                                                        <ClearButton DisplayMode="OnHover"></ClearButton>
                                                    </dx:ASPxButtonEdit>
                                                </div>
                                                <div class="col-md-3">
                                                    <label>Chức vụ</label>
                                                    <dx:ASPxComboBox runat="server" ID="fPosition" Width="100%" TextField="Position" ValueField="Position"
                                                        ValueType="System.String" DropDownStyle="DropDownList">
                                                        <Items>
                                                            <dx:ListEditItem Value="Admin" Text="Admin" />
                                                            <dx:ListEditItem Value="PM" Text="Project Manager" />
                                                            <dx:ListEditItem Value="Sup" Text="Supervisor" />
                                                            <dx:ListEditItem Value="PC" Text="PC" />
                                                        </Items>
                                                        <ClearButton DisplayMode="OnHover"></ClearButton>
                                                        <ClientSideEvents SelectedIndexChanged="function(s, e) { 
                                                    fParentId.PerformCallback(s.GetValue());}" />
                                                    </dx:ASPxComboBox>
                                                </div>
                                                <div class="col-md-3">
                                                    <label>Quản lý cấp trên</label>
                                                    <dx:ASPxComboBox runat="server" ID="fParentId" Width="100%" ClientInstanceName="fParentId" TextField="EmployeeName"
                                                        ValueField="EmployeeId" ValueType="System.Int32" EnableCallbackMode="true" CallbackPageSize="10"
                                                        DropDownStyle="DropDownList" DataSourceID="fodsParent"
                                                        OnCallback="fParentId_Callback">
                                                        <ClearButton DisplayMode="OnHover"></ClearButton>
                                                    </dx:ASPxComboBox>
                                                    <asp:ObjectDataSource runat="server" ID="fodsParent" SelectMethod="getParentbyPosition" TypeName="LogicTier.Controllers.EmployeeBL">
                                                        <SelectParameters>
                                                            <asp:Parameter Name="position" Type="String" />
                                                        </SelectParameters>
                                                    </asp:ObjectDataSource>
                                                </div>
                                            </div>
                                            <div class="row marginTop20">
                                                <div class="col-md-3">
                                                    <label>Month/target incentive</label>
                                                    <dx:ASPxDateEdit runat="server" ID="txtmonthtargetDate" Width="100%" DisplayFormatString="yyyy-MM"
                                                        EditFormat="Custom" EditFormatString="yyyy-MM" OnInit="txtmonthtargetDate_Init">
                                                        <ClearButton DisplayMode="OnHover"></ClearButton>
                                                        <ClientSideEvents Init="OnInit" DropDown="OnDropDown" />
                                                    </dx:ASPxDateEdit>
                                                </div>
                                                <div class="col-md-3">
                                                    <label>Lọc NV</label>
                                                    <dx:ASPxRadioButtonList ID="OptionRadioButtonList" Width="100%" runat="server" Paddings-PaddingLeft="1" Paddings-PaddingRight="1" Paddings-PaddingBottom="1" Paddings-PaddingTop="1" RepeatColumns="2"
                                                        RepeatLayout="UnorderedList">
                                                        <Items>
                                                            <dx:ListEditItem Selected="true" Text="Tất cả NV" Value="0" />
                                                            <dx:ListEditItem Text="NV còn làm việc" Value="-1" />
                                                        </Items>
                                                    </dx:ASPxRadioButtonList>
                                                </div>
                                                <div class="col-md-6">
                                                    <label style="color: white">Tool</label><br />
                                                    <dx:ASPxButton ID="FilterButton" AutoPostBack="false" CssClass="btn btn-primary" runat="server" Text="Tìm kiếm">
                                                        <ClientSideEvents Click="function(s, e) {  cp.PerformCallback('filter'); }"></ClientSideEvents>
                                                    </dx:ASPxButton>
                                                    <dx:ASPxButton ID="btImport" AutoPostBack="false" runat="server" Text="Import" CssClass="btn btn-warning">
                                                        <ClientSideEvents Click="function(s, e) { pcImport.Show(); }" />
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
        <div class="row marginTop20">
            <div class="col-md-12">
                <dx:ASPxCallbackPanel ID="ASPxCallbackPanel1" runat="server" Width="100%"
                    ClientInstanceName="cp" OnCallback="ASPxCallbackPanel1_Callback">
                    <ClientSideEvents EndCallback="OnEndCallback" />
                    <PanelCollection>
                        <dx:PanelContent runat="server">
                            <dx:ASPxPageControl ID="ASPxPageControl1" runat="server" ActiveTabIndex="0" Width="100%">
                                <TabPages>
                                    <dx:TabPage Text="Danh sách nhân viên">
                                        <ContentCollection>
                                            <dx:ContentControl runat="server">
                                                <asp:HiddenField ID="hfaccid" runat="server" />
                                                <asp:HiddenField ID="hfaccname" runat="server" />
                                                <div class="row">
                                                    <div class="col-md-10">
                                                        <uc1:ToolbarExport runat="server" ID="ToolbarExport1" OnItemClick="ToolbarExport1_ItemClick" />
                                                        <dx:ASPxGridViewExporter ID="ASPxGridViewExporter1" runat="server" ExportSelectedRowsOnly="true" GridViewID="gvEmployee"
                                                            OnRenderBrick="ASPxGridViewExporter1_RenderBrick">
                                                        </dx:ASPxGridViewExporter>
                                                    </div>
                                                    <div class="col-md-2 text-right" style="padding-right: 30px; color: orangered; font-weight: 600">
                                                        <asp:Label ID="lbcode" runat="server" Text=""></asp:Label>
                                                    </div>
                                                </div>
                                                <div class="col-md-12">
                                                    <table class="OptionsBottomMargin">
                                                        <tr>
                                                            <td style="padding-right: 4px">
                                                                <dx:ASPxButton ID="btnSelectAll" runat="server" Text="Chọn tất cả" UseSubmitBehavior="False"
                                                                    AutoPostBack="false">
                                                                    <ClientSideEvents Click="function(s, e) { gvEmployee.SelectRows(); }" />
                                                                </dx:ASPxButton>
                                                            </td>
                                                            <td style="padding-right: 4px">
                                                                <dx:ASPxButton ID="btnSelectAllOnPage" runat="server" Text="Chọn 1 trang"
                                                                    UseSubmitBehavior="False" AutoPostBack="false">
                                                                    <ClientSideEvents Click="function(s, e) { gvEmployee.SelectAllRowsOnPage(); }" />
                                                                </dx:ASPxButton>
                                                            </td>
                                                            <td style="padding-right: 4px">
                                                                <dx:ASPxButton ID="btnUnselectAll" runat="server" Text="Bỏ chọn" UseSubmitBehavior="False"
                                                                    AutoPostBack="false">
                                                                    <ClientSideEvents Click="function(s, e) { gvEmployee.UnselectRows(); gvEmployee.UnselectAllRowsOnPage(); }" />
                                                                </dx:ASPxButton>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </div>
                                                <div class="col-md-12 marginTop20">
                                                    <dx:ASPxGridView runat="server" AutoGenerateColumns="False" ID="gvEmployee" ClientInstanceName="gvEmployee" Width="100%"
                                                        KeyFieldName="EmployeeId" OnLoad="gvEmployee_Load"
                                                        OnRowInserting="gvEmployee_RowInserting"
                                                        OnRowUpdating="gvEmployee_RowUpdating"
                                                        OnRowDeleting="gvEmployee_RowDeleting" DataSourceID="odsEmployee">
                                                        <ClientSideEvents EndCallback="gvEmpEndCallback" />
                                                        <SettingsCommandButton>
                                                            <DeleteButton Text="Delete"></DeleteButton>
                                                            <EditButton Text="Edit"></EditButton>
                                                        </SettingsCommandButton>
                                                        <SettingsBehavior ConfirmDelete="true" AllowFocusedRow="True" />
                                                        <SettingsText ConfirmDelete="Bạn có muốn xóa không?" />
                                                        <SettingsEditing EditFormColumnCount="3" />
                                                        <Settings ShowPreview="true" />
                                                        <SettingsPager PageSize="10" EnableAdaptivity="true" />
                                                        <Styles Header-Wrap="True">
                                                            <Header Wrap="True"></Header>
                                                            <AlternatingRow Enabled="true" />
                                                        </Styles>
                                                        <SettingsDetail ShowDetailRow="True" AllowOnlyOneMasterRowExpanded="True" />
                                                        <ClientSideEvents RowClick="function(s, e) {s.ExpandDetailRow(s.GetFocusedRowIndex());}" />
                                                        <Templates>
                                                            <DetailRow>
                                                                <div class="row">
                                                                    <div class="col-md-3">
                                                                        <dx:ASPxBinaryImage ID="ASPxBinaryImage2" runat="server" 
                                                                            Value='<%# Eval("Pic") %>' Height="150" Width="150" />
                                                                    </div>
                                                                    <div class="col-md-9">
                                                                        <div class="row">
                                                                            <div class="col-md-3 text-right">
                                                                                <label class="dxflCaption_Moderno">
                                                                                    Ngân hàng
                                                                                </label>
                                                                            </div>
                                                                            <div class="col-md-3">
                                                                                <dx:ASPxLabel ID="lblBankName" runat="server" Text='<%# Eval("BankName") %>' />
                                                                            </div>
                                                                            <div class="col-md-3 text-right">
                                                                                <label class="dxflCaption_Moderno">
                                                                                    Số TK
                                                                                </label>
                                                                            </div>
                                                                            <div class="col-md-3">
                                                                                <dx:ASPxLabel ID="lblAccountBank" runat="server" Text='<%# Eval("AccountBank") %>' />
                                                                            </div>
                                                                        </div>
                                                                        <div class="row">
                                                                            <div class="col-md-3 text-right">
                                                                                <label class="dxflCaption_Moderno">
                                                                                    Chi nhánh
                                                                                </label>
                                                                            </div>
                                                                            <div class="col-md-3">
                                                                                <dx:ASPxLabel ID="lblBankBrand" runat="server" Text='<%# Eval("BankBrand") %>' />
                                                                            </div>
                                                                            <div class="col-md-3 text-right">
                                                                                <label class="dxflCaption_Moderno">
                                                                                    Ngày Sinh
                                                                                </label>
                                                                            </div>
                                                                            <div class="col-md-3">
                                                                                <dx:ASPxLabel ID="lblBirthDay" runat="server" Text='<%# Eval("BirthDay", "{0:yyyy-MM-dd}") %>' />
                                                                            </div>
                                                                        </div>
                                                                        <div class="row">
                                                                            <div class="col-md-3 text-right">
                                                                                <label class="dxflCaption_Moderno">
                                                                                    Email
                                                                                </label>
                                                                            </div>
                                                                            <div class="col-md-3">
                                                                                <dx:ASPxLabel ID="lblEmail" runat="server" Text='<%# Eval("Email") %>' />
                                                                            </div>
                                                                            <div class="col-md-3 text-right">
                                                                                <label class="dxflCaption_Moderno">
                                                                                    Mobile
                                                                                </label>
                                                                            </div>
                                                                            <div class="col-md-3">
                                                                                <dx:ASPxLabel ID="lblMobile" runat="server" Text='<%# Eval("Mobile") %>' />
                                                                            </div>
                                                                        </div>
                                                                        <div class="row">
                                                                            <div class="col-md-3 text-right">
                                                                                <label class="dxflCaption_Moderno">
                                                                                    CMND
                                                                                </label>
                                                                            </div>
                                                                            <div class="col-md-3">
                                                                                <dx:ASPxLabel ID="lblIdNumber" runat="server" Text='<%# Eval("IdNumber") %>' />
                                                                            </div>
                                                                            <div class="col-md-3 text-right">
                                                                                <label class="dxflCaption_Moderno">
                                                                                    Ngày cấp
                                                                                </label>
                                                                            </div>
                                                                            <div class="col-md-3">
                                                                                <dx:ASPxLabel ID="lblIdDate" runat="server" Text='<%# Eval("IdDate", "{0:yyyy-MM-dd}") %>' />
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </DetailRow>
                                                            <EditForm>
                                                                <dx:ASPxPageControl ID="ASPxPageControl1" runat="server" ActiveTabIndex="0" Width="100%">
                                                                    <TabPages>
                                                                        <dx:TabPage Text="Thông tin Cơ bản">
                                                                            <ContentCollection>
                                                                                <dx:ContentControl runat="server">
                                                                                    <dx:ASPxGridViewTemplateReplacement runat="server" ReplacementType="EditFormEditors" />
                                                                                </dx:ContentControl>
                                                                            </ContentCollection>
                                                                        </dx:TabPage>
                                                                        <dx:TabPage Text="Thông tin khác">
                                                                            <ContentCollection>
                                                                                <dx:ContentControl runat="server">
                                                                                    <div class="col-md-6">
                                                                                        <h5 style="color: #337ab7;">Thông tin hoạt động</h5>
                                                                                        <div class="row">
                                                                                            <dx:ASPxGridView runat="server" ID="gvActivity" ClientInstanceName="gvActivity" AutoGenerateColumns="false" Width="100%"
                                                                                                KeyFieldName="ActivityId" DataSourceID="odsActivity" OnBeforePerformDataSelect="gvActivity_BeforePerformDataSelect"
                                                                                                OnRowInserting="gvActivity_RowInserting" OnRowUpdating="gvActivity_RowUpdating" OnRowDeleting="gvActivity_RowDeleting">
                                                                                                <SettingsCommandButton>
                                                                                                    <DeleteButton Text="Delete"></DeleteButton>
                                                                                                </SettingsCommandButton>
                                                                                                <SettingsBehavior ConfirmDelete="true" AllowFocusedRow="True" />
                                                                                                <SettingsText ConfirmDelete="Bạn có muốn xóa không?" />
                                                                                                <SettingsEditing EditFormColumnCount="1" />
                                                                                                <Styles Header-Wrap="True">
                                                                                                    <Header Wrap="True"></Header>
                                                                                                </Styles>
                                                                                                <Columns>
                                                                                                    <dx:GridViewDataColumn FieldName="ActivityType" Caption="Loại hành động" VisibleIndex="0">
                                                                                                        <DataItemTemplate>
                                                                                                            <dx:ASPxLabel runat="server" ID="lbActivityType" Text='<%# Bind("Noted") %>'></dx:ASPxLabel>
                                                                                                        </DataItemTemplate>
                                                                                                        <EditItemTemplate>
                                                                                                            <dx:ASPxComboBox runat="server" ID="eActivityType" ClientInstanceName="eActivityType"
                                                                                                                TextField="Noted" ValueField="ActivityType" ValueType="System.String" Value='<%#Eval("ActivityType") %>'
                                                                                                                Width="100%">
                                                                                                                <Items>
                                                                                                                    <dx:ListEditItem Text="Ngày vào làm" Value="HireDate" />
                                                                                                                    <dx:ListEditItem Text="Nghỉ phép" Value="Absent" />
                                                                                                                    <dx:ListEditItem Text="Nghỉ việc" Value="DayOff" />
                                                                                                                </Items>
                                                                                                            </dx:ASPxComboBox>
                                                                                                        </EditItemTemplate>
                                                                                                    </dx:GridViewDataColumn>
                                                                                                    <dx:GridViewDataDateColumn FieldName="ActivityDate" Caption="Ngày hiệu lực" VisibleIndex="1">
                                                                                                        <PropertiesDateEdit DisplayFormatString="yyyy-MM-dd" EditFormat="Custom" EditFormatString="yyyy-MM-dd"></PropertiesDateEdit>
                                                                                                    </dx:GridViewDataDateColumn>
                                                                                                    <dx:GridViewDataColumn FieldName="ActivityValue" Caption="Kiểu dữ liệu" VisibleIndex="2"></dx:GridViewDataColumn>
                                                                                                    <dx:GridViewCommandColumn ShowNewButtonInHeader="true" ShowDeleteButton="true" VisibleIndex="3">
                                                                                                    </dx:GridViewCommandColumn>
                                                                                                </Columns>
                                                                                            </dx:ASPxGridView>
                                                                                            <asp:ObjectDataSource runat="server" ID="odsActivity" DataObjectTypeName="LogicTier.Models.EmployeeActivity" DeleteMethod="Delete" InsertMethod="Insert" SelectMethod="getByEmployeeId" TypeName="LogicTier.Controllers.EmployeeActivityBL" UpdateMethod="Update">
                                                                                                <SelectParameters>
                                                                                                    <asp:SessionParameter Name="EmpId" SessionField="empActId" Type="Int32" />
                                                                                                </SelectParameters>
                                                                                            </asp:ObjectDataSource>
                                                                                        </div>
                                                                                        <div class="row marginTop20">
                                                                                            <dx:ASPxGridView runat="server" ID="gvEmpShop" ClientInstanceName="gvEmpShop" AutoGenerateColumns="false"
                                                                                                KeyFieldName="EmployeeId;ShopId;ActiveDate" OnBeforePerformDataSelect="gvEmpShop_BeforePerformDataSelect"
                                                                                                OnRowInserting="gvEmpShop_RowInserting" OnLoad="gvEmpShop_Load"
                                                                                                OnRowDeleting="gvEmpShop_RowDeleting" DataSourceID="odsEmpShop" Width="100%">
                                                                                                <ClientSideEvents EndCallback="OnEndCallbackempShop" />
                                                                                                <SettingsCommandButton>
                                                                                                    <DeleteButton Text="Delete"></DeleteButton>
                                                                                                </SettingsCommandButton>
                                                                                                <SettingsBehavior ConfirmDelete="true" AllowFocusedRow="True" />
                                                                                                <SettingsText ConfirmDelete="Bạn có muốn xóa không?" />
                                                                                                <SettingsEditing EditFormColumnCount="1" />
                                                                                                <Styles Header-Wrap="True">
                                                                                                    <Header Wrap="True"></Header>
                                                                                                </Styles>
                                                                                                <Columns>
                                                                                                    <dx:GridViewDataDateColumn FieldName="CatName" Caption="Ngành hàng" VisibleIndex="0">
                                                                                                        <EditItemTemplate>
                                                                                                            <dx:ASPxComboBox runat="server" ID="cbCat" NullText="Choose Cat" ValueType="System.Int32" ValueField="CatId"
                                                                                                                ClientInstanceName="cbCat">
                                                                                                                <ClearButton DisplayMode="OnHover"></ClearButton>
                                                                                                                <Items>
                                                                                                                    <dx:ListEditItem Value="0" Text="All" />
                                                                                                                    <dx:ListEditItem Value="1" Text="HA" />
                                                                                                                    <dx:ListEditItem Value="2" Text="SHA" />
                                                                                                                </Items>
                                                                                                            </dx:ASPxComboBox>
                                                                                                        </EditItemTemplate>
                                                                                                    </dx:GridViewDataDateColumn>
                                                                                                    <dx:GridViewDataDateColumn FieldName="ActiveDate" Caption="Ngày hiệu lực" VisibleIndex="1">
                                                                                                        <PropertiesDateEdit DisplayFormatString="yyyy-MM-dd"></PropertiesDateEdit>
                                                                                                        <EditItemTemplate>
                                                                                                            <dx:ASPxDateEdit runat="server" ID="eActiveDate" DisplayFormatString="yyyy-MM-dd" EditFormat="Custom" EditFormatString="yyyy-MM-dd"
                                                                                                                ValidationSettings-ValidationGroup="<%# Container.ValidationGroup %>">
                                                                                                                <ValidationSettings Display="Dynamic" ErrorDisplayMode="Text" ErrorTextPosition="Bottom">
                                                                                                                    <RequiredField IsRequired="true" ErrorText="Bạn chưa chọn Ngày hiệu lực." />
                                                                                                                </ValidationSettings>
                                                                                                            </dx:ASPxDateEdit>
                                                                                                        </EditItemTemplate>
                                                                                                    </dx:GridViewDataDateColumn>
                                                                                                    <dx:GridViewDataColumn FieldName="ShopName" Caption="Cửa hàng" VisibleIndex="2">
                                                                                                        <EditItemTemplate>
                                                                                                            <div class="row">
                                                                                                                <div class="col-md-6">
                                                                                                                    <dx:ASPxComboBox runat="server" ID="cbCity"
                                                                                                                        ValueType="System.String" NullText="Choose to filter by City" ValueField="City"
                                                                                                                        ClientInstanceName="cbCity" DataSourceID="odsCity">
                                                                                                                        <ClearButton DisplayMode="OnHover"></ClearButton>
                                                                                                                        <ClientSideEvents SelectedIndexChanged="function(s,e){eShopList.PerformCallback(cbAccount.GetValue()+';'+s.GetValue());}" />
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
                                                                                                                <div class="col-md-6">
                                                                                                                    <dx:ASPxComboBox runat="server" ID="cbAccount" ValueType="System.Int32" NullText="Choose to select Account Group"
                                                                                                                        DataSourceID="odsAccount" TextField="Account" ValueField="ObjectId"
                                                                                                                        ClientInstanceName="cbAccount" CallbackPageSize="10">
                                                                                                                        <ClientSideEvents SelectedIndexChanged="function(s,e){eShopList.PerformCallback(s.GetValue()+';'+cbCity.GetValue());}" />
                                                                                                                        <ClearButton DisplayMode="OnHover"></ClearButton>
                                                                                                                    </dx:ASPxComboBox>
                                                                                                                    <asp:ObjectDataSource ID="odsAccount" runat="server" SelectMethod="getAccountGroup" TypeName="LogicTier.Controllers.SaleOutBL"></asp:ObjectDataSource>
                                                                                                                </div>
                                                                                                            </div>
                                                                                                            <div class="row" style="margin-top: 5px;">
                                                                                                                <div class="col-md-12">
                                                                                                                    <dx:ASPxComboBox runat="server" ID="eShopList" ValueField="ShopId"
                                                                                                                        ValueType="System.Int32" NullText="Choose the Outlets" OnCallback="ShopList_Callback"
                                                                                                                        ClientInstanceName="eShopList" CallbackPageSize="10" DataSourceID="obsgetOutlet">
                                                                                                                        <ClearButton DisplayMode="OnHover"></ClearButton>
                                                                                                                        <ValidationSettings Display="Dynamic" ErrorDisplayMode="Text" ErrorTextPosition="Bottom">
                                                                                                                            <RequiredField IsRequired="true" ErrorText="Please choose Outlet to set." />
                                                                                                                        </ValidationSettings>
                                                                                                                        <Columns>
                                                                                                                            <dx:ListBoxColumn FieldName="ShopName" Width="250px" />
                                                                                                                            <dx:ListBoxColumn FieldName="Account" />
                                                                                                                        </Columns>
                                                                                                                    </dx:ASPxComboBox>
                                                                                                                </div>
                                                                                                            </div>
                                                                                                        </EditItemTemplate>
                                                                                                    </dx:GridViewDataColumn>
                                                                                                    <dx:GridViewCommandColumn ShowNewButtonInHeader="true" ShowDeleteButton="true" VisibleIndex="2">
                                                                                                    </dx:GridViewCommandColumn>
                                                                                                </Columns>
                                                                                            </dx:ASPxGridView>
                                                                                            <asp:ObjectDataSource runat="server" ID="odsEmpShop" SelectMethod="getList" TypeName="LogicTier.Controllers.EmployeeByShopBL" DataObjectTypeName="LogicTier.Models.EmployeeByShop" DeleteMethod="Delete" InsertMethod="Insert">
                                                                                                <DeleteParameters>
                                                                                                    <asp:Parameter Name="shopId" Type="Int32" />
                                                                                                    <asp:Parameter Name="empId" Type="Int32" />
                                                                                                    <asp:Parameter Name="acDate" Type="String" />
                                                                                                </DeleteParameters>
                                                                                                <SelectParameters>
                                                                                                    <asp:SessionParameter Name="EmpId" SessionField="empShopId" Type="Int32" />
                                                                                                </SelectParameters>
                                                                                            </asp:ObjectDataSource>
                                                                                        </div>
                                                                                    </div>
                                                                                    <div class="col-md-6">
                                                                                        <h5 style="color: #337ab7;">Thông tin Tài khoản</h5>
                                                                                        <dx:ASPxFormLayout runat="server" ID="ASPxFormLayout1" ClientInstanceName="ASPxFormLayout1" Width="100%"
                                                                                            RequiredMarkDisplayMode="RequiredOnly" EnableViewState="false" EncodeHtml="false">
                                                                                            <Items>
                                                                                                <dx:LayoutGroup ShowCaption="False" SettingsItemHelpTexts-Position="Bottom">
                                                                                                    <Items>
                                                                                                        <dx:LayoutItem Caption="Tài khoản" HelpText="Bạn chưa nhập Tài khoản.">
                                                                                                            <LayoutItemNestedControlCollection>
                                                                                                                <dx:LayoutItemNestedControlContainer>
                                                                                                                    <dx:ASPxTextBox runat="server" ID="eUserName" ClientInstanceName="eUserName" Width="100%" Text='<%# Bind("UserName") %>'>
                                                                                                                        <ValidationSettings RequiredField-IsRequired="true" Display="Dynamic" ErrorDisplayMode="Text">
                                                                                                                            <RequiredField IsRequired="True" />
                                                                                                                        </ValidationSettings>
                                                                                                                    </dx:ASPxTextBox>
                                                                                                                    <asp:HiddenField ID="hdfolduser" Value='<%# Bind("UserName") %>' runat="server" />
                                                                                                                </dx:LayoutItemNestedControlContainer>
                                                                                                            </LayoutItemNestedControlCollection>
                                                                                                        </dx:LayoutItem>
                                                                                                        <dx:LayoutItem Caption="Mật khẩu" HelpText="Bạn chưa nhập Mật khẩu.">
                                                                                                            <LayoutItemNestedControlCollection>
                                                                                                                <dx:LayoutItemNestedControlContainer>
                                                                                                                    <dx:ASPxTextBox runat="server" ID="ePassword" ClientInstanceName="ePassword" Width="100%" Password="True">
                                                                                                                        <ValidationSettings RequiredField-IsRequired="true" Display="Dynamic" ErrorDisplayMode="Text">
                                                                                                                            <RequiredField IsRequired="True" />
                                                                                                                        </ValidationSettings>
                                                                                                                    </dx:ASPxTextBox>
                                                                                                                </dx:LayoutItemNestedControlContainer>
                                                                                                            </LayoutItemNestedControlCollection>
                                                                                                        </dx:LayoutItem>
                                                                                                        <dx:LayoutItem Caption="Nhập lại mật khẩu" HelpText="Bạn chưa nhập lại mật khẩu.">
                                                                                                            <LayoutItemNestedControlCollection>
                                                                                                                <dx:LayoutItemNestedControlContainer>
                                                                                                                    <dx:ASPxTextBox runat="server" ID="eConfirm" ClientInstanceName="eConfirm" Width="100%" Password="True">
                                                                                                                        <ValidationSettings RequiredField-IsRequired="true" Display="Dynamic" ErrorDisplayMode="Text" ErrorText="The password is incorrect">
                                                                                                                            <RequiredField IsRequired="True" />
                                                                                                                        </ValidationSettings>
                                                                                                                    </dx:ASPxTextBox>
                                                                                                                </dx:LayoutItemNestedControlContainer>
                                                                                                            </LayoutItemNestedControlCollection>
                                                                                                        </dx:LayoutItem>
                                                                                                        <dx:LayoutItem ShowCaption="false" RequiredMarkDisplayMode="Hidden" HorizontalAlign="Right">
                                                                                                            <LayoutItemNestedControlCollection>
                                                                                                                <dx:LayoutItemNestedControlContainer>
                                                                                                                    <dx:ASPxButton runat="server" ID="submitAccount" Text="Update User"
                                                                                                                        AutoPostBack="false">
                                                                                                                        <ClientSideEvents Click="function(s,e){
                                                                                                    cp.PerformCallback('CreateUser');
                                                                                                }" />
                                                                                                                    </dx:ASPxButton>
                                                                                                                </dx:LayoutItemNestedControlContainer>
                                                                                                            </LayoutItemNestedControlCollection>
                                                                                                        </dx:LayoutItem>
                                                                                                    </Items>
                                                                                                    <SettingsItemHelpTexts Position="Bottom" />
                                                                                                </dx:LayoutGroup>
                                                                                            </Items>
                                                                                        </dx:ASPxFormLayout>
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
                                                            <dx:GridViewDataBinaryImageColumn VisibleIndex="1" Visible="false">
                                                                <EditFormSettings VisibleIndex="0" RowSpan="4" Visible="True" />
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
                                                            <dx:GridViewDataTextColumn FieldName="EmployeeCode" Caption="Mã nhân viên" VisibleIndex="3">
                                                                <EditFormSettings VisibleIndex="1" Visible="True" />
                                                                <EditItemTemplate>
                                                                    <dx:ASPxTextBox runat="server" ID="eEmployeeCode" Text='<%# Eval("EmployeeCode") %>' ValidationSettings-ValidationGroup="<%# Container.ValidationGroup %>">
                                                                        <ValidationSettings Display="Dynamic" ErrorDisplayMode="Text" ErrorTextPosition="Bottom">
                                                                            <RequiredField IsRequired="true" ErrorText="Bạn chưa nhập Mã nhân viên" />
                                                                        </ValidationSettings>
                                                                    </dx:ASPxTextBox>
                                                                </EditItemTemplate>
                                                            </dx:GridViewDataTextColumn>
                                                            <dx:GridViewDataTextColumn FieldName="EmployeeName" Caption="Tên nhân viên" VisibleIndex="4">
                                                                <EditFormSettings VisibleIndex="2" Visible="True" />
                                                                <PropertiesTextEdit>
                                                                    <ValidationSettings Display="Dynamic" ErrorDisplayMode="Text" ErrorTextPosition="Bottom">
                                                                        <RequiredField IsRequired="true" ErrorText="Bạn chưa nhập Tên nhân viên." />
                                                                    </ValidationSettings>
                                                                </PropertiesTextEdit>
                                                            </dx:GridViewDataTextColumn>
                                                            <dx:GridViewDataTextColumn Caption="Tình trạng" FieldName="WorkStatus" VisibleIndex="5">
                                                                <EditFormSettings Visible="False" />
                                                            </dx:GridViewDataTextColumn>
                                                            <dx:GridViewDataComboBoxColumn FieldName="Position" Caption="Chức vụ" VisibleIndex="6">
                                                                <EditFormSettings VisibleIndex="3" Visible="True" />
                                                                <PropertiesComboBox ValueField="Position" ClientInstanceName="cmbPosition"
                                                                    TextField="Position" ValueType="System.String" DropDownStyle="DropDownList">
                                                                    <Items>
                                                                        <dx:ListEditItem Value="Admin" Text="Admin" />
                                                                        <dx:ListEditItem Value="PM" Text="Project Manager" />
                                                                        <dx:ListEditItem Value="Sup" Text="Supervisor" />
                                                                        <dx:ListEditItem Value="PC" Text="PC" />
                                                                    </Items>
                                                                    <ClientSideEvents
                                                                        SelectedIndexChanged="function(s, e) { 
                                                    cmbParentName.PerformCallback('select'+';'+s.GetValue());}" />
                                                                    <ValidationSettings Display="Dynamic" ErrorDisplayMode="Text" ErrorTextPosition="Bottom">
                                                                        <RequiredField IsRequired="true" ErrorText="Bạn chưa nhập Chức vụ." />
                                                                    </ValidationSettings>
                                                                </PropertiesComboBox>
                                                            </dx:GridViewDataComboBoxColumn>
                                                            <dx:GridViewDataComboBoxColumn FieldName="Sex" Caption="Giới tính" VisibleIndex="7">
                                                                <PropertiesComboBox ValueField="Sex" ClientInstanceName="cmSex"
                                                                    ValueType="System.Int32" DropDownStyle="DropDownList">
                                                                    <Items>
                                                                        <dx:ListEditItem Text="F" Value="0" />
                                                                        <dx:ListEditItem Text="M" Value="1" />
                                                                    </Items>
                                                                </PropertiesComboBox>
                                                                <EditItemTemplate>
                                                                    <dx:ASPxRadioButtonList ID="radioButtonList" runat="server" SelectedIndex='<%# Convert.ToInt32( Eval("Sex")) %>' Paddings-PaddingLeft="1" Paddings-PaddingRight="1" Paddings-PaddingBottom="1" Paddings-PaddingTop="1" RepeatColumns="2">
                                                                        <Items>
                                                                            <dx:ListEditItem Text="F" Value="0" />
                                                                            <dx:ListEditItem Text="M" Value="1" />
                                                                        </Items>
                                                                    </dx:ASPxRadioButtonList>
                                                                </EditItemTemplate>
                                                            </dx:GridViewDataComboBoxColumn>
                                                            <dx:GridViewDataDateColumn FieldName="BirthDay" Caption="Ngày sinh" VisibleIndex="8" Visible="false">
                                                                <EditFormSettings VisibleIndex="5" Visible="True" />
                                                                <PropertiesDateEdit DisplayFormatString="yyyy-MM-dd" EditFormat="Custom" EditFormatString="yyyy-MM-dd">
                                                                </PropertiesDateEdit>
                                                            </dx:GridViewDataDateColumn>
                                                            <dx:GridViewDataTextColumn FieldName="IdNumber" Caption="CMND" VisibleIndex="9" Visible="false">
                                                                <EditFormSettings VisibleIndex="6" Visible="True" />
                                                                <EditItemTemplate>
                                                                    <dx:ASPxTextBox runat="server" ID="pIdNumber" ClientInstanceName="pIdNumber" Text='<%# Eval("IdNumber") %>'
                                                                        ValidationSettings-ValidationGroup="<%# Container.ValidationGroup %>">
                                                                        <ValidationSettings Display="Dynamic" ErrorDisplayMode="Text" ErrorTextPosition="Bottom">
                                                                            <RequiredField IsRequired="true" ErrorText="Bạn chưa nhập CMND." />
                                                                        </ValidationSettings>
                                                                        <ClientSideEvents TextChanged="function(s,e){eConfirm.SetText(s.GetText());ePassword.SetText(s.GetText());}" />
                                                                    </dx:ASPxTextBox>
                                                                </EditItemTemplate>
                                                            </dx:GridViewDataTextColumn>
                                                            <dx:GridViewDataDateColumn FieldName="IdDate" Caption="Ngày cấp CMND" VisibleIndex="10" Visible="false">
                                                                <EditFormSettings VisibleIndex="7" Visible="True" />
                                                                <PropertiesDateEdit DisplayFormatString="yyyy-MM-dd" EditFormat="Custom" EditFormatString="yyyy-MM-dd">
                                                                </PropertiesDateEdit>
                                                            </dx:GridViewDataDateColumn>
                                                            <dx:GridViewDataTextColumn FieldName="IdPlace" Caption="Nơi cấp CMND" VisibleIndex="11" Visible="false">
                                                                <EditFormSettings VisibleIndex="8" Visible="True" />
                                                                <PropertiesTextEdit>
                                                                </PropertiesTextEdit>
                                                            </dx:GridViewDataTextColumn>
                                                            <dx:GridViewDataTextColumn FieldName="AccountBank" Caption="TK Ngân hàng" VisibleIndex="12" Visible="false">
                                                                <EditFormSettings VisibleIndex="9" Visible="True" />
                                                                <PropertiesTextEdit>
                                                                </PropertiesTextEdit>
                                                            </dx:GridViewDataTextColumn>
                                                            <dx:GridViewDataTextColumn FieldName="BankName" Caption="Ngân hàng" VisibleIndex="13" Visible="false">
                                                                <EditFormSettings VisibleIndex="11" Visible="True" />
                                                                <PropertiesTextEdit>
                                                                </PropertiesTextEdit>
                                                            </dx:GridViewDataTextColumn>
                                                            <dx:GridViewDataTextColumn FieldName="BankBrand" Caption="Chi nhánh" VisibleIndex="15" Visible="false">
                                                                <PropertiesTextEdit>
                                                                </PropertiesTextEdit>
                                                                <EditFormSettings VisibleIndex="12" Visible="True" />
                                                            </dx:GridViewDataTextColumn>
                                                            <dx:GridViewDataTextColumn FieldName="Email" VisibleIndex="16" Visible="false">
                                                                <PropertiesTextEdit>
                                                                    <ValidationSettings Display="Dynamic" ErrorDisplayMode="Text" ErrorTextPosition="Bottom">
                                                                        <RegularExpression ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" />
                                                                    </ValidationSettings>
                                                                    <ClientSideEvents TextChanged="function(s,e){eUserName.SetText(s.GetText());}" />
                                                                </PropertiesTextEdit>
                                                                <EditFormSettings VisibleIndex="13" Visible="True" />
                                                            </dx:GridViewDataTextColumn>
                                                            <dx:GridViewDataComboBoxColumn FieldName="ParentName" Caption="Quản lý cấp trên" VisibleIndex="17">
                                                                <EditFormSettings VisibleIndex="14" Visible="True" />
                                                                <EditItemTemplate>
                                                                    <asp:HiddenField runat="server" ID="hdfParentId" Value='<%# Eval("ParentId") %>' />
                                                                    <dx:ASPxComboBox runat="server" ID="cmbParentName" ClientInstanceName="cmbParentName" Width="100%"
                                                                        DataSourceID="odsParentIdByPos"
                                                                        TextField="EmployeeName" ValueField="EmployeeId" ValueType="System.String"
                                                                        DropDownStyle="DropDownList" Value='<%# Eval("ParentName") %>'
                                                                        OnCallback="cmbParentName_Callback">
                                                                    </dx:ASPxComboBox>
                                                                </EditItemTemplate>
                                                            </dx:GridViewDataComboBoxColumn>
                                                            <dx:GridViewDataDateColumn FieldName="WorkingDate" Caption="Ngày vào làm" VisibleIndex="18" Visible="false">
                                                                <EditFormSettings Visible="False" />
                                                                <PropertiesDateEdit DisplayFormatString="yyyy-MM-dd"></PropertiesDateEdit>
                                                            </dx:GridViewDataDateColumn>
                                                            <dx:GridViewDataDateColumn FieldName="DayOff" Caption="Ngày nghỉ việc" VisibleIndex="19" Visible="false">
                                                                <EditFormSettings Visible="False" />
                                                                <PropertiesDateEdit DisplayFormatString="yyyy-MM-dd"></PropertiesDateEdit>
                                                            </dx:GridViewDataDateColumn>
                                                            <dx:GridViewDataColumn FieldName="ShopCode" Caption="Mã CH" VisibleIndex="20" Visible="false">
                                                                <EditFormSettings Visible="False" />
                                                            </dx:GridViewDataColumn>
                                                            <dx:GridViewDataColumn FieldName="ShopName" Caption="Tên CH" VisibleIndex="21" Visible="false">
                                                                <EditFormSettings Visible="False" />
                                                            </dx:GridViewDataColumn>
                                                            <dx:GridViewDataColumn FieldName="District" Caption="Quận/Huyện" VisibleIndex="22" Visible="false">
                                                                <EditFormSettings Visible="False" />
                                                            </dx:GridViewDataColumn>
                                                            <dx:GridViewDataColumn FieldName="ActiveDate" Caption="Ngày vào CH" VisibleIndex="23" Visible="true">
                                                                <EditFormSettings Visible="False" />
                                                            </dx:GridViewDataColumn>
                                                            <dx:GridViewCommandColumn ShowNewButtonInHeader="true" ShowApplyFilterButton="true" ShowEditButton="true" ShowDeleteButton="true" VisibleIndex="24">
                                                            </dx:GridViewCommandColumn>
                                                        </Columns>
                                                    </dx:ASPxGridView>
                                                    <asp:ObjectDataSource runat="server" ID="odsParentIdByPos" SelectMethod="getParentbyPosition" TypeName="LogicTier.Controllers.EmployeeBL">
                                                        <SelectParameters>
                                                            <asp:Parameter Name="position" DefaultValue="PC" Type="String" />
                                                        </SelectParameters>
                                                    </asp:ObjectDataSource>
                                                    <asp:ObjectDataSource ID="odsEmployee" runat="server" 
                                                        DataObjectTypeName="LogicTier.Models.Employee"
                                                        DeleteMethod="Delete" InsertMethod="Insert" 
                                                        TypeName="LogicTier.Controllers.EmployeeBL"
                                                        UpdateMethod="Update" SelectMethod="getList">
                                                        <DeleteParameters>
                                                            <asp:Parameter Name="empId" Type="Int32" />
                                                        </DeleteParameters>
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
                                                    <asp:ObjectDataSource ID="odsAvailable" runat="server" SelectMethod="Available" TypeName="LogicTier.Controllers.EmployeeSupportBL">
                                                        <SelectParameters>
                                                            <asp:Parameter Name="empId" Type="Int32" />
                                                            <asp:Parameter Name="acDate" Type="String" />
                                                            <asp:Parameter Name="shift" Type="String" />
                                                        </SelectParameters>
                                                    </asp:ObjectDataSource>
                                                    <asp:ObjectDataSource ID="odsChosen" runat="server" SelectMethod="Chosen" TypeName="LogicTier.Controllers.EmployeeSupportBL">
                                                        <SelectParameters>
                                                            <asp:Parameter Name="empId" Type="Int32" />
                                                            <asp:Parameter Name="acDate" Type="String" />
                                                            <asp:Parameter Name="shift" Type="String" />
                                                        </SelectParameters>
                                                    </asp:ObjectDataSource>
                                                    <asp:ObjectDataSource ID="odsDistrict" runat="server" SelectMethod="getByCityOrDistrict" TypeName="LogicTier.Controllers.OutletBL">
                                                        <SelectParameters>
                                                            <asp:Parameter Name="city" Type="String" />
                                                            <asp:Parameter Name="disc" Type="String" />
                                                        </SelectParameters>
                                                    </asp:ObjectDataSource>
                                                    <asp:ObjectDataSource ID="obsgetOutlet" runat="server" SelectMethod="getOutletWithReference" TypeName="LogicTier.Controllers.OutletBL">
                                                        <SelectParameters>
                                                            <asp:Parameter Name="AccountId" Type="Int32" DefaultValue="" ConvertEmptyStringToNull="true" />
                                                            <asp:Parameter Name="objectId" Type="Int32" DefaultValue="" ConvertEmptyStringToNull="true" />
                                                            <asp:Parameter Name="region" Type="String" DefaultValue="" ConvertEmptyStringToNull="true" />
                                                            <asp:Parameter Name="City" Type="String" DefaultValue="" ConvertEmptyStringToNull="true" />
                                                            <asp:Parameter Name="shopCode" Type="String" DefaultValue="" ConvertEmptyStringToNull="true" />
                                                            <asp:Parameter Name="shopName" Type="String" DefaultValue="" ConvertEmptyStringToNull="true" />
                                                        </SelectParameters>
                                                    </asp:ObjectDataSource>
                                                    <asp:ObjectDataSource ID="odsUsername" runat="server" SelectMethod="getbyusername" TypeName="LogicTier.Controllers.UserBL">
                                                        <SelectParameters>
                                                            <asp:SessionParameter SessionField="empShopId" Name="userName" Type="String" />
                                                        </SelectParameters>
                                                    </asp:ObjectDataSource>
                                                </div>
                                            </dx:ContentControl>
                                        </ContentCollection>
                                    </dx:TabPage>
                                    <dx:TabPage Text="Target incentive">
                                        <ContentCollection>
                                            <dx:ContentControl runat="server">
                                                <div class="row">
                                                    <div class="col-md-12">
                                                        <uc1:ToolbarExport runat="server" ID="ToolbarExport2" OnItemClick="ToolbarExport2_ItemClick" />
                                                        <dx:ASPxPivotGridExporter ID="ASPxPivotGridExporter1" runat="server" ASPxPivotGridID="gvincentive" />
                                                    </div>
                                                </div>
                                                <div class="row marginTop20">
                                                    <div class="col-md-12">
                                                        <dx:ASPxPivotGrid ID="gvincentive" runat="server" OnLoad="gvincentive_Load"
                                                            DataSourceID="odstarget" Width="100%" ClientIDMode="AutoID">
                                                            <Fields>
                                                                <dx:PivotGridField Area="ColumnArea" AreaIndex="0" FieldName="Product" ID="fieldProduct">
                                                                    <CellStyle HorizontalAlign="Center"></CellStyle>
                                                                </dx:PivotGridField>
                                                                <dx:PivotGridField Area="ColumnArea" AreaIndex="1" FieldName="Range" ID="fieldRange">
                                                                    <CellStyle HorizontalAlign="Center"></CellStyle>
                                                                </dx:PivotGridField>
                                                                <dx:PivotGridField Area="RowArea" AreaIndex="0" Caption="Epl.Code" FieldName="EmployeeCode" ID="fieldEmployeeCode" Options-AllowExpand="False" />
                                                                <dx:PivotGridField Area="RowArea" AreaIndex="1" Caption="Epl.Name" FieldName="EmployeeName" ID="fieldEmployeeName" Options-AllowExpand="False" />
                                                                <dx:PivotGridField Area="DataArea" AreaIndex="2" Caption="Incentive" FieldName="targetamount" ID="fieldtargetamount" SummaryType="SUM">
                                                                    <CellStyle HorizontalAlign="Center"></CellStyle>
                                                                </dx:PivotGridField>
                                                            </Fields>
                                                            <OptionsView HorizontalScrollBarMode="Auto" ShowColumnGrandTotals="False" ShowRowTotals="False" ShowRowGrandTotals="False" />
                                                            <OptionsFilter NativeCheckBoxes="False" ShowOnlyAvailableItems="true" />
                                                        </dx:ASPxPivotGrid>
                                                        <asp:ObjectDataSource ID="odstarget" runat="server" DataObjectTypeName="LogicTier.Models.Employee" TypeName="LogicTier.Controllers.TargetForincentiveBL" SelectMethod="getList">
                                                            <SelectParameters>
                                                                <asp:Parameter Name="activedate" Type="String" />
                                                                <asp:Parameter Name="EmployeeId" Type="Int32" />
                                                                <asp:Parameter Name="EmployeeCode" Type="String" />
                                                                <asp:Parameter Name="Position" Type="String" />
                                                                <asp:Parameter Name="ParentId" Type="Int32" />
                                                                <asp:Parameter Name="userName" DefaultValue="admin" Type="String" />
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