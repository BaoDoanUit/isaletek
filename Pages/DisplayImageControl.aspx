<%@ Page Title="Display Images Report" Language="C#" MasterPageFile="~/Layout.master" AutoEventWireup="true" CodeBehind="DisplayImageControl.aspx.cs" Inherits="WebApplication.Pages.DisplayImageControl" %>

<%@ Register Src="~/UserControls/DisplayImageDetail.ascx" TagPrefix="uc1" TagName="DisplayImageDetail" %>


<asp:Content ID="Content1" ContentPlaceHolderID="Content" runat="server">
    <script>
        function OnEndCallback(s, e) {
            if (s.cpAlert != '') {
                if (s.cpAlert == 'dImg') {
                    lbDelId.SetText('');
                    alert('Xóa thành công!');
                }
                else
                    alert(s.cpAlert);
            }
        }
        function delImg(Id, chk) {
            var str = lbDelId.GetText();
            if (str != '')
                str += ',';

            if (chk)
                str += Id;
            else
                str = str.replace(Id + ',', '');

            lbDelId.SetText(str);
        }

        function delMultiId() {
            var tmp = lbDelId.GetText();
            if (tmp === null || tmp === '' || tmp === ',') {
                alert('Bạn chưa chọn hình để xóa!')
                return;
            }
            if (confirm('Bạn có muốn xóa tất cả hình đã chọn không?'))
                cp.PerformCallback('delImg;' + tmp);
        }

        function udpIsExport(Id, isExport) {
            cp.PerformCallback('udpIsExport;' + Id + ';' + isExport);
        }
        function IsExport() {
            aspxCallbackLoadImage.PerformCallback("IsExport");
        }
        function IsDelete() {
            if (confirm('Bạn có muốn xóa tất cả hình đã chọn không?'))
                aspxCallbackLoadImage.PerformCallback("Delete");
        }
        $(document).ready(function () {
            $("#TopPanel_NavMenu ul li:eq(4)").addClass("dxm-selected");
            $('.ckchoose').change(function () {
                var ths = $(this);
                if (kpi.is(':checked') == true) {

                }
            });
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
                                                    <dx:ASPxComboBox runat="server" Width="100%" ID="cbOutlet" ValueField="ShopId"
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
                                                    <label>Product</label>
                                                    <dx:ASPxComboBox runat="server" Width="100%" ID="cbProduct" ValueField="Product"
                                                        ValueType="System.String" NullText="Choose to filter by Product"
                                                        ClientInstanceName="cbProduct" CallbackPageSize="10" DataSourceID="odsProduct">
                                                        <ClearButton DisplayMode="OnHover"></ClearButton>
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
                                                    <label>Suppervisor</label>
                                                    <dx:ASPxComboBox runat="server" Width="100%" ID="cbLearder" ValueField="EmployeeId"
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
                                                            <asp:Parameter Name="emplName" Type="String" DefaultValue="" ConvertEmptyStringToNull="true" />
                                                            <asp:ControlParameter ControlID="AddCommentFormLayout$OptionRadioButtonList" Name="Option" Type="Int32" PropertyName="Value" />
                                                            <asp:Parameter Name="userId" Type="Int32" />
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
                                                            <asp:Parameter Name="userId" Type="Int32" />
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
                                                <div class="col-md-2">
                                                    <label style="color: white">Tool</label><br />
                                                    <dx:ASPxButton ID="FilterButton" CssClass="btn btn-primary" AutoPostBack="false" runat="server" Text="Tìm kiếm">
                                                        <ClientSideEvents Click="function(s, e) {  cp.PerformCallback('filter'); }"></ClientSideEvents>
                                                    </dx:ASPxButton>
                                                </div>
                                                <div class="col-md-4">
                                                    <label></label>
                                                    <dx:ASPxCallbackPanel runat="server" ID="ExportASPxCallbackPanel" Width="100%" SettingsLoadingPanel-Text="Export data, please wait." ClientInstanceName="ExportCallbackPanel" OnCallback="ExportASPxCallbackPanel_Callback">
                                                        <PanelCollection>
                                                            <dx:PanelContent ID="PanelContent2" runat="server">
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
        <dx:ASPxCallbackPanel ID="ASPxCallbackPanel1" runat="server" Width="100%"
            ClientInstanceName="cp" OnCallback="ASPxCallbackPanel1_Callback">
            <ClientSideEvents EndCallback="OnEndCallback" />
            <PanelCollection>
                <dx:PanelContent runat="server">
                    <div class="row container marginTop20">
                        <div class="col-md-12 box-content">
                            <div class="row marginTop20">
                                <div class="col-md-12">
                                    <dx:ASPxButton ID="btnDownload" ClientInstanceName="btnDownload" runat="server"
                                        Text="Download Powerpoint" CssClass="btn btn-warning" OnClick="btnDownload_Click">
                                    </dx:ASPxButton>
                                    <dx:ASPxHyperLink runat="server" ID="hpExport" ClientInstanceName="hpExport" ClientVisible="false"></dx:ASPxHyperLink>
                                </div>
                            </div>
                            <div class="row marginTop20 marginBot20">
                                <div class="col-md-12">
                                    <dx:ASPxGridView runat="server"
                                        ID="gvSale" ClientInstanceName="gvSale"
                                        Width="100%" DataSourceID="odsSale"
                                        AutoGenerateColumns="False"
                                        KeyFieldName="ShopId;ReportDate;ShopName" OnLoad="gvSale_Load">
                                        <SettingsCommandButton>
                                            <DeleteButton Text="Delete"></DeleteButton>
                                        </SettingsCommandButton>
                                        <SettingsBehavior ConfirmDelete="true" AllowFocusedRow="True" />
                                        <SettingsText ConfirmDelete="Bạn có muốn xóa không?" />
                                        <Styles Header-Wrap="True">
                                            <Header Wrap="True" VerticalAlign="Middle" HorizontalAlign="Center"></Header>
                                            <Cell Wrap="True" VerticalAlign="Middle"></Cell>
                                            <AlternatingRow Enabled="true" />
                                        </Styles>
                                        <SettingsDetail ShowDetailRow="True" AllowOnlyOneMasterRowExpanded="True" />
                                        <ClientSideEvents RowClick="function(s, e) {s.ExpandDetailRow(s.GetFocusedRowIndex());}" />
                                        <Templates>
                                            <DetailRow>
                                                <uc1:DisplayImageDetail runat="server" shopId='<%#Eval("ShopId")%>' OnLoad="DisplayImageDetail_Load" rpDate='<%#Eval("ReportDate","{0:yyyy-MM-dd}") %>' ID="DisplayImageDetail" />
                                            </DetailRow>
                                        </Templates>
                                        <Columns>
                                            <dx:GridViewDataTextColumn FieldName="Region" VisibleIndex="0">
                                            </dx:GridViewDataTextColumn>
                                            <dx:GridViewDataTextColumn FieldName="Account" VisibleIndex="1">
                                            </dx:GridViewDataTextColumn>
                                            <dx:GridViewDataComboBoxColumn FieldName="ShopName" VisibleIndex="2">
                                            </dx:GridViewDataComboBoxColumn>
                                            <dx:GridViewDataTextColumn FieldName="ReportDate" VisibleIndex="3">
                                                <PropertiesTextEdit DisplayFormatString="yyyy-MM-dd"></PropertiesTextEdit>
                                            </dx:GridViewDataTextColumn>
                                        </Columns>
                                    </dx:ASPxGridView>
                                    <asp:ObjectDataSource ID="odsSale" runat="server" SelectMethod="getbyShop" TypeName="LogicTier.Controllers.ImageDisplayBL">
                                        <SelectParameters>
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
                                            <asp:Parameter Name="Product" Type="String" />
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
                                </div>
                            </div>
                        </div>
                    </div>
                </dx:PanelContent>
            </PanelCollection>
        </dx:ASPxCallbackPanel>
    </div>
    <dx:ASPxLabel runat="server" ID="lbDelId" ClientInstanceName="lbDelId" ClientVisible="false"></dx:ASPxLabel>
    <script type="text/javascript">
        function OpenPopup(product, shopId, rpDate) {
            var w = 800, h = 500;
            var left = (screen.width / 2) - (w / 2);
            var top = (screen.height / 2) - (h / 2);
            var link = "Silder.aspx?product=" + product + "&shopId=" + shopId + "&rpDate=" + rpDate;
            window.open(link, 'popup', 'toolbar=no, location=no, directories=no, status=no, menubar=no, scrollbars=yes, resizable=no, copyhistory=no, width=' + w + ', height=' + h + ', top=' + top + ', left=' + left);
            return false;
        }
    </script>
</asp:Content>
