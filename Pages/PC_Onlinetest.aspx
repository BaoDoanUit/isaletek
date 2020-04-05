<%@ Page Title="Online Testing" Language="C#" MasterPageFile="~/Layout.master" AutoEventWireup="true" CodeBehind="PC_Onlinetest.aspx.cs" Inherits="WebApplication.Pages.PC_Onlinetest" %>

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
        .tb2 tr td:first-child{
            width: 110px
        }
        .tb2 tr td:last-child{
            padding-left: 10px
        }
        .table > thead > tr > td{
            padding: 15px 8px;
        }
        .table > thead > tr:last-child > td{
            font-weight: 600;
        }
    </style>
    <script>
        function OnEndCallback(s, e) {
            if (s.cpAlert != null && s.cpAlert != '') {
                alert(s.cpAlert);
            }
        }
        function monthChanged(s, e) {
            aspCallbackPanel.PerformCallback('month|' + s.GetValue())
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
        // star dealer
        var textSeparatorAccount = ";";
        var valueSelectAccount = ';';
        function updateTextAccount() {
            var selectedItems = checkListBoxAccount.GetSelectedItems();
            checkComboBoxAccount.SetText(getSelectedItemsTextAccount(selectedItems));
        }
        function synchronizeListBoxValues(dropDown, args) {
            checkListBoxAccount.UnselectAll();
            var texts = dropDown.GetText().split(textSeparatorAccount);
            var values = getValuesByTextsAccount(texts);
            checkListBoxAccount.SelectValues(values);
            updateTextAccount(); // for remove non-existing texts
        }
        function getSelectedItemsTextAccount(items) {
            var texts = [];
            for (var i = 0; i < items.length; i++)
                texts.push(items[i].text);
            return texts.join(textSeparatorAccount);
        }
        function getValuesByTextsAccount(texts) {
            valueSelectAccount = '';
            var actualValues = [];
            var item;
            for (var i = 0; i < texts.length; i++) {
                item = checkListBoxAccount.FindItemByText(texts[i]);
                if (item != null)
                    actualValues.push(item.value);
            }
            return actualValues;
        }
        function GetValuesAccount() {
            var selectedItems = checkListBoxAccount.GetSelectedItems();
            var valuesText = getSelectedItemsTextAccount(selectedItems);
            valueSelectAccount = getValuesByTextsAccount(valuesText.split(textSeparatorAccount));
            hdfKey.Set('account', valueSelectAccount.join());
        }
        // end dealer
    </script>
    <div class="row filter">
        <div class="col-md-4">
            <fieldset class="scheduler-border ">
                <legend class="scheduler-border">Search</legend>
                <div class="row marginTop20">
                    <div class="col-md-12">
                        <dx:ASPxComboBox Caption="Month *" runat="server" Width="100%" ID="cbMonth" DataSourceID="odsMonth" ValueField="MonthCycle" ValueType="System.String" NullText="--All--"
                            ClientInstanceName="cbMonth" EnableCallbackMode="true" DropDownStyle="DropDownList">
                            <ClientSideEvents ValueChanged="monthChanged" />
                            <ClearButton DisplayMode="OnHover"></ClearButton>
                            <Columns>
                                <dx:ListBoxColumn FieldName="MonthCycle" Caption="Month" />
                            </Columns>
                        </dx:ASPxComboBox>
                        <asp:ObjectDataSource ID="odsMonth" runat="server" SelectMethod="getMonth" TypeName="LogicTier.Controllers.TermController">
                            <SelectParameters>
                                <asp:ControlParameter ControlID="cbTerm" DbType="Int32" Name="Id" PropertyName="Value" />
                            </SelectParameters>
                        </asp:ObjectDataSource>
                    </div>
                </div>
                <div class="row marginTop20">
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
                                <asp:Parameter Name="Area" Type="String" />
                            </SelectParameters>
                        </asp:ObjectDataSource>
                    </div>
                </div>
                <div class="row marginTop20">
                    <div class="col-md-12">
                        <dx:ASPxDropDownEdit ClientInstanceName="checkComboBoxAccount" Width="100%" NullText="--All--" Caption="Dealer" ID="checkComboBoxAccount" runat="server" AnimationType="None">
                            <DropDownWindowTemplate>
                                <dx:ASPxListBox Width="100%" ID="listBoxAccount" ClientInstanceName="checkListBoxAccount" SelectionMode="CheckColumn" DataSourceID="odsAccount"
                                    runat="server" Height="200" EnableSelectAll="true" ValueField="ObjectId" TextField="Account">
                                    <Border BorderStyle="None" />
                                    <BorderBottom BorderStyle="Solid" BorderWidth="1px" BorderColor="#DCDCDC" />
                                    <ClientSideEvents SelectedIndexChanged="updateTextAccount" Init="updateTextAccount" />
                                </dx:ASPxListBox>
                                <table style="width: 100%">
                                    <tr>
                                        <td style="padding: 4px">
                                            <dx:ASPxButton ID="ASPxButton2" AutoPostBack="False" runat="server" Text="Close" Style="float: right">
                                                <ClientSideEvents Click="function(s, e){ checkComboBoxAccount.HideDropDown();GetValuesAccount(); }" />
                                            </dx:ASPxButton>
                                        </td>
                                    </tr>
                                </table>
                            </DropDownWindowTemplate>
                            <ClientSideEvents TextChanged="synchronizeListBoxValues" DropDown="synchronizeListBoxValues" />
                        </dx:ASPxDropDownEdit>
                        <asp:ObjectDataSource ID="odsAccount" runat="server" SelectMethod="getAccountGroup" TypeName="LogicTier.Controllers.SaleOutBL"></asp:ObjectDataSource>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-4" style="display: none">
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
                    <div class="col-md-4" style="display: none">
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
                <div class="row marginTop20">
                    <div class="col-md-12">
                        <dx:ASPxButton ID="FilterButton" AutoPostBack="false" runat="server" Text="Search" Style="float: left; margin-right: 10px;">
                            <ClientSideEvents Click="function(s, e) {  aspCallbackPanel.PerformCallback('filter'); }"></ClientSideEvents>
                        </dx:ASPxButton>
                        <dx:ASPxButton ID="ASPxButton1" AutoPostBack="false" runat="server" Text="Download">
                            <ClientSideEvents Click="function(s, e) {  ImageExcelCallbackPanel.PerformCallback(); }"></ClientSideEvents>
                        </dx:ASPxButton>
                        <dx:ASPxCallbackPanel runat="server" ID="ImageExcelCallbackPanel" Style="float: right; margin-right: 10px; margin-top: 5px;" ClientInstanceName="ImageExcelCallbackPanel"
                            OnCallback="ImageExcelCallbackPanel_Callback" SettingsLoadingPanel-Text="Exporting Data, please wait.">
                            <ClientSideEvents EndCallback="OnEndCallback" />
                            <PanelCollection>
                                <dx:PanelContent ID="PanelContent3" runat="server">
                                    <asp:HyperLink ID="hplexcel" runat="server"></asp:HyperLink>
                                </dx:PanelContent>
                            </PanelCollection>
                        </dx:ASPxCallbackPanel>
                    </div>
                </div>
            </fieldset>
        </div>
        <div class="col-md-8">
            <div class="row marginTop10">
                <div class="col-md-6">
                    <asp:Literal ID="ltrsum2" runat="server"></asp:Literal>
                </div>
                <div class="col-md-6">
                    <dx:ASPxGridView ID="grsum1" runat="server" AutoGenerateColumns="false" Theme="Material" Width="100%">
                        <Columns>
                            <dx:GridViewDataTextColumn FieldName="Area" Caption="Area" VisibleIndex="0"></dx:GridViewDataTextColumn>
                            <dx:GridViewDataTextColumn FieldName="NotYet" Caption="Not Yet" VisibleIndex="1"></dx:GridViewDataTextColumn>
                            <dx:GridViewDataTextColumn FieldName="Finish" Caption="Finish" VisibleIndex="2"></dx:GridViewDataTextColumn>
                        </Columns>
                        <Settings VerticalScrollableHeight="240" VerticalScrollBarMode="Visible" />
                        <SettingsBehavior AllowSort="false" />
                        <Styles>
                            <Header HorizontalAlign="Center" Wrap="True" Paddings-Padding="3px"></Header>
                            <Cell Wrap="True" VerticalAlign="Middle" Paddings-Padding="5px"></Cell>
                        </Styles>
                    </dx:ASPxGridView>
                    <asp:Literal ID="ltrsum1" runat="server"></asp:Literal>
                </div>
            </div>
        </div>
    </div>
    <dx:ASPxCallbackPanel ID="aspCallbackPanel" runat="server" Width="100%" ClientSideEvents-EndCallback="OnEndCallback"
        ClientInstanceName="aspCallbackPanel" OnCallback="aspCallbackPanel_Callback">
        <PanelCollection>
            <dx:PanelContent runat="server">
                <div class="row marginTop20">
                    <div class="col-md-12">
                        <dx:ASPxGridView ID="grData" runat="server" AutoGenerateColumns="false" Theme="Material" OnLoad="grData_Load" Width="1140px">
                            <Columns>
                            </Columns>
                            <Settings VerticalScrollableHeight="350" VerticalScrollBarMode="Visible" />
                            <SettingsBehavior AllowSort="true" ColumnResizeMode="Control" />
                            <Styles>
                                <Header HorizontalAlign="Center" Wrap="True" Paddings-Padding="3px"></Header>
                                <Cell Wrap="True" VerticalAlign="Middle" Paddings-Padding="5px"></Cell>
                            </Styles>
                            <SettingsPager PageSize="200000"></SettingsPager>
                        </dx:ASPxGridView>
                    </div>
                </div>
            </dx:PanelContent>
        </PanelCollection>
    </dx:ASPxCallbackPanel>
    <dx:ASPxHiddenField ID="hdfKey" ClientInstanceName="hdfKey" runat="server"></dx:ASPxHiddenField>
</asp:Content>