<%@ Page Title="Price Report By Brands" Language="C#" MasterPageFile="~/Layout.master" AutoEventWireup="true" CodeBehind="PriceByBrand.aspx.cs" Inherits="WebApplication.Pages.PriceByBrand" %>

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
            padding: 10px 10px 0 10px;
            border-bottom: none;
        }

        .legend {
            margin-bottom: 10px
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
    <script type="text/javascript">
        function OnEndCallback(s, e) {
            if (s.cpAlert != null && s.cpAlert != '') {
                alert(s.cpAlert);
            }
        }
        function monthChanged(s, e) {
            aspCallbackPanel.PerformCallback('Filter')
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
    <script type="text/javascript">
        $(document).ready(function () {
            $("#TopPanel_NavMenu ul li:eq(4)").addClass("dxm-selected");
        })
    </script>
    <dx:ASPxCallbackPanel ID="aspCallbackPanel" runat="server" Width="100%" ClientSideEvents-EndCallback="OnEndCallback"
        ClientInstanceName="aspCallbackPanel" OnCallback="aspCallbackPanel_Callback">
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
                                </div>
                                <div class="col-md-3" style="display: none">
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
                                <div class="col-md-3">
                                    <%--<dx:ASPxButton ID="FilterButton" AutoPostBack="false" CssClass="btn btn-primary" runat="server" Text="Search">
                                        <ClientSideEvents Click="function(s, e) {  aspCallbackPanel.PerformCallback('Filter'); }"></ClientSideEvents>
                                    </dx:ASPxButton>--%>
                                    <dx:ASPxButton ID="ExportButton" AutoPostBack="false"
                                        CssClass="btn btn-primary" runat="server" Text="Download">
                                        <ClientSideEvents Click="function(s, e) {  aspCallbackPanel.PerformCallback('Export'); }"></ClientSideEvents>
                                    </dx:ASPxButton>
                                    <dx:ASPxButton ID="btnopen" AutoPostBack="false" runat="server" CssClass="btn btn-warning" Text="Import">
                                        <ClientSideEvents Click="function(s, e) { pcImport.Show(); }" />
                                    </dx:ASPxButton>
                                    <a id="linktemp" runat="server"  href='/Pages/DownTemp.aspx?type=pricebybrand' target="_blank">Template</a>
                                    <asp:HyperLink ID="hplexcel" runat="server"></asp:HyperLink>
                                </div>
                            </div>
                            <div class="row marginTop10">
                                <div style="display: none">
                                    <dx:ASPxRadioButtonList runat="server" Caption="Product *" ID="rdProduct" RepeatColumns="5" DataSourceID="odsProduct" ValueField="Product" TextField="Product" RepeatDirection="Horizontal">
                                        <RadioButtonStyle Font-Size="10px"></RadioButtonStyle>
                                    </dx:ASPxRadioButtonList>
                                    <asp:ObjectDataSource ID="odsProduct" runat="server" SelectMethod="getDivision" TypeName="LogicTier.Controllers.ProductsBL">
                                        <SelectParameters>
                                            <asp:Parameter DefaultValue="Product" Name="fieldName" Type="String" />
                                            <asp:Parameter Name="fieldValue" Type="String" />
                                            <asp:Parameter DefaultValue="Product" Name="fieldDisplay" Type="String" />
                                        </SelectParameters>
                                    </asp:ObjectDataSource>
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
                        </fieldset>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-12" style="position: relative">
                        <a style="position: absolute; right: 5%; top: 5px; z-index: 99999">(KVND)</a>
                        <dx:ASPxPageControl runat="server" ID="pageControl" Width="100%" CssClass="dxtcFixed" ActiveTabIndex="0" EnableHierarchyRecreation="True">
                            <TabPages>
                                <dx:TabPage Text="Hitachi">
                                    <ContentCollection>
                                        <dx:ContentControl runat="server">
                                            <dx:ASPxGridView ID="grHitachi"
                                                runat="server" AutoGenerateColumns="false"
                                                Theme="Material" Width="100%" SettingsBehavior-AllowDragDrop="false">
                                                <Columns>
                                                </Columns>
                                                <Settings HorizontalScrollBarMode="Visible" VerticalScrollBarStyle="Standard" VerticalScrollableHeight="350" VerticalScrollBarMode="Visible" />
                                                <SettingsBehavior AllowSort="true" ColumnResizeMode="Control" AllowAutoFilter="true" />
                                                <Styles>
                                                    <Header HorizontalAlign="Center" Wrap="True" Paddings-Padding="3px"></Header>
                                                    <Cell Wrap="True" VerticalAlign="Middle" Paddings-Padding="5px"></Cell>
                                                </Styles>
                                                <SettingsPager Mode="ShowAllRecords"></SettingsPager>
                                            </dx:ASPxGridView>
                                        </dx:ContentControl>
                                    </ContentCollection>
                                </dx:TabPage>
                                <dx:TabPage Text="LG">
                                    <ContentCollection>
                                        <dx:ContentControl runat="server">
                                            <dx:ASPxGridView ID="grLG" runat="server" AutoGenerateColumns="false" Theme="Material" Width="100%">
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
                                        </dx:ContentControl>
                                    </ContentCollection>
                                </dx:TabPage>
                                <dx:TabPage Text="Toshiba">
                                    <ContentCollection>
                                        <dx:ContentControl runat="server">
                                            <dx:ASPxGridView ID="grTOSHIBA" runat="server" AutoGenerateColumns="false" Theme="Material" Width="100%">
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
                                        </dx:ContentControl>
                                    </ContentCollection>
                                </dx:TabPage>
                                <dx:TabPage Text="Panasonic">
                                    <ContentCollection>
                                        <dx:ContentControl runat="server">
                                            <dx:ASPxGridView ID="grPANASONIC" runat="server" AutoGenerateColumns="false" Theme="Material" Width="100%">
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
                                        </dx:ContentControl>
                                    </ContentCollection>
                                </dx:TabPage>
                                <dx:TabPage Text="Samsung">
                                    <ContentCollection>
                                        <dx:ContentControl runat="server">
                                            <dx:ASPxGridView ID="grSAMSUNG" runat="server" AutoGenerateColumns="false" Theme="Material" Width="100%">
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
                                        </dx:ContentControl>
                                    </ContentCollection>
                                </dx:TabPage>
                                <dx:TabPage Text="Aqua">
                                    <ContentCollection>
                                        <dx:ContentControl runat="server">
                                            <dx:ASPxGridView ID="grAQUA" runat="server" AutoGenerateColumns="false" Theme="Material" Width="100%">
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
                                        </dx:ContentControl>
                                    </ContentCollection>
                                </dx:TabPage>
                                <dx:TabPage Text="Electrolux">
                                    <ContentCollection>
                                        <dx:ContentControl runat="server">
                                            <dx:ASPxGridView ID="grELECTROLUX" runat="server" AutoGenerateColumns="false" Theme="Material" Width="100%">
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
                                        </dx:ContentControl>
                                    </ContentCollection>
                                </dx:TabPage>
                                <dx:TabPage Text="Sharp">
                                    <ContentCollection>
                                        <dx:ContentControl runat="server">
                                            <dx:ASPxGridView ID="grSHARP" runat="server" AutoGenerateColumns="false" Theme="Material" Width="100%">
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
                                        </dx:ContentControl>
                                    </ContentCollection>
                                </dx:TabPage>
                                <dx:TabPage Text="Mitsubishi">
                                    <ContentCollection>
                                        <dx:ContentControl runat="server">
                                            <dx:ASPxGridView ID="grMITSUBISHI" runat="server" AutoGenerateColumns="false" Theme="Material" Width="100%">
                                                <Columns>
                                                </Columns>
                                                <Settings HorizontalScrollBarMode="Visible" 
                                                    VerticalScrollBarStyle="Standard" 
                                                    VerticalScrollableHeight="350" VerticalScrollBarMode="Visible" />
                                                <SettingsBehavior AllowSort="true" ColumnResizeMode="Control" />
                                                <Styles>
                                                    <Header HorizontalAlign="Center" Wrap="True" Paddings-Padding="3px"></Header>
                                                    <Cell Wrap="True" VerticalAlign="Middle" Paddings-Padding="5px"></Cell>
                                                </Styles>
                                                <SettingsPager Mode="ShowAllRecords"></SettingsPager>
                                            </dx:ASPxGridView>
                                        </dx:ContentControl>
                                    </ContentCollection>
                                </dx:TabPage>
                            </TabPages>
                        </dx:ASPxPageControl>
                    </div>
                </div>
            </dx:PanelContent>
        </PanelCollection>
    </dx:ASPxCallbackPanel>
    <dx:ASPxPopupControl ID="pcImport" runat="server" Width="320" CloseAction="CloseButton" CloseOnEscape="true" Modal="True"
        PopupHorizontalAlign="WindowCenter" PopupVerticalAlign="WindowCenter" ClientInstanceName="pcImport"
        HeaderText="Price Report By Brands" AllowDragging="True" PopupAnimationType="None" EnableViewState="False" AutoUpdatePosition="true">
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
                                                <dx:ASPxUploadControl ID="uploadPrice" runat="server" ClientInstanceName="uploadPrice"
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
                                                            <ClientSideEvents Click="function(s, e) { uploadPrice.UploadFile();}" />
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
    <dx:ASPxHiddenField ID="hdfKey" ClientInstanceName="hdfKey" runat="server"></dx:ASPxHiddenField>
</asp:Content>
