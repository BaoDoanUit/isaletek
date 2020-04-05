<%@ Page Title="Display Reports" Language="C#" MasterPageFile="~/Layout.master" AutoEventWireup="true" CodeBehind="CustomerDisplay.aspx.cs" Inherits="WebApplication.Pages.CustomerDisplay" %>

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

        .dxeRadioButtonList_Moderno {
            border: none !important
        }

        .dxeCaption_Moderno {
            font-weight: 600;
        }

        .highcharts-exporting-group, .highcharts-credits {
            display: none
        }

        .dxEditors_edtRadioButtonUnchecked_Moderno {
            background-position: -18px -18px !important;
            width: 18px !important;
            height: 18px !important;
        }

        .dxEditors_edtRadioButtonUnchecked_Moderno, .dxEditors_edtRadioButtonChecked_Moderno {
            background-size: 36px !important;
        }

        .dxEditors_edtRadioButtonChecked_Moderno {
            background-position: 0 0 !important;
            width: 18px !important;
            height: 18px !important;
        }

        .dxeRoot_Moderno td:first-child {
            width: 20%
        }

        .dxeRoot_Moderno td:last-child {
            width: calc(100% - 20%)
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
    </script>
    <dx:ASPxCallbackPanel ID="aspCallbackPanel" runat="server" Width="100%" ClientSideEvents-EndCallback="OnEndCallback"
        ClientInstanceName="aspCallbackPanel" OnCallback="aspCallbackPanel_Callback">
        <PanelCollection>
            <dx:PanelContent runat="server">
                <div class="row  filter">
                    <div class="col-md-4">
                        <fieldset class="scheduler-border ">
                            <legend class="scheduler-border">Search</legend>
                            <div class="row" style="display: none">
                                <div class="col-md-12">
                                    <dx:ASPxComboBox Caption="Term *" runat="server" ID="cbTerm" DataSourceID="odsTerm" ValueField="Id" ValueType="System.Int32" NullText="--ALL--"
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
                            <div class="row">
                                <div class="col-md-12">
                                    <dx:ASPxComboBox Caption="Week *" Width="100%" runat="server" ID="cbWeek" DataSourceID="odsWeek" ValueField="WeekByYear" ValueType="System.Int32" NullText="--ALL--"
                                        ClientInstanceName="cbWeek" EnableCallbackMode="true" DropDownStyle="DropDownList">
                                        <ClearButton DisplayMode="OnHover"></ClearButton>
                                        <Columns>
                                            <dx:ListBoxColumn FieldName="WeekCycle" />
                                        </Columns>
                                    </dx:ASPxComboBox>
                                    <asp:ObjectDataSource ID="odsWeek" runat="server" SelectMethod="getWeek" TypeName="LogicTier.Controllers.TermController">
                                        <SelectParameters>
                                            <asp:ControlParameter ControlID="cbTerm" DbType="Int32" Name="Id" PropertyName="Value" />
                                        </SelectParameters>
                                    </asp:ObjectDataSource>
                                </div>
                            </div>
                            <div class="row" style="display: none">
                                <div class="col-md-6">
                                    <dx:ASPxComboBox Caption="Area" runat="server" Width="100%" ID="cbArea" DataSourceID="odsArea" ValueField="Area" ValueType="System.String" NullText="--ALL--"
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
                                <div class="col-md-3" style="display: none">
                                    <dx:ASPxComboBox runat="server" ID="cbAccount" Caption="Dealer" ValueType="System.Int32" Width="100%" NullText="--ALL--"
                                        DataSourceID="odsAccount" TextField="Account" ValueField="ObjectId"
                                        ClientInstanceName="cbAccount" CallbackPageSize="10">
                                        <ClearButton DisplayMode="OnHover"></ClearButton>
                                    </dx:ASPxComboBox>
                                    <asp:ObjectDataSource ID="odsAccount" runat="server" SelectMethod="getAccountGroup" TypeName="LogicTier.Controllers.SaleOutBL"></asp:ObjectDataSource>
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
                            <div class="row marginTop10">
                                <div class="col-md-12">
                                    <dx:ASPxRadioButtonList runat="server" Caption="Product *" ID="rdProduct" Width="100%" RepeatColumns="2" DataSourceID="odsProduct" ValueField="Product" dis TextField="Product" RepeatDirection="Vertical">
                                        <RadioButtonStyle Font-Size="10px"></RadioButtonStyle>
                                    </dx:ASPxRadioButtonList>
                                    <asp:ObjectDataSource ID="odsProduct" runat="server" SelectMethod="getDivision" TypeName="LogicTier.Controllers.ProductsBL">
                                        <SelectParameters>
                                            <asp:Parameter DefaultValue="Product" Name="fieldName" Type="String" />
                                            <asp:Parameter Name="fieldValue" Type="String" />
                                            <asp:Parameter DefaultValue="Product" Name="fieldDisplay" Type="String" />
                                        </SelectParameters>
                                    </asp:ObjectDataSource>
                                </div>
                            </div>
                            <div class="row marginTop10">
                                <div class="col-md-12">
                                    <dx:ASPxButton ID="FilterButton" AutoPostBack="false" runat="server" Text="Search">
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
                    <div class="col-md-8" style="padding-top: 28px">
                        <dx:ASPxGridView ID="grDisplayWeek" runat="server" 
                            AutoGenerateColumns="false" Theme="Material" Width="100%">
                            <Columns>
                            </Columns>
                            <Settings HorizontalScrollBarMode="Visible" VerticalScrollBarStyle="Standard" VerticalScrollableHeight="220" VerticalScrollBarMode="Visible" />
                            <SettingsBehavior AllowSort="true" ColumnResizeMode="Control" />
                            <Styles>
                                <Header HorizontalAlign="Center" Wrap="True" Paddings-Padding="3px"></Header>
                                <Cell Wrap="True" VerticalAlign="Middle" Paddings-Padding="5px"></Cell>
                            </Styles>
                            <SettingsPager PageSize="200000"></SettingsPager>
                        </dx:ASPxGridView>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-12">
                        <dx:ASPxGridView ID="grData" runat="server" 
                            AutoGenerateColumns="false" Theme="Material" 
                            OnLoad="grData_Load" Width="1140px">
                            <Columns>
                            </Columns>
                            <Settings HorizontalScrollBarMode="Visible" VerticalScrollBarStyle="Standard" VerticalScrollableHeight="370" VerticalScrollBarMode="Visible" />
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