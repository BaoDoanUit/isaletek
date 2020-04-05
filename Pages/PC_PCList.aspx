<%@ Page Title="PC List" Language="C#" MasterPageFile="~/Layout.master" AutoEventWireup="true" CodeBehind="PC_PCList.aspx.cs" Inherits="WebApplication.Pages.PC_PCList" %>

<%@ Register Assembly="DevExpress.Web.ASPxPivotGrid.v17.1, Version=17.1.6.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.ASPxPivotGrid" TagPrefix="dx" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Content" runat="server">
    <style>
        fieldset.scheduler-border {
            background-color: rgba(227, 229, 229, 0.09);
            border: 1px groove #ddd !important;
            padding: 0 1.4em 1.4em 1.4em !important;
            margin: 0 0 1.5em 0 !important;
            -webkit-box-shadow: 0px 0px 0px 0px #000;
            box-shadow: 0px 0px 0px 0px #000;
        }

        legend.scheduler-border {
            font-size: 1.2em !important;
            font-weight: bold !important;
            text-align: left !important;
            width: auto;
            padding: 35px 10px 0 10px;
            border-bottom: none;
        }

        .modal-blue {
            /*background: #007bff !important;
            color: #ffffff*/
        }

        .filter .dxeCaption_Moderno {
            width: 64px !important
        }

        #ctl00_Content_aspCallbackPanel2_gvWorkPlan_pgArea2 {
            display: none
        }

        .marginTop10 {
            margin-top: 10px
        }
    </style>
    <script>
        function OnEndCallback(s, e) {
            if (s.cpAlert != null && s.cpAlert != '') {
                alert(s.cpAlert);
            }
        }
        var textSeparator = ";";
        var valueSelect = ';';
        function updateText() {
            var selectedItems = checkListBox.GetSelectedItems();
            checkComboBox.SetText(getSelectedItemsText(selectedItems));
        }
        function synchronizeListBoxValues(dropDown, args) {
            checkListBox.UnselectAll();
            var texts = dropDown.GetText().split(textSeparator);
            var values = getValuesByTexts(texts);
            checkListBox.SelectValues(values);
            updateText(); // for remove non-existing texts
        }
        function getSelectedItemsText(items) {
            var texts = [];
            for (var i = 0; i < items.length; i++)
                texts.push(items[i].text);
            return texts.join(textSeparator);
        }
        function getValuesByTexts(texts) {
            valueSelect = '';
            var actualValues = [];
            var item;
            for (var i = 0; i < texts.length; i++) {
                item = checkListBox.FindItemByText(texts[i]);
                if (item != null)
                    actualValues.push(item.value);
            }
            return actualValues;
        }
        function GetValues() {
            var selectedItems = checkListBox.GetSelectedItems();
            var valuesText = getSelectedItemsText(selectedItems);
            valueSelect = getValuesByTexts(valuesText.split(textSeparator));
            hdfKey.Set('gfk', valueSelect.join());
        }
    </script>

    <dx:ASPxCallbackPanel ID="aspCallbackPanel" runat="server" Width="100%" ClientSideEvents-EndCallback="OnEndCallback"
        ClientInstanceName="aspCallbackPanel" OnCallback="aspCallbackPanel_Callback">
        <PanelCollection>
            <dx:PanelContent runat="server">
                <div class="row filter">
                    <div class="col-md-4">
                        <fieldset class="scheduler-border ">
                            <legend class="scheduler-border">Search</legend>
                            <div class="row" style="display: none">
                                <div class="col-md-12">
                                    <dx:ASPxComboBox Caption="Term *" runat="server" ID="cbTerm" Width="100%" DataSourceID="odsTerm" ValueField="Id" ValueType="System.Int32" NullText="--All--"
                                        ClientInstanceName="cbTerm" DropDownStyle="DropDownList">
                                        <ClearButton DisplayMode="OnHover"></ClearButton>
                                        <ClientSideEvents ValueChanged="function(s,e){ cbWeek.PerformCallback()}" />
                                        <Columns>
                                            <dx:ListBoxColumn FieldName="TermCycle" Caption="Term" />
                                        </Columns>
                                    </dx:ASPxComboBox>
                                    <asp:ObjectDataSource ID="odsTerm" runat="server" SelectMethod="getList" TypeName="LogicTier.Controllers.TermController"></asp:ObjectDataSource>
                                </div>
                            </div>
                            <div class="row marginTop10">
                                <div class="col-md-12">
                                    <dx:ASPxComboBox Caption="Week *" runat="server" Width="100%" ID="cbWeek" DataSourceID="odsWeek" ValueField="WeekByYear" ValueType="System.Int32" NullText="--ALL--"
                                        ClientInstanceName="cbWeek" EnableCallbackMode="true" DropDownStyle="DropDownList">
                                        <ClearButton DisplayMode="OnHover"></ClearButton>
                                        <Columns>
                                            <dx:ListBoxColumn FieldName="WeekCycle" Caption="Week" />
                                        </Columns>
                                    </dx:ASPxComboBox>
                                    <asp:ObjectDataSource ID="odsWeek" runat="server" SelectMethod="getWeek" TypeName="LogicTier.Controllers.TermController">
                                        <SelectParameters>
                                            <asp:ControlParameter ControlID="cbTerm" DbType="Int32" Name="Id" PropertyName="Value" />
                                        </SelectParameters>
                                    </asp:ObjectDataSource>
                                </div>
                            </div>
                            <div class="row marginTop10" style="display: none">
                                <div class="col-md-12">
                                    <dx:ASPxComboBox Caption="Area" runat="server" Width="100%" ID="cbArea" DataSourceID="odsArea" ValueField="Area" ValueType="System.String" NullText="--All--"
                                        ClientInstanceName="cbArea" EnableCallbackMode="true" DropDownStyle="DropDownList">
                                        <ClearButton DisplayMode="OnHover"></ClearButton>
                                        <ClientSideEvents ValueChanged="function(s,e){cbRegion.PerformCallback()}" />
                                        <Columns>
                                            <dx:ListBoxColumn FieldName="Area" Caption="Area" />
                                        </Columns>
                                    </dx:ASPxComboBox>
                                    <asp:ObjectDataSource ID="odsArea" runat="server" SelectMethod="getDivision" TypeName="LogicTier.Controllers.OutletBL">
                                        <SelectParameters>
                                            <asp:Parameter DefaultValue="Area" Name="fieldName" Type="String" />
                                            <asp:Parameter Name="fieldValue" Type="String" />
                                            <asp:Parameter DefaultValue="Area" Name="fieldDisplay" Type="String" />
                                        </SelectParameters>
                                    </asp:ObjectDataSource>
                                </div>
                            </div>
                            <div class="row marginTop10">
                                <div class="col-md-12">
                                    <dx:ASPxDropDownEdit Width="100%" ClientInstanceName="checkComboBox" NullText="--All--" Caption="Area" ID="checkRegion" runat="server" AnimationType="None">
                                        <DropDownWindowTemplate>
                                            <dx:ASPxListBox Width="100%" ID="listBox" ClientInstanceName="checkListBox" SelectionMode="CheckColumn" DataSourceID="odsregion"
                                                runat="server" Height="200" EnableSelectAll="true" ValueField="Region" TextField="Region">
                                                <Border BorderStyle="None" />
                                                <BorderBottom BorderStyle="Solid" BorderWidth="1px" BorderColor="#DCDCDC" />
                                                <ClientSideEvents SelectedIndexChanged="updateText" Init="updateText" />
                                            </dx:ASPxListBox>
                                            <table style="width: 100%">
                                                <tr>
                                                    <td style="padding: 4px">
                                                        <dx:ASPxButton ID="ASPxButton1" AutoPostBack="False" runat="server" Text="Close" Style="float: right">
                                                            <ClientSideEvents Click="function(s, e){ checkComboBox.HideDropDown();GetValues(); }" />
                                                        </dx:ASPxButton>
                                                    </td>
                                                </tr>
                                            </table>
                                        </DropDownWindowTemplate>
                                        <ClientSideEvents TextChanged="synchronizeListBoxValues" DropDown="synchronizeListBoxValues" />
                                    </dx:ASPxDropDownEdit>
                                    <asp:ObjectDataSource ID="odsregion" runat="server" SelectMethod="getRegion_byArea" TypeName="LogicTier.Controllers.OutletBL">
                                        <SelectParameters>
                                            <asp:ControlParameter ControlID="cbArea" PropertyName="Value" Name="Area" Type="String" />
                                        </SelectParameters>
                                    </asp:ObjectDataSource>
                                </div>
                            </div>
                            <div class="row marginTop10" style="display: none">
                                <div class="col-md-12">
                                    <dx:ASPxComboBox runat="server" ID="cbAccount" Caption="Dealer" ValueType="System.Int32" Width="100%" NullText="--ALL--"
                                        DataSourceID="odsAccount" TextField="Account" ValueField="ObjectId"
                                        ClientInstanceName="cbAccount" CallbackPageSize="10">
                                        <ClearButton DisplayMode="OnHover"></ClearButton>
                                    </dx:ASPxComboBox>
                                    <asp:ObjectDataSource ID="odsAccount" runat="server" SelectMethod="getAccountGroup" TypeName="LogicTier.Controllers.SaleOutBL"></asp:ObjectDataSource>
                                </div>
                            </div>
                            <div class="row marginTop20">
                                <div class="col-md-12">
                                    <dx:ASPxButton ID="FilterButton" AutoPostBack="false" runat="server" Text="Filter">
                                        <ClientSideEvents Click="function(s, e) {  aspCallbackPanel.PerformCallback('filter'); }"></ClientSideEvents>
                                    </dx:ASPxButton>
                                    <dx:ASPxButton ID="ExportButton" AutoPostBack="false" runat="server" Text="Export">
                                        <ClientSideEvents Click="function(s, e) {  aspCallbackPanel.PerformCallback('Export'); }"></ClientSideEvents>
                                    </dx:ASPxButton>
                                </div>
                                <div class="col-md-12 text-right marginTop05">
                                    <asp:HyperLink ID="hplexcel" runat="server" Visible="false"></asp:HyperLink>
                                </div>
                            </div>
                        </fieldset>
                    </div>
                    <div class="col-md-8 marginTop20" style="padding-left: 0">
                        <dx:ASPxGridView ID="grData" runat="server" AutoGenerateColumns="false" Theme="Material" OnLoad="grData_Load" Width="100%">
                            <Columns>
                            </Columns>
                            <Settings HorizontalScrollBarMode="Visible" VerticalScrollBarStyle="Standard" VerticalScrollableHeight="270" VerticalScrollBarMode="Visible" />
                            <SettingsBehavior AllowSort="false" ColumnResizeMode="Control" />
                            <Styles>
                                <Cell Wrap="True" VerticalAlign="Middle" Paddings-Padding="5px"></Cell>
                            </Styles>
                            <SettingsPager PageSize="200000"></SettingsPager>
                        </dx:ASPxGridView>
                    </div>
                </div>
                <div class="row">
                    <div class="col-12">
                        <dx:ASPxPivotGrid ID="gvWorkPlan" runat="server" OnCustomCellStyle="gvWorkPlan_CustomCellStyle" OnLoad="gvWorkPlan_Load" DataSourceID="odsData" Width="100%" ClientIDMode="AutoID">
                            <Fields>
                                <dx:PivotGridField Area="ColumnArea" AreaIndex="1" FieldName="WorkingDate" ID="fieldWorkingDate2" ValueFormat-FormatString="ddd" ValueFormat-FormatType="DateTime">
                                    <CellStyle HorizontalAlign="Center"></CellStyle>
                                </dx:PivotGridField>
                                <dx:PivotGridField Area="ColumnArea" AreaIndex="0" FieldName="WorkingDate" ID="fieldWorkingDate" ValueFormat-FormatString="dd" ValueFormat-FormatType="DateTime">
                                    <CellStyle HorizontalAlign="Center"></CellStyle>
                                </dx:PivotGridField>
                                <dx:PivotGridField Area="RowArea" AreaIndex="1" FieldName="Dealer" ID="fieldDealer" Caption="Dealer" Options-AllowExpand="False" />
                                <dx:PivotGridField Area="RowArea" AreaIndex="0" FieldName="City" ID="fieldRegion" Caption="Province" Options-AllowExpand="False" />
                                <dx:PivotGridField Area="RowArea" AreaIndex="2" FieldName="ShopName" Caption="Shop Name" ID="fieldShopName" Options-AllowExpand="False" />
                                <dx:PivotGridField Area="RowArea" AreaIndex="4" FieldName="EmployeeName" Caption="Employee Name" ID="fieldEmployeeName" Options-AllowExpand="False" />
                                <dx:PivotGridField Area="DataArea" AreaIndex="0" FieldName="ShiftType" ID="fieldShiftType" SummaryType="Max">
                                    <CellStyle HorizontalAlign="Center"></CellStyle>
                                </dx:PivotGridField>
                            </Fields>
                            <OptionsPager PageSizeItemSettings-Position="Right" Position="Bottom"></OptionsPager>
                            <OptionsView HorizontalScrollBarMode="Auto" ShowColumnGrandTotals="False" ShowRowTotals="False" ShowRowGrandTotals="False" />
                            <OptionsFilter NativeCheckBoxes="False" ShowOnlyAvailableItems="true" />
                        </dx:ASPxPivotGrid>
                        <asp:ObjectDataSource ID="odsData" runat="server" SelectMethod="Customer_getWorkingPlan" TypeName="LogicTier.Controllers.AttendanceBL">
                            <SelectParameters>
                                <asp:ControlParameter ControlID="hdfKey" Name="userName" PropertyName="['userName']" Type="String" />
                                <asp:ControlParameter ControlID="hdfKey" Name="Region" PropertyName="['gfk']" Type="String" />
                                <asp:ControlParameter ControlID="aspCallbackPanel$cbArea" Name="Area" PropertyName="Value" Type="String" />
                                <asp:Parameter Name="Product" Type="String" />
                                <asp:Parameter Name="FromDate" Type="String" />
                                <asp:Parameter Name="ToDate" Type="String" />
                                <asp:Parameter Name="Week" Type="Int32" />
                                <asp:Parameter Name="Year" Type="Int32" />
                                <asp:ControlParameter ControlID="aspCallbackPanel$cbAccount" Name="ObjectId" PropertyName="Value" Type="Int32" />
                            </SelectParameters>
                        </asp:ObjectDataSource>
                        <dx:ASPxHiddenField ID="hdfKey" ClientInstanceName="hdfKey" runat="server"></dx:ASPxHiddenField>
                    </div>
                </div>
            </dx:PanelContent>
        </PanelCollection>
    </dx:ASPxCallbackPanel>
</asp:Content>