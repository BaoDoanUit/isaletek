<%@ Page Title="Sales Performance" Language="C#" MasterPageFile="~/Layout.master" AutoEventWireup="true" CodeBehind="SalePerformance.aspx.cs" Inherits="WebApplication.Pages.SalePerformance" %>

<%@ Register Src="~/UserControls/ToolbarExport.ascx" TagPrefix="uc1" TagName="ToolbarExport" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Content" runat="server">
    <script>
        function OnEndCallback(s, e) {
            if (s.cpAlert != '') {
                alert(s.cpAlert);
            }
        }
        function OnInit(s, e) {
            var calendar = s.GetCalendar();
            calendar.owner = s;
        }

        function OnDropDown(s, e) {
            var calendar = s.GetCalendar();
            var fastNav = calendar.fastNavigation;
            fastNav.activeView = calendar.GetView(0, 0);
            fastNav.Prepare();
            fastNav.GetPopup().popupVerticalAlign = "Below";
            fastNav.GetPopup().ShowAtElement(s.GetMainElement());

            fastNav.OnOkClick = function () {
                var parentDateEdit = this.calendar.owner;
                var currentDate = new Date(fastNav.activeYear, fastNav.activeMonth, 1);
                parentDateEdit.SetDate(currentDate);
                parentDateEdit.HideDropDown();
                fastNav.GetPopup().Hide();
            }

            fastNav.OnCancelClick = function () {
                var parentDateEdit = this.calendar.owner;
                parentDateEdit.HideDropDown();
                fastNav.GetPopup().Hide();
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
                        <dx:LayoutGroup Caption="Filter" ColCount="5">
                            <Items>
                                <dx:LayoutItem Caption="Month">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer>
                                            <dx:ASPxDateEdit runat="server" ID="txReportDate" DisplayFormatString="yyyy-MM"
                                                EditFormat="Custom" EditFormatString="yyyy-MM" OnInit="txReportDate_Init">
                                                <ClearButton DisplayMode="OnHover"></ClearButton>
                                                <ClientSideEvents Init="OnInit" DropDown="OnDropDown" />
                                            </dx:ASPxDateEdit>
                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>
                                </dx:LayoutItem>
                                <dx:LayoutItem Caption="Account Group">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer>
                                            <dx:ASPxComboBox runat="server" ID="cbAccount" ValueType="System.Int32" NullText="Choose to select Account Group"
                                                DataSourceID="odsAccount" TextField="Account" ValueField="ObjectId"
                                                ClientInstanceName="cbAccount" CallbackPageSize="10">
                                                <ClientSideEvents SelectedIndexChanged="function(s,e){cbOutlet.PerformCallback(s.GetValue());}" />
                                                <ClearButton DisplayMode="OnHover"></ClearButton>
                                            </dx:ASPxComboBox>
                                            <asp:ObjectDataSource ID="odsAccount" runat="server" SelectMethod="getAccountGroup" TypeName="LogicTier.Controllers.SaleOutBL"></asp:ObjectDataSource>
                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>
                                </dx:LayoutItem>
                                <dx:LayoutItem Caption="Outlets">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer>
                                            <dx:ASPxComboBox runat="server" ID="cbOutlet" ValueField="ShopId"
                                                ValueType="System.Int32" NullText="Choose to filter by Outlet" OnCallback="cbOutlet_Callback"
                                                ClientInstanceName="cbOutlet" CallbackPageSize="10" DataSourceID="obsgetOutlet">
                                                <ClearButton DisplayMode="OnHover"></ClearButton>
                                                <Columns>
                                                    <dx:ListBoxColumn FieldName="ShopName" Width="250px" />
                                                    <dx:ListBoxColumn FieldName="District" />
                                                </Columns>
                                            </dx:ASPxComboBox>
                                            <asp:ObjectDataSource ID="obsgetOutlet" runat="server" SelectMethod="getOutletWithReference" TypeName="LogicTier.Controllers.OutletBL">
                                                <SelectParameters>
                                                    <asp:Parameter Name="objectId" Type="Int32" />
                                                    <asp:Parameter Name="region" Type="String" />
                                                    <asp:Parameter Name="city" Type="String" />
                                                    <asp:Parameter Name="disc" Type="String" />
                                                    <asp:Parameter Name="shopCode" Type="String" />
                                                    <asp:Parameter Name="shopName" Type="String" />
                                                    <asp:Parameter Name="userName" Type="String" />
                                                </SelectParameters>
                                            </asp:ObjectDataSource>
                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>
                                </dx:LayoutItem>
                                <dx:LayoutItem Caption="Leader">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer>
                                            <dx:ASPxComboBox runat="server" ID="cbLearder" ValueField="EmployeeId"
                                                ValueType="System.Int32" NullText="Choose to filter by Leader person"
                                                ClientInstanceName="cbLearder" CallbackPageSize="10" DataSourceID="odsLeader" OnInit="cbLearder_Init">
                                                <ClientSideEvents SelectedIndexChanged="function(s,e){cbEmployee.PerformCallback(s.GetValue());}" />
                                                <ClearButton DisplayMode="OnHover"></ClearButton>
                                                <Columns>
                                                    <dx:ListBoxColumn FieldName="EmployeeName" />
                                                </Columns>
                                            </dx:ASPxComboBox>
                                            <asp:ObjectDataSource ID="odsLeader" runat="server" SelectMethod="getList" TypeName="LogicTier.Controllers.EmployeeBL">
                                                <SelectParameters>
                                                    <asp:Parameter Name="empId" Type="Int32" />
                                                    <asp:Parameter Name="empCode" Type="String" />
                                                    <asp:Parameter Name="pos" Type="String" />
                                                    <asp:Parameter Name="parentId" Type="Int32" />
                                                    <asp:Parameter Name="userName" Type="String" />
                                                </SelectParameters>
                                            </asp:ObjectDataSource>
                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>
                                </dx:LayoutItem>
                                <dx:LayoutItem Caption="Employee">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer>
                                            <dx:ASPxComboBox runat="server" ID="cbEmployee" OnCallback="cbEmployee_Callback"
                                                ValueType="System.Int32" NullText="Choose to filter by Employee person" ValueField="EmployeeId"
                                                ClientInstanceName="cbEmployee" EnableCallbackMode="true" CallbackPageSize="10" DataSourceID="odsEmployee">
                                                <ClearButton DisplayMode="OnHover"></ClearButton>
                                                <Columns>
                                                    <dx:ListBoxColumn FieldName="EmployeeName" />
                                                </Columns>
                                            </dx:ASPxComboBox>
                                            <asp:ObjectDataSource ID="odsEmployee" runat="server" SelectMethod="getList" TypeName="LogicTier.Controllers.EmployeeBL">
                                                <SelectParameters>
                                                    <asp:Parameter Name="empId" Type="Int32" />
                                                    <asp:Parameter Name="empCode" Type="String" />
                                                    <asp:Parameter Name="pos" Type="String" />
                                                    <asp:Parameter Name="parentId" Type="Int32" />
                                                    <asp:Parameter Name="userName" Type="String" />
                                                </SelectParameters>
                                            </asp:ObjectDataSource>
                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>
                                </dx:LayoutItem>
                                <dx:LayoutItem ShowCaption="False">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer>
                                            <dx:ASPxButton ID="FilterButton" AutoPostBack="false" runat="server" Text="Tìm kiếm">
                                                <ClientSideEvents Click="function(s, e) { cp.PerformCallback('filter'); }"></ClientSideEvents>
                                            </dx:ASPxButton>
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
                                </tr>
                            </table>
                        </div>
                    </div>
                    <div class="row marginTop20">
                        <div class="col-md-12">
                            <dx:ASPxGridView runat="server" AutoGenerateColumns="False" ID="gvSale" ClientInstanceName="gvSale"
                                KeyFieldName="Target;Quantity" OnLoad="gvSale_Load" Width="100%"
                                EnableRowsCache="false" OnCustomSummaryCalculate="gvSale_CustomSummaryCalculate"
                                DataSourceID="odsSale">
                                <Styles>
                                    <Header Wrap="True" VerticalAlign="Middle" HorizontalAlign="Center"></Header>
                                    <Cell Wrap="True" VerticalAlign="Middle"></Cell>
                                    <AlternatingRow Enabled="true" />
                                </Styles>
                                <Settings ShowFooter="true" />
                                <Columns>
                                    <dx:GridViewDataTextColumn FieldName="EmployeeCode" VisibleIndex="1">
                                    </dx:GridViewDataTextColumn>
                                    <dx:GridViewDataTextColumn FieldName="EmployeeName" VisibleIndex="2">
                                    </dx:GridViewDataTextColumn>
                                    <dx:GridViewDataComboBoxColumn FieldName="Account" VisibleIndex="3">
                                    </dx:GridViewDataComboBoxColumn>
                                    <dx:GridViewDataComboBoxColumn FieldName="ShopCode" VisibleIndex="4">
                                    </dx:GridViewDataComboBoxColumn>
                                    <dx:GridViewDataTextColumn FieldName="ShopName" VisibleIndex="5">
                                    </dx:GridViewDataTextColumn>
                                    <dx:GridViewDataTextColumn FieldName="Target" VisibleIndex="6">
                                    </dx:GridViewDataTextColumn>
                                    <dx:GridViewDataSpinEditColumn FieldName="Quantity" VisibleIndex="7" Settings-FilterMode="Value">
                                    </dx:GridViewDataSpinEditColumn>
                                    <dx:GridViewDataTextColumn FieldName="Percent" VisibleIndex="8">
                                        <DataItemTemplate>
                                            <dx:ASPxLabel runat="server" ID="lbPercent" Text='<%# Eval("Percent")+"%" %>'></dx:ASPxLabel>
                                        </DataItemTemplate>
                                    </dx:GridViewDataTextColumn>
                                    <dx:GridViewDataTextColumn FieldName="SaleDate" VisibleIndex="9">
                                        <PropertiesTextEdit DisplayFormatString="{0:yyyy-MM-dd}"></PropertiesTextEdit>
                                    </dx:GridViewDataTextColumn>
                                </Columns>
                                <FormatConditions>
                                    <dx:GridViewFormatConditionTopBottom FieldName="Percent" Rule="TopPercent" Threshold="5" Format="GreenText" />
                                    <dx:GridViewFormatConditionHighlight FieldName="Percent" Expression="[Percent] > 80" Format="GreenFillWithDarkGreenText" />
                                    <dx:GridViewFormatConditionIconSet FieldName="Quantity" Format="Ratings4" />
                                </FormatConditions>
                                <TotalSummary>
                                    <dx:ASPxSummaryItem FieldName="Target" SummaryType="Sum" />
                                    <dx:ASPxSummaryItem FieldName="Quantity" SummaryType="Sum" />
                                    <dx:ASPxSummaryItem FieldName="Percent" SummaryType="Custom"/>
                                </TotalSummary>
                            </dx:ASPxGridView>
                            <asp:ObjectDataSource ID="odsSale" runat="server" SelectMethod="DailybyEmployee" TypeName="LogicTier.Controllers.SaleOutBL">
                                <SelectParameters>
                                    <asp:Parameter Name="userName" Type="String" />
                                    <asp:Parameter Name="empId" Type="Int32" />
                                    <asp:Parameter Name="ParentId" Type="Int32" />
                                    <asp:Parameter Name="ShopId" Type="Int32" />
                                    <asp:Parameter Name="account" Type="Int32" />
                                    <asp:Parameter Name="month" Type="Int32" />
                                    <asp:Parameter Name="year" Type="Int32" />
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
                </dx:PanelContent>
            </PanelCollection>
        </dx:ASPxCallbackPanel>
    </div>
</asp:Content>
