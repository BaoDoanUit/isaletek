<%@ Page Title="Shop Photos" Language="C#" MasterPageFile="~/Layout.master" AutoEventWireup="true" CodeBehind="DisplayImageControlNew.aspx.cs" Inherits="WebApplication.Pages.DisplayImageControlNew" %>

<%@ Register Src="~/UserControls/DisplayImageDetailNew.ascx" TagPrefix="uc1" TagName="DisplayImageDetail" %>
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
        function monthChanged(s, e) {
            cp.PerformCallback('filter')
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


        var textShopSeparator = ";";
        var valueShopSelect = ';';
        function synchronizeShopListBoxValues(dropDown, args) {
            checkShopListBox.UnselectAll();
            var texts = dropDown.GetText().split(textShopSeparator);
            var values = getShopValuesByTexts(texts);
            checkShopListBox.SelectValues(values);
            ShopupdateText(); // for remove non-existing texts
        }
        function ShopupdateText() {
            var selectedItems = checkShopListBox.GetSelectedItems();
            checkShopComboBox.SetText(getShopSelectedItemsText(selectedItems));
        }
        function getShopSelectedItemsText(items) {
            var texts = [];
            for (var i = 0; i < items.length; i++)
                texts.push(items[i].text);
            return texts.join(textShopSeparator);
        }
        function ShopGetValues() {
            var selectedItems = checkShopListBox.GetSelectedItems();
            var valuesText = getShopSelectedItemsText(selectedItems);
            valueShopSelect = getShopValuesByTexts(valuesText.split(textShopSeparator));
            hdfKey.Set('shopid', valueShopSelect.join());
        }
        function getShopValuesByTexts(texts) {
            valueSelect = '';
            var actualValues = [];
            var item;
            for (var i = 0; i < texts.length; i++) {
                item = checkShopListBox.FindItemByText(texts[i]);
                if (item != null)
                    actualValues.push(item.value);
            }
            return actualValues;
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
        // en dealer
        $(document).ready(function () {
            $('.ckchoose').change(function () {
                var ths = $(this);
                if (kpi.is(':checked') == true) {

                }
            });
        })
    </script>
    <dx:ASPxHiddenField ID="hdfKey" ClientInstanceName="hdfKey" runat="server"></dx:ASPxHiddenField>
    <div class="row filter">
        <div class="col-md-3">
            <fieldset class="scheduler-border">
                <legend class="scheduler-border">Search</legend>
                <div class="row">
                    <div class="col-md-12">
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
                </div>
                <div class="row marginTop20">
                    <div class="col-md-12">
                        <dx:ASPxDropDownEdit ClientInstanceName="checkComboBox" NullText="--All--" Caption="Area" ID="checkRegion" runat="server" AnimationType="None">
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
                </div>
                <div class="row marginTop20">
                    <div class="col-md-12">
                        <dx:ASPxDropDownEdit ClientInstanceName="checkShopComboBox" NullText="--All--" Caption="Shop" ID="checkShopComboBox" runat="server" AnimationType="None">
                            <DropDownWindowTemplate>
                                <dx:ASPxListBox Width="100%" ID="checkShopListBox" ClientInstanceName="checkShopListBox" SelectionMode="CheckColumn" DataSourceID="odsShop"
                                    runat="server" Height="200" EnableSelectAll="true" ValueField="ShopId" TextField="ShopName">
                                    <Border BorderStyle="None" />
                                    <BorderBottom BorderStyle="Solid" BorderWidth="1px" BorderColor="#DCDCDC" />
                                    <ClientSideEvents SelectedIndexChanged="ShopupdateText" Init="ShopupdateText" />
                                </dx:ASPxListBox>
                                <table style="width: 100%">
                                    <tr>
                                        <td style="padding: 4px">
                                            <dx:ASPxButton ID="ASPxButton2" AutoPostBack="False" runat="server" Text="Close" Style="float: right">
                                                <ClientSideEvents Click="function(s, e){ checkShopComboBox.HideDropDown();ShopGetValues(); }" />
                                            </dx:ASPxButton>
                                        </td>
                                    </tr>
                                </table>
                            </DropDownWindowTemplate>
                            <ClientSideEvents TextChanged="synchronizeShopListBoxValues" DropDown="synchronizeShopListBoxValues" />
                        </dx:ASPxDropDownEdit>
                        <asp:ObjectDataSource ID="odsShop" runat="server" SelectMethod="getOutlet_byRegion" TypeName="LogicTier.Controllers.OutletBL">
                            <SelectParameters>
                                <asp:Parameter Name="Year" Type="Int32" />
                                <asp:Parameter Name="Month" Type="Int32" />
                                <asp:Parameter Name="Region" Type="String" />
                            </SelectParameters>
                        </asp:ObjectDataSource>
                    </div>
                </div>
                <div class="row marginTop20">
                    <div class="col-md-12" style="padding-bottom: 10px">
                        <dx:ASPxButton ID="FilterButton" AutoPostBack="false" runat="server" Text="Search">
                            <ClientSideEvents Click="function(s, e) {  cp.PerformCallback('filter'); }"></ClientSideEvents>
                        </dx:ASPxButton>
                        <dx:ASPxButton ID="btnDownload" ClientInstanceName="btnDownload" runat="server"
                            Text="Download" OnClick="btnDownload_Click">
                        </dx:ASPxButton>
                        <dx:ASPxGridViewExporter ID="ASPxGridViewExporter1" runat="server" ExportSelectedRowsOnly="true" GridViewID="gvSale">
                        </dx:ASPxGridViewExporter>
                        <dx:ASPxHyperLink runat="server" ID="hpExport" ClientInstanceName="hpExport" ClientVisible="false"></dx:ASPxHyperLink>
                    </div>
                </div>
            </fieldset>
        </div>
        <div class="col-md-6" style="padding-top: 28px; display: none">
            <dx:ASPxGridView ID="grSummary" runat="server" AutoGenerateColumns="false" Theme="Material" Width="90%">
                <Columns>
                </Columns>
                <Settings VerticalScrollBarStyle="Standard" VerticalScrollableHeight="190" VerticalScrollBarMode="Visible" />
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
            <dx:ASPxCallbackPanel ID="ASPxCallbackPanel1" runat="server" Width="100%"
                ClientInstanceName="cp" OnCallback="ASPxCallbackPanel1_Callback">
                <ClientSideEvents EndCallback="OnEndCallback" />
                <PanelCollection>
                    <dx:PanelContent runat="server">
                        <div class="row marginTop10">
                            <div class="col-md-12">
                                <dx:ASPxButton ID="btnSelectAll" Visible="false" runat="server" Text="Chọn tất cả" UseSubmitBehavior="False"
                                    AutoPostBack="false">
                                    <ClientSideEvents Click="function(s, e) { gvSale.SelectRows(); }" />
                                </dx:ASPxButton>
                                <dx:ASPxButton ID="btnUnselectAll" Visible="false" runat="server" Text="Bỏ chọn" UseSubmitBehavior="False"
                                    AutoPostBack="false">
                                    <ClientSideEvents Click="function(s, e) { gvSale.UnselectRows(); }" />
                                </dx:ASPxButton>
                            </div>
                        </div>
                        <div class="row marginTop10">
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
                                            <uc1:DisplayImageDetail runat="server" shopId='<%#Eval("ShopId") %>' OnLoad="DisplayImageDetail_Load" rpDate='<%#Eval("ReportDate","{0:yyyy-MM-dd}") %>' ID="DisplayImageDetail" />
                                        </DetailRow>
                                    </Templates>
                                    <Columns>
                                        <%--<dx:GridViewCommandColumn Width="40px" ShowSelectCheckbox="True" VisibleIndex="0"/>--%>
                                        <dx:GridViewDataTextColumn FieldName="Dealer" VisibleIndex="1">
                                        </dx:GridViewDataTextColumn>
                                        <dx:GridViewDataTextColumn FieldName="Province" VisibleIndex="2">
                                        </dx:GridViewDataTextColumn>
                                        <dx:GridViewDataComboBoxColumn FieldName="ShopName" VisibleIndex="3">
                                        </dx:GridViewDataComboBoxColumn>
                                        <dx:GridViewDataTextColumn FieldName="ReportDate" VisibleIndex="4">
                                            <PropertiesTextEdit DisplayFormatString="yyyy-MM-dd"></PropertiesTextEdit>
                                        </dx:GridViewDataTextColumn>
                                    </Columns>
                                </dx:ASPxGridView>
                                <asp:ObjectDataSource ID="odsSale" runat="server" SelectMethod="getbyShopNew" TypeName="LogicTier.Controllers.ImageDisplayBL">
                                    <SelectParameters>
                                        <asp:Parameter Name="userName" Type="String" />
                                        <asp:Parameter Name="Year" Type="Int32" />
                                        <asp:Parameter Name="Month" Type="Int32" />
                                        <asp:Parameter Name="FromDate" Type="DateTime" />
                                        <asp:Parameter Name="ToDate" Type="DateTime" />
                                        <asp:Parameter Name="Area" Type="String" />
                                        <asp:Parameter Name="Region" Type="String" />
                                        <asp:Parameter Name="ShopId" Type="String" />
                                        <asp:Parameter Name="Product" Type="String" />
                                        <asp:Parameter Name="ObjectId" Type="String" />
                                    </SelectParameters>
                                </asp:ObjectDataSource>
                            </div>
                        </div>
                    </dx:PanelContent>
                </PanelCollection>
            </dx:ASPxCallbackPanel>
        </div>
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