<%@ Page Title="Market Information" Language="C#" MasterPageFile="~/Layout.master" AutoEventWireup="true" CodeBehind="PriceActivity.aspx.cs" Inherits="WebApplication.Pages.PriceActivity" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Content" runat="server">
    <script type="text/javascript" src="../Scripts/jquery.dragsort-0.5.2.min.js"></script>
    <script>
        function OnEndCallback(s, e) {
            if (s.cpAlert != '' && (typeof s.cpAlert !== 'undefined')) {
                alert(s.cpAlert);
                cp.PerformCallback('filter;');
            }
        }
        function ShowWindow() {
            pcImport.Show();
        }
        function onFileUploadComplete(s, e) {
            if (e.callbackData) {
                if (e.callbackData != null && e.callbackData != "")
                    alert(e.callbackData);
                if (e.callbackData === "Lưu thành công!") {
                }
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
            hdfKey.Set('brand', valueSelect.join());
        }
        // start dealer
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
            valueSelectAccount = getValuesByTexts(valuesText.split(textSeparatorAccount));
            hdfKey.Set('account', valueSelectAccount.join());
        }
        // end dealer


        function Del(Id) {
            cp.PerformCallback('del;' + Id);
        }
    </script>
    <script type="text/javascript">
        $(document).ready(function () {
            $("#TopPanel_NavMenu ul li:eq(6)").addClass("dxm-selected");
        })
    </script>
    <style type="text/css">
        ul {
            list-style-type: none;
        }

        .placeHolder div {
            background-color: white !important;
            border: dashed 1px gray !important;
        }
    </style>
    <dx:ASPxCallbackPanel ID="ASPxCallbackPanel1" runat="server" Width="100%"
        ClientInstanceName="cp" OnCallback="ASPxCallbackPanel1_Callback">
        <ClientSideEvents EndCallback="OnEndCallback" />
        <PanelCollection>
            <dx:PanelContent runat="server">
                <div class="container">
                    <div class="row">
                        <div class="col-md-12 marginTop20">
                            <dx:ASPxFormLayout ID="AddCommentFormLayout" runat="server" UseDefaultPaddings="false">
                                <SettingsItems Width="100%" />
                                <SettingsItemCaptions Location="Top" />
                                <Items>
                                    <dx:LayoutGroup Caption="Price Activities">
                                        <Items>
                                            <dx:LayoutItem ShowCaption="False">
                                                <LayoutItemNestedControlCollection>
                                                    <dx:LayoutItemNestedControlContainer>
                                                        <div class="row">
                                                            <div class="col-md-3">
                                                                <div class="row">
                                                                    <div class="col-md-6">
                                                                        <label>Year</label>
                                                                        <dx:ASPxComboBox runat="server" Width="100%" ID="cbYear"
                                                                            ValueType="System.Int32" NullText="Year"
                                                                            ClientInstanceName="cbYear" CallbackPageSize="10">
                                                                            <ClearButton DisplayMode="OnHover"></ClearButton>
                                                                            <Items>
                                                                                <dx:ListEditItem Text="2019" Value="2019" Selected="true" />
                                                                                <dx:ListEditItem Text="2020" Value="2020" />
                                                                                <dx:ListEditItem Text="2021" Value="2021" />
                                                                                <dx:ListEditItem Text="2022" Value="2022" />
                                                                                <dx:ListEditItem Text="2023" Value="2023" />
                                                                            </Items>
                                                                        </dx:ASPxComboBox>
                                                                    </div>
                                                                    <div class="col-md-6">
                                                                        <label>Month</label>
                                                                        <dx:ASPxComboBox runat="server" Width="100%" ID="cbMonth"
                                                                            ValueType="System.Int32" NullText="Month"
                                                                            ClientInstanceName="cbMonth" CallbackPageSize="10">
                                                                            <ClearButton DisplayMode="OnHover"></ClearButton>
                                                                            <Items>
                                                                                <dx:ListEditItem Text="1" Value="1" />
                                                                                <dx:ListEditItem Text="2" Value="2" />
                                                                                <dx:ListEditItem Text="3" Value="3" />
                                                                                <dx:ListEditItem Text="4" Value="4" />
                                                                                <dx:ListEditItem Text="5" Value="5" />
                                                                                <dx:ListEditItem Text="6" Value="6" />
                                                                                <dx:ListEditItem Text="7" Value="7" />
                                                                                <dx:ListEditItem Text="8" Value="8" />
                                                                                <dx:ListEditItem Text="9" Value="9" />
                                                                                <dx:ListEditItem Text="10" Value="10" />
                                                                                <dx:ListEditItem Text="11" Value="11" />
                                                                                <dx:ListEditItem Text="12" Value="12" />
                                                                            </Items>
                                                                        </dx:ASPxComboBox>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                            <div class="col-md-3">
                                                                <label>Brand</label>
                                                                <dx:ASPxDropDownEdit ClientInstanceName="checkComboBox" Width="100%" NullText="--All--" Caption="Brand" ID="checkBrand" runat="server" AnimationType="None">
                                                                    <DropDownWindowTemplate>
                                                                        <dx:ASPxListBox Width="100%" ID="listBox" ClientInstanceName="checkListBox" SelectionMode="CheckColumn" DataSourceID="odsBrand1"
                                                                            runat="server" Height="200" EnableSelectAll="true" ValueField="Id" TextField="BrandName">
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
                                                                <asp:ObjectDataSource ID="odsBrand1" runat="server" SelectMethod="getBrandName" TypeName="LogicTier.Controllers.CompertitorBL"></asp:ObjectDataSource>
                                                            </div>
                                                            <div class="col-md-3">
                                                                <label>Dealer</label>
                                                                <dx:ASPxDropDownEdit ClientInstanceName="checkComboBoxAccount" Width="200px" NullText="--All--" Caption="Dealer" ID="checkComboBoxAccount" runat="server" AnimationType="None">
                                                                    <DropDownWindowTemplate>
                                                                        <dx:ASPxListBox Width="100%" ID="listBoxAccount" ClientInstanceName="checkListBoxAccount" SelectionMode="CheckColumn" DataSourceID="odsAccount"
                                                                            runat="server" Height="200" EnableSelectAll="false" ValueField="ObjectId" TextField="Account">
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
                                                            <div class="col-md-3">
                                                                <label style="color: white">Tool</label><br />
                                                                <dx:ASPxButton ID="btFilter" AutoPostBack="false" runat="server" Text="Tìm kiếm" CssClass="btn btn-primary">
                                                                    <ClientSideEvents Click="function(s, e) {  cp.PerformCallback('filter'); }"></ClientSideEvents>
                                                                </dx:ASPxButton>
                                                                <dx:ASPxButton ID="btCreateNew" AutoPostBack="false" runat="server" Text="Thêm mới" CssClass="btn btn-warning">
                                                                    <ClientSideEvents Click="function(s, e) { ShowWindow();}"></ClientSideEvents>
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
                    <div class="row container marginTop20">
                        <div class="col-md-12 box-content">
                            <div class="row marginTop20 marginBot20">
                                <div class="col-md-12">
                                    <dx:ASPxGridView ID="grData" runat="server" AutoGenerateColumns="false" Theme="Material" Width="100%">
                                        <Columns>
                                            <dx:GridViewDataColumn Width="72px" VisibleIndex="0" Caption="Stt">
                                                <CellStyle HorizontalAlign="Center"></CellStyle>
                                                <DataItemTemplate>
                                                    <%# Container.ItemIndex + 1 %>
                                                </DataItemTemplate>
                                            </dx:GridViewDataColumn>
                                            <dx:GridViewDataColumn FieldName="BrandDealer" VisibleIndex="2" Caption="Brand/Dealer"></dx:GridViewDataColumn>
                                            <dx:GridViewDataColumn FieldName="ActivityName" VisibleIndex="3" Caption="Activity Name"></dx:GridViewDataColumn>
                                            <dx:GridViewDataTextColumn FieldName="ActivityDate" VisibleIndex="4">
                                                <PropertiesTextEdit DisplayFormatString="yyyy-MM-dd"></PropertiesTextEdit>
                                            </dx:GridViewDataTextColumn>
                                            <dx:GridViewDataColumn Width="110px" Caption="View" VisibleIndex="5">
                                                <CellStyle HorizontalAlign="Center"></CellStyle>
                                                <DataItemTemplate>
                                                    <a href='<%# Eval("FilePath") %>' target="_blank">Click</a>
                                                     <a onclick='<%# "Del(" +Eval("Id") +")" %>' style="cursor: pointer">Delete</a>
                                                </DataItemTemplate>
                                            </dx:GridViewDataColumn>
                                        </Columns>
                                        <Settings VerticalScrollableHeight="330" VerticalScrollBarMode="Visible" />
                                        <SettingsBehavior AllowSort="true" ColumnResizeMode="Control" />
                                        <Styles>
                                            <Header HorizontalAlign="Center" Wrap="True" Paddings-Padding="3px">
                                                <Paddings Padding="3px"></Paddings>
                                            </Header>
                                            <Cell Wrap="True" VerticalAlign="Middle" Paddings-Padding="5px">
                                                <Paddings Padding="5px"></Paddings>
                                            </Cell>
                                        </Styles>
                                        <SettingsPager PageSize="200000"></SettingsPager>
                                    </dx:ASPxGridView>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </dx:PanelContent>
        </PanelCollection>
    </dx:ASPxCallbackPanel>
    <dx:ASPxPopupControl ID="pcImport" runat="server" Width="600" CloseAction="CloseButton" CloseOnEscape="true" Modal="True"
        PopupHorizontalAlign="WindowCenter" PopupVerticalAlign="WindowCenter" ClientInstanceName="pcImport"
        HeaderText="Price Activities" AllowDragging="True" PopupAnimationType="None" EnableViewState="False" AutoUpdatePosition="true">
        <ContentCollection>
            <dx:PopupControlContentControl runat="server">
                <dx:ASPxPanel ID="Panel1" runat="server" DefaultButton="btOK">
                    <PanelCollection>
                        <dx:PanelContent runat="server">
                            <dx:ASPxFormLayout runat="server" ID="ASPxFormLayout1" Width="100%" Height="100%">
                                <Items>
                                    <dx:LayoutItem Caption="Brand">
                                        <LayoutItemNestedControlCollection>
                                            <dx:LayoutItemNestedControlContainer>
                                                <dx:ASPxComboBox runat="server" ID="cbBrand" ValueType="System.Int32" NullText="Brand"
                                                    DataSourceID="odsBrand" TextField="BrandName" ValueField="Id"
                                                    ClientInstanceName="cbBrand" CallbackPageSize="10">
                                                    <ClearButton DisplayMode="OnHover"></ClearButton>
                                                </dx:ASPxComboBox>
                                                <asp:ObjectDataSource ID="odsBrand" runat="server" SelectMethod="getBrandName" TypeName="LogicTier.Controllers.CompertitorBL"></asp:ObjectDataSource>
                                            </dx:LayoutItemNestedControlContainer>
                                        </LayoutItemNestedControlCollection>
                                    </dx:LayoutItem>
                                    <dx:LayoutItem Caption="Dealer">
                                        <LayoutItemNestedControlCollection>
                                            <dx:LayoutItemNestedControlContainer>
                                                <dx:ASPxComboBox runat="server" ID="cbAccount" ValueType="System.Int32" NullText="Dealer"
                                                    DataSourceID="odsAccount2" TextField="Account" ValueField="ObjectId"
                                                    ClientInstanceName="cbAccount" CallbackPageSize="10">
                                                    <ClearButton DisplayMode="OnHover"></ClearButton>
                                                </dx:ASPxComboBox>
                                                <asp:ObjectDataSource ID="odsAccount2" runat="server" SelectMethod="getAccountGroup" TypeName="LogicTier.Controllers.SaleOutBL"></asp:ObjectDataSource>
                                            </dx:LayoutItemNestedControlContainer>
                                        </LayoutItemNestedControlCollection>
                                    </dx:LayoutItem>
                                    <dx:LayoutItem Caption="DatePost">
                                        <LayoutItemNestedControlCollection>
                                            <dx:LayoutItemNestedControlContainer>
                                                <dx:ASPxDateEdit runat="server" ID="deDatePost" AllowNull="false"
                                                    OnInit="deDatePost_Init"></dx:ASPxDateEdit>
                                            </dx:LayoutItemNestedControlContainer>
                                        </LayoutItemNestedControlCollection>
                                    </dx:LayoutItem>
                                    <dx:LayoutItem Caption="Name">
                                        <LayoutItemNestedControlCollection>
                                            <dx:LayoutItemNestedControlContainer>
                                                <dx:ASPxButtonEdit runat="server" ID="txtnamenew" ClientInstanceName="txtnamenew">
                                                    <ClearButton DisplayMode="OnHover"></ClearButton>
                                                </dx:ASPxButtonEdit>
                                            </dx:LayoutItemNestedControlContainer>
                                        </LayoutItemNestedControlCollection>
                                    </dx:LayoutItem>
                                    <dx:LayoutItem ShowCaption="False">
                                        <LayoutItemNestedControlCollection>
                                            <dx:LayoutItemNestedControlContainer>
                                                <dx:ASPxUploadControl ID="upImages" runat="server" ClientInstanceName="upImages" Width="100%" UploadButton-ImagePosition="Bottom"
                                                    NullText="Chọn file (.jpe, .jpeg, .jpg, .gif, .png, .mp4, .pptx, .xlsx, .pdf)..." UploadMode="Advanced" ShowProgressPanel="True"
                                                    OnFileUploadComplete="upImages_FileUploadComplete" FileUploadMode="OnPageLoad">
                                                    <ValidationSettings AllowedFileExtensions=".jpe, .jpeg, .jpg, .gif, .png, .mp4, .pptx, .xlsx, .pdf"></ValidationSettings>
                                                    <AdvancedModeSettings EnableMultiSelect="True" EnableFileList="True" EnableDragAndDrop="false" />
                                                    <ClientSideEvents FileUploadComplete="onFileUploadComplete" />
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
                                                            <ClientSideEvents Click="function(s, e) { upImages.Upload(); }" />
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
    <asp:HiddenField ID="hfId" runat="server" />
    <dx:ASPxHiddenField ID="hdfKey" ClientInstanceName="hdfKey" runat="server"></dx:ASPxHiddenField>
</asp:Content>
