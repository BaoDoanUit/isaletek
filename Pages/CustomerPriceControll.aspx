<%@ Page Title="Price Controll" Language="C#" MasterPageFile="~/Layout.master" AutoEventWireup="true" CodeBehind="CustomerPriceControll.aspx.cs" Inherits="WebApplication.Pages.CustomerPriceControll" %>
<asp:Content ID="Content1" ContentPlaceHolderID="Content" runat="server">
    <style>
        fieldset.scheduler-border {
            background-color: rgba(227, 229, 229, 0.09);
            border: 1px groove #ddd !important;
            padding: 0 1em 1em 1em !important;
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

        .dxeRadioButtonList_Moderno {
            border: none !important
        }

        .dxeCaption_Moderno {
            font-weight: 600;
        }
        .highcharts-exporting-group,.highcharts-credits{
            display: none
        }
        .dxEditors_edtRadioButtonUnchecked_Moderno {
            background-position: -18px -18px !important;
            width: 18px !important;
            height: 18px !important;
        }
        .dxEditors_edtRadioButtonUnchecked_Moderno,.dxEditors_edtRadioButtonChecked_Moderno {
            background-size: 36px !important;
        }
        .dxEditors_edtRadioButtonChecked_Moderno {
            background-position: 0 0 !important;
            width: 18px !important;
            height: 18px !important;
        }
        .dxeRoot_Moderno td:first-child{
            width: 85px
        }
        .dxeRoot_Moderno td:last-child{
            width: calc(100% - 85px)
        }
        .dxeRadioButtonList_Moderno td{
            width: auto!important
        }
    </style>
    <script>
        function OnEndCallback(s, e) {
            if (s.cpAlert != '') {
                alert(s.cpAlert);
            }
        }
        function monthChanged(s, e) {
            cp.PerformCallback('filter')
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
    <dx:ASPxHiddenField ID="hdfKey" ClientInstanceName="hdfKey" runat="server"></dx:ASPxHiddenField>
    <dx:ASPxCallbackPanel ID="aspCallbackPanel" runat="server" Width="100%" ClientSideEvents-EndCallback="OnEndCallback"
        ClientInstanceName="cp" OnCallback="aspCallbackPanel_Callback">
        <PanelCollection>
            <dx:PanelContent runat="server">
                <div class="row filter">
                    <div class="col-md-12">
                        <fieldset class="scheduler-border">
                            <legend class="scheduler-border">Search</legend>
                            <div class="row">
                                <div class="col-md-3">
                                    <dx:ASPxComboBox Caption="Month *" runat="server" ID="cbMonth" DataSourceID="odsMonth" ValueField="MonthCycle" ValueType="System.String" NullText="--All--"
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
                                    <div style="display: none">
                                        <dx:ASPxComboBox Caption="Term *" runat="server" ID="cbTerm" Width="100%" DataSourceID="odsTerm" ValueField="Id" ValueType="System.Int32" NullText="--ALL--"
                                            ClientInstanceName="cbTerm" DropDownStyle="DropDownList">
                                            <ClearButton DisplayMode="OnHover"></ClearButton>
                                            <ClientSideEvents ValueChanged="function(s,e){cbWeek.PerformCallback()}" />
                                            <Columns>
                                                <dx:ListBoxColumn FieldName="TermCycle" Caption="Term" />
                                            </Columns>
                                        </dx:ASPxComboBox>
                                        <asp:ObjectDataSource ID="odsTerm" runat="server" SelectMethod="getList" TypeName="LogicTier.Controllers.TermController"></asp:ObjectDataSource>
                                    </div>
                                </div>
                                <div class="col-md-3" style="display: none">
                                    <dx:ASPxDropDownEdit ClientInstanceName="checkComboBoxAccount" NullText="--All--" Caption="Dealer" ID="checkComboBoxAccount" runat="server" AnimationType="None">
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
                                <div class="col-md-3" style="padding-bottom: 10px">
                                    <dx:ASPxButton ID="FilterButton" AutoPostBack="false" Visible="false" runat="server" Text="Search">
                                        <ClientSideEvents Click="function(s, e) {  cp.PerformCallback('filter'); }"></ClientSideEvents>
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
                </div>
                <div class="row">
                    <div class="col-md-12" style="position: relative">
                        <dx:ASPxGridView ID="grPrice" runat="server" AutoGenerateColumns="false" Theme="Material" Width="100%">
                            <Columns>
                            </Columns>
                            <Settings HorizontalScrollBarMode="Visible" VerticalScrollBarStyle="Standard" VerticalScrollableHeight="350" VerticalScrollBarMode="Visible" />
                            <SettingsBehavior AllowSort="true" ColumnResizeMode="Control" />
                            <Styles>
                                <Header HorizontalAlign="Center" Wrap="True" Paddings-Padding="3px"></Header>
                                <Cell Wrap="True" VerticalAlign="Middle" Paddings-Padding="5px"></Cell>
                            </Styles>
                            <SettingsPager Mode="ShowAllRecords"></SettingsPager>
                        </dx:ASPxGridView>
                    </div>
                </div>
            </dx:PanelContent>
        </PanelCollection>
    </dx:ASPxCallbackPanel>
</asp:Content>