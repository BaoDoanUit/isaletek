<%@ Page Title="Price Control" Language="C#" MasterPageFile="~/Layout.master"
    AutoEventWireup="true" CodeBehind="PriceControl.aspx.cs" Inherits="WebApplication.Pages.PriceControl" %>

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
            width: 85px
        }

        .dxeRoot_Moderno td:last-child {
            width: calc(100% - 85px)
        }

        .dxeRadioButtonList_Moderno td {
            width: auto !important
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

        function ShowDetail(ProductId, Dealer, Model) {
            cpDetail.PerformCallback(ProductId + '_' + Dealer);
            console.log(ProductId);
            console.log(Dealer);
            popDetail.SetHeaderText(Model);
            popDetail.Show();

        }

        function cpPriceDelete_End(s, e) {
            var msg = s.cpAlert;
            switch (msg) {
                case 'delete':
                    alert('Xóa thành công')
                    break;
                case 'filter':
                    break;
                default:
                    alert(msg);
                    break;
            }
        }
        function Delete(id) {
            if (confirm('Bạn muốn xóa báo cáo này'))
                cpPriceDelete.PerformCallback('delete_' + id);
        }
    </script>
    <dx:ASPxHiddenField ID="hdfKey" ClientInstanceName="hdfKey" runat="server"></dx:ASPxHiddenField>
    <dx:ASPxCallbackPanel ID="aspCallbackPanel" runat="server" Width="100%"
        ClientSideEvents-EndCallback="OnEndCallback"
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
                                    <dx:ASPxButton ID="DeleteButton" CssClass="btn btn-warning"
                                        Visible="false" AutoPostBack="false"
                                        runat="server" Text="Delete">
                                        <ClientSideEvents Click="function(s, e) {  popDelete.Show(); }"></ClientSideEvents>
                                    </dx:ASPxButton>
                                    <dx:ASPxButton ID="ASPxButton1" AutoPostBack="false" runat="server" Text="Download">
                                        <ClientSideEvents Click="function(s, e) {  ImageExcelCallbackPanel.PerformCallback(); }"></ClientSideEvents>
                                    </dx:ASPxButton>
                                    <dx:ASPxCallbackPanel runat="server" ID="ImageExcelCallbackPanel"
                                        Style="float: right; margin-right: 10px; margin-top: 5px;"
                                        ClientInstanceName="ImageExcelCallbackPanel"
                                        OnCallback="ImageExcelCallbackPanel_Callback"
                                        SettingsLoadingPanel-Text="Exporting Data, please wait.">
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
                        <a style="position: absolute; right: 3%; top: -18px; z-index: 99999;">(KVND)</a>
                        <dx:ASPxGridView ID="grReportPrice"
                            runat="server" DataSourceID="odsReportPrice"
                            AutoGenerateColumns="false" Theme="Material" Width="100%">
                            <Columns>
                                <dx:GridViewDataColumn FieldName="Product" Width="100" CellStyle-HorizontalAlign="Center">
                                    <Settings AllowFilterBySearchPanel="True"
                                        AllowHeaderFilter="True" AutoFilterCondition="Contains" />
                                </dx:GridViewDataColumn>
                                <dx:GridViewDataColumn FieldName="Range" Width="150" CellStyle-HorizontalAlign="Center">
                                    <Settings AllowFilterBySearchPanel="True"
                                        AllowHeaderFilter="True" AutoFilterCondition="Contains" />
                                </dx:GridViewDataColumn>
                                <dx:GridViewDataColumn FieldName="Model" Width="150" CellStyle-HorizontalAlign="Center">
                                    <Settings AllowFilterBySearchPanel="True"
                                        AllowHeaderFilter="True" AutoFilterCondition="Contains" />
                                </dx:GridViewDataColumn>
                                <dx:GridViewDataColumn FieldName="Capacity" Width="100" CellStyle-HorizontalAlign="Center">
                                    <Settings AllowFilterBySearchPanel="True"
                                        AllowHeaderFilter="True" AutoFilterCondition="Contains" />
                                </dx:GridViewDataColumn>
                                <dx:GridViewDataColumn Caption="Nguyen Kim" CellStyle-HorizontalAlign="Center">

                                    <DataItemTemplate>
                                        <a onclick="ShowDetail(<%#Eval("ProductId")%>,'Nguyen Kim','<%#Eval("Model") %>')"><%#BindMoney(Eval("Nguyen Kim")) %></a>
                                    </DataItemTemplate>
                                </dx:GridViewDataColumn>
                                <dx:GridViewDataColumn Caption="Cho Lon" CellStyle-HorizontalAlign="Center">

                                    <DataItemTemplate>
                                        <a onclick="ShowDetail(<%#Eval("ProductId")%>,'Cho Lon', '<%#Eval("Model") %>')"><%#BindMoney(Eval("Cho Lon")) %></a>
                                    </DataItemTemplate>
                                </dx:GridViewDataColumn>
                                <dx:GridViewDataColumn Caption="Media Mart" CellStyle-HorizontalAlign="Center">

                                    <DataItemTemplate>
                                        <a onclick="ShowDetail(<%#Eval("ProductId")%>,'Media Mart', '<%#Eval("Model")%>')"><%#BindMoney(Eval("Media Mart")) %></a>
                                    </DataItemTemplate>
                                </dx:GridViewDataColumn>
                                <dx:GridViewDataColumn FieldName="HC" CellStyle-HorizontalAlign="Center">

                                    <DataItemTemplate>
                                        <a onclick="ShowDetail(<%#Eval("ProductId")%>,'HC','<%#Eval("Model") %>')"><%#BindMoney(Eval("HC")) %></a>
                                    </DataItemTemplate>
                                </dx:GridViewDataColumn>
                                <dx:GridViewDataColumn FieldName="Pico" CellStyle-HorizontalAlign="Center">
                                    <DataItemTemplate>
                                        <a onclick="ShowDetail(<%#Eval("ProductId")%>,'Pico', '<%#Eval("Model") %>')"><%#BindMoney(Eval("Pico")) %></a>
                                    </DataItemTemplate>
                                </dx:GridViewDataColumn>
                                <dx:GridViewDataColumn FieldName="Thien Hoa" CellStyle-HorizontalAlign="Center">
                                    <DataItemTemplate>
                                        <a onclick="ShowDetail(<%#Eval("ProductId")%>,'Thien Hoa', '<%#Eval("Model") %>')"><%#BindMoney(Eval("Thien Hoa")) %></a>
                                    </DataItemTemplate>
                                </dx:GridViewDataColumn>
                                <dx:GridViewDataColumn FieldName="AEON" CellStyle-HorizontalAlign="Center">
                                    <DataItemTemplate>
                                        <a onclick="ShowDetail(<%#Eval("ProductId")%>,'AEON', '<%#Eval("Model") %>')"><%#BindMoney(Eval("AEON")) %></a>
                                    </DataItemTemplate>
                                </dx:GridViewDataColumn>
                                <dx:GridViewDataColumn FieldName="Papamama" CellStyle-HorizontalAlign="Center">
                                    <DataItemTemplate>
                                        <a onclick="ShowDetail(<%#Eval("ProductId")%>,'Papamama', '<%#Eval("Model") %>')"><%#BindMoney(Eval("Papamama")) %></a>
                                    </DataItemTemplate>
                                </dx:GridViewDataColumn>
                            </Columns>
                            <Settings VerticalScrollBarStyle="Standard" VerticalScrollableHeight="350"
                                VerticalScrollBarMode="Visible" />
                            <SettingsBehavior AllowSort="true" ColumnResizeMode="Control" />
                            <Styles>
                                <Header HorizontalAlign="Center" Wrap="True" Paddings-Padding="3px"></Header>
                                <Cell Wrap="True" VerticalAlign="Middle" Paddings-Padding="5px"></Cell>
                            </Styles>
                            <SettingsPager Mode="ShowAllRecords"></SettingsPager>
                        </dx:ASPxGridView>
                        <asp:ObjectDataSource runat="server" ID="odsReportPrice"
                            SelectMethod="GetPriceReportByDealer"
                            TypeName="LogicTier.Controllers.ReportPriceBL">
                            <SelectParameters>
                                <asp:Parameter Name="Month" />
                                <asp:Parameter Name="Year" />
                                <asp:Parameter Name="Product" DefaultValue="" ConvertEmptyStringToNull="true" />
                            </SelectParameters>
                        </asp:ObjectDataSource>
                    </div>
                </div>
            </dx:PanelContent>
        </PanelCollection>
    </dx:ASPxCallbackPanel>


    <dx:ASPxPopupControl ID="popDetail" runat="server" Width="1000"
        CloseAction="CloseButton" CloseOnEscape="true" Modal="True"
        PopupHorizontalAlign="WindowCenter" PopupVerticalAlign="WindowCenter" ClientInstanceName="popDetail"
        HeaderText="Price Activities" AllowDragging="True" PopupAnimationType="None"
        EnableViewState="False" AutoUpdatePosition="true">
        <ContentCollection>
            <dx:PopupControlContentControl runat="server">
                <dx:ASPxCallbackPanel ID="cpDetail" ClientInstanceName="cpDetail" runat="server" OnCallback="cpDetail_Callback">
                    <PanelCollection>
                        <dx:PanelContent runat="server">
                            <dx:ASPxLabel runat="server" ID="lbInfoDetail"></dx:ASPxLabel>
                            <dx:ASPxGridView ID="grReportPriceDetail"
                                runat="server" DataSourceID="odsReportPriceDetail"
                                AutoGenerateColumns="false" Theme="Material" Width="100%">
                                <Columns>
                                    <dx:GridViewDataColumn FieldName="Region">
                                    </dx:GridViewDataColumn>
                                    <dx:GridViewDataColumn FieldName="ShopName"></dx:GridViewDataColumn>
                                    <dx:GridViewDataColumn FieldName="ReportDate"></dx:GridViewDataColumn>
                                    <dx:GridViewDataTextColumn FieldName="MarketPrice"
                                        PropertiesTextEdit-DisplayFormatString="{0:#,##}" CellStyle-HorizontalAlign="Center"
                                        Caption="Selling Price">
                                    </dx:GridViewDataTextColumn>

                                    <dx:GridViewDataColumn FieldName="GiftName" Caption="Gift"></dx:GridViewDataColumn>
                                    <dx:GridViewDataTextColumn FieldName="GiftPrice" Caption="Gift Cost"
                                        PropertiesTextEdit-DisplayFormatString="{0:#,##}" CellStyle-HorizontalAlign="Center">
                                    </dx:GridViewDataTextColumn>
                                    <dx:GridViewDataTextColumn FieldName="NetPrice"
                                        PropertiesTextEdit-DisplayFormatString="{0:#,##}" CellStyle-HorizontalAlign="Center">
                                    </dx:GridViewDataTextColumn>
                                    <dx:GridViewDataColumn FieldName="Noted"></dx:GridViewDataColumn>

                                </Columns>
                                <Settings VerticalScrollBarStyle="Standard" VerticalScrollableHeight="350" VerticalScrollBarMode="Visible" />
                                <SettingsBehavior AllowSort="true" ColumnResizeMode="Control" />
                                <Styles>
                                    <Header HorizontalAlign="Center" Wrap="True" Paddings-Padding="3px"></Header>
                                    <Cell Wrap="True" VerticalAlign="Middle" Paddings-Padding="5px"></Cell>
                                </Styles>
                                <SettingsPager Mode="ShowAllRecords"></SettingsPager>
                            </dx:ASPxGridView>
                            <asp:ObjectDataSource runat="server" ID="odsReportPriceDetail"
                                SelectMethod="GetPriceReportByDealerDetail"
                                TypeName="LogicTier.Controllers.ReportPriceBL">
                                <SelectParameters>
                                    <asp:Parameter Name="Month" />
                                    <asp:Parameter Name="Year" />
                                    <asp:Parameter Name="ProductId" />
                                    <asp:Parameter Name="ObjectName" />
                                </SelectParameters>
                            </asp:ObjectDataSource>
                        </dx:PanelContent>
                    </PanelCollection>
                </dx:ASPxCallbackPanel>
            </dx:PopupControlContentControl>
        </ContentCollection>
        <ContentStyle>
            <Paddings PaddingBottom="5px" />
        </ContentStyle>
    </dx:ASPxPopupControl>

    <dx:ASPxPopupControl ID="popDelete" runat="server" Width="1000"
        CloseAction="CloseButton" CloseOnEscape="true" Modal="True"
        PopupHorizontalAlign="WindowCenter" PopupVerticalAlign="WindowCenter" ClientInstanceName="popDelete"
        HeaderText="Delete Prices Activities" AllowDragging="True" PopupAnimationType="None"
        EnableViewState="False" AutoUpdatePosition="true">
        <ContentCollection>
            <dx:PopupControlContentControl>
                <div class="row filter">
                    <div class="col-md-12">
                        <fieldset class="scheduler-border">
                            <legend class="scheduler-border">Search</legend>
                            <div class="row">
                                <div class="col-md-3">
                                    <dx:ASPxComboBox Caption="Month *" runat="server"
                                        ID="cbMonthDelete"
                                        DataSourceID="odsMonthDelete" ValueField="MonthCycle" ValueType="System.String" NullText="--All--"
                                        ClientInstanceName="cbMonthDelete" EnableCallbackMode="true" DropDownStyle="DropDownList">
                                        <ClearButton DisplayMode="OnHover"></ClearButton>
                                        <Columns>
                                            <dx:ListBoxColumn FieldName="MonthCycle" Caption="Month" />
                                        </Columns>
                                    </dx:ASPxComboBox>
                                    <asp:ObjectDataSource ID="odsMonthDelete" runat="server" SelectMethod="getMonth" TypeName="LogicTier.Controllers.TermController">
                                        <SelectParameters>
                                            <asp:ControlParameter ControlID="cbTermDelete" DbType="Int32" Name="Id" PropertyName="Value" />
                                        </SelectParameters>
                                    </asp:ObjectDataSource>
                                    <div style="display: none">
                                        <dx:ASPxComboBox Caption="Term *" runat="server" ID="cbTermDelete"
                                            Width="100%" DataSourceID="odsTermDelete" ValueField="Id" ValueType="System.Int32" NullText="--ALL--"
                                            ClientInstanceName="cbTermDelete" DropDownStyle="DropDownList">
                                            <ClearButton DisplayMode="OnHover"></ClearButton>
                                            <Columns>
                                                <dx:ListBoxColumn FieldName="TermCycle" Caption="Term" />
                                            </Columns>
                                        </dx:ASPxComboBox>
                                        <asp:ObjectDataSource ID="odsTermDelete" runat="server" SelectMethod="getList" TypeName="LogicTier.Controllers.TermController"></asp:ObjectDataSource>
                                    </div>
                                </div>
                                <div class="col-md-3">
                                    <dx:ASPxComboBox runat="server" ID="cbOutlet"
                                        ValueField="ShopId" Caption="Oultet *"
                                        ValueType="System.Int32" NullText="Choose to filter by Outlet"
                                        ClientInstanceName="cbOutlet" DataSourceID="odsOutlet"
                                        IncrementalFilteringMode="Contains" TextFormatString="{0}"
                                        DropDownStyle="DropDownList">
                                        <ClearButton DisplayMode="OnHover"></ClearButton>
                                        <Columns>
                                            <dx:ListBoxColumn FieldName="ShopName" Width="250px" />
                                        </Columns>
                                    </dx:ASPxComboBox>
                                    <asp:ObjectDataSource ID="odsOutlet" runat="server" SelectMethod="getOutletWithReference" TypeName="LogicTier.Controllers.OutletBL">
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

                                </div>
                                <div class="col-md-3">
                                    <dx:ASPxComboBox runat="server" ID="cbModel" Width="100%" ValueType="System.Int32" NullText="Chọn Model"
                                        DataSourceID="odsModel" ValueField="ProductId"
                                        Caption="Model *"
                                        ClientInstanceName="cbModel"
                                        IncrementalFilteringMode="Contains" TextFormatString="{0}" DropDownStyle="DropDownList">
                                        <ClearButton DisplayMode="OnHover"></ClearButton>
                                        <Columns>
                                            <dx:ListBoxColumn FieldName="Model" />
                                        </Columns>
                                    </dx:ASPxComboBox>
                                    <asp:ObjectDataSource ID="odsModel" runat="server" SelectMethod="getList" TypeName="LogicTier.Controllers.ProductsBL">
                                        <SelectParameters>
                                            <asp:Parameter Name="productId" Type="Int32" DefaultValue="" ConvertEmptyStringToNull="true" />
                                            <asp:Parameter Name="product" Type="String" DefaultValue="" ConvertEmptyStringToNull="true" />
                                            <asp:Parameter Name="range" Type="String" DefaultValue="" ConvertEmptyStringToNull="true" />
                                            <asp:Parameter Name="model" Type="String" DefaultValue="" ConvertEmptyStringToNull="true" />
                                            <asp:Parameter Name="capacity" Type="String" DefaultValue="" ConvertEmptyStringToNull="true" />
                                            <asp:Parameter Name="type" Type="String" DefaultValue="" ConvertEmptyStringToNull="true" />
                                            <asp:Parameter Name="status" Type="Boolean" DefaultValue="" ConvertEmptyStringToNull="true" />
                                        </SelectParameters>
                                    </asp:ObjectDataSource>
                                </div>
                                <div class="col-md-3">
                                    <dx:ASPxButton ID="btnSearch" AutoPostBack="false" runat="server" Text="Search">
                                        <ClientSideEvents Click="function(s, e) {  cpPriceDelete.PerformCallback('filter'); }"></ClientSideEvents>
                                    </dx:ASPxButton>
                                </div>
                            </div>
                        </fieldset>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-12">
                        <dx:ASPxCallbackPanel ID="cpPriceDelete"
                            ClientInstanceName="cpPriceDelete"
                            runat="server" OnCallback="cpPriceDelete_Callback"
                            Width="100%">
                            <ClientSideEvents EndCallback="cpPriceDelete_End" />
                            <PanelCollection>
                                <dx:PanelContent>
                                    <dx:ASPxGridView runat="server"
                                        ID="grPriceReportDelete" Width="100%"
                                        OnLoad="grPriceReportDelete_Load"
                                        DataSourceID="odsPriceReportDelete">
                                        <Columns>
                                            <dx:GridViewDataColumn FieldName="ShopName"></dx:GridViewDataColumn>
                                            <dx:GridViewDataColumn FieldName="EmployeeName"></dx:GridViewDataColumn>
                                            <dx:GridViewDataColumn FieldName="ReportDate"></dx:GridViewDataColumn>
                                            <dx:GridViewDataColumn FieldName="Model"></dx:GridViewDataColumn>
                                            <dx:GridViewDataColumn FieldName="NetPrice"></dx:GridViewDataColumn>
                                            <dx:GridViewDataColumn FieldName="MarketPrice"></dx:GridViewDataColumn>
                                            <dx:GridViewDataColumn>
                                                <DataItemTemplate>
                                                    <a onclick="javascript: Delete(<%#Eval("Id") %>)"
                                                        style="width: 50%; padding: 5px; cursor: pointer">
                                                        <i class="fa fa-trash-o" style="margin: 0;"></i>
                                                    </a>
                                                </DataItemTemplate>
                                            </dx:GridViewDataColumn>
                                        </Columns>
                                    </dx:ASPxGridView>
                                    <asp:ObjectDataSource ID="odsPriceReportDelete"
                                        SelectMethod="GetRows" runat="server"
                                        TypeName="LogicTier.Controllers.ReportPriceBL">
                                        <SelectParameters>
                                            <asp:Parameter Name="ProductId" />
                                            <asp:Parameter Name="ShopId" />
                                            <asp:Parameter Name="Month" />
                                            <asp:Parameter Name="Year" />
                                        </SelectParameters>
                                    </asp:ObjectDataSource>
                                </dx:PanelContent>
                            </PanelCollection>
                        </dx:ASPxCallbackPanel>

                    </div>
                </div>
            </dx:PopupControlContentControl>
        </ContentCollection>
    </dx:ASPxPopupControl>


</asp:Content>
