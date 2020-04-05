<%@ Page Title="Attendance" Language="C#" MasterPageFile="~/Layout.master" AutoEventWireup="true" CodeBehind="PC_Attendance.aspx.cs" Inherits="WebApplication.Pages.PC_Attendance" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Content" runat="server">
    <script src="/Scripts/markerclusterer.js"></script>
    <script async defer src="https://maps.googleapis.com/maps/api/js?key=AIzaSyBAZuhZ81_5dAP3fJrOR0XytTMoXc5dUgk">
    </script>
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

        #map {
            height: 300px;
            width: 100%;
        }

        .dxgvDataRow_Material td:nth-child(4), .dxgvDataRow_Material td:nth-child(5) {
            padding: 0px !important;
            margin: 0px !important
        }

            .dxgvDataRow_Material td:nth-child(4) a, .dxgvDataRow_Material td:nth-child(5) a {
                float: left;
                width: 100%;
                height: 42px;
                line-height: 42px;
                color: #FFF
            }

                .dxgvDataRow_Material td:nth-child(4) a:hover, .dxgvDataRow_Material td:nth-child(5) a:hover {
                    text-decoration: none
                }

        .gm-style-iw gm-style-iw-c {
            max-height: 155px !important
        }

        .gm-style-iw-d {
            max-height: 145px !important
        }
    </style>
    <script type="text/javascript">
        $(document).ready(function () {
            initMap();
        });
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
            valueSelectAccount = getValuesByTexts(valuesText.split(textSeparatorAccount));
            hdfKey.Set('account', valueSelectAccount.join());
        }
        // en dealer
        //start shop
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
        //end shop
        function OnEndCallback(s, e) {
            initMap();
        }
        function addMarker(Latitude, Longitude, infoWindow, markerIcon) {

            var latLng = new google.maps.LatLng(Latitude, Longitude);
            var infowindow = new google.maps.InfoWindow({
                content: infoWindow
            });

            console.log(markerIcon)

            var marker = new google.maps.Marker({
                position: latLng,
                clickable: true,
                icon: {
                    url: markerIcon
                }
            });

            marker.addListener('click', function () {
                infowindow.open(map, marker);

                // map.setCenter(marker.getPosition());
            });

            return marker;
        }

        function panToMarker(id, Latitude, Longitude) {
            google.maps.event.trigger(markers[id], 'click');
            console.log(id + ' ' + Latitude + ' ' + Longitude)
            map.setCenter(new google.maps.LatLng(Latitude, Longitude));
        }
        var markers = [];
        var map;
        var markerCluster;
        function initMap() {
            var url = "/Handler/CustomerAttendanceHandler.ashx";
            var data = {
                userName: hdfKey.Get('userName'),
                fromdate: txtDate.GetText(),
                todate: txtDate.GetText(),
                Area: cbArea.GetValue(),
                Region: checkComboBox.GetValue(),
                ObjectId: checkComboBoxAccount.GetValue()
            };

            $.post(url, data, function (data) {
                if (data != null) {
                    var myArr = $.parseJSON(data);
                    if (myArr.length > 0) {
                        var lat = 0
                        var lng = 0
                        var zoom = 16;
                        markers = [];

                        for (var i = 0; i < myArr.length; i++) {
                            try {
                                for (var i = 0; i < myArr.length; i++) {
                                    if (myArr[i].Latitude != null && myArr[i].Latitude > 0) {

                                        var markerIcon = '/Content/Images/ic-ontime.png'
                                        if (myArr[i].ShiftType.toLowerCase() === 'off')
                                            markerIcon = '/Content/Images/ic-off.png'
                                        else if (myArr[i].Status1 === 'LATE' || myArr[i].Status2 === 'EARLY')
                                            markerIcon = '/Content/Images/ic-late.png'

                                        if (lat == 0 && myArr[i].Latitude != null && myArr[i].Latitude > 0) {
                                            lat = myArr[i].Latitude;
                                            lng = myArr[i].Longitude;
                                        }
                                        var infoWindow = "<p>Outlet: " + myArr[i].ShopName + "</p>";
                                        infoWindow += "<p> Add: " + myArr[i].Address + "</p>";
                                        infoWindow += "<p> Shift: " + myArr[i].ShiftType + "</p>";
                                        infoWindow += "<p> In: " + myArr[i].CheckInTime + "</p>";
                                        infoWindow += "<p> Out: " + myArr[i].CheckOutTime + "</p>";
                                        infoWindow += "<p> Distance: " + myArr[i].DistanceShop + "</p>";
                                        infoWindow += "<p> Note: " + myArr[i].Comments + "</p>";
                                        infoWindow += "<p> Confirm: " + myArr[i].Confirm + "</p>";


                                        console.log('--------------' + i)
                                        console.log(markerIcon);
                                        console.log(myArr[i])

                                        markers.push(addMarker(myArr[i].Latitude, myArr[i].Longitude, infoWindow, markerIcon));
                                    }
                                }

                            } catch (e) {
                                // alert(e.message);
                            }
                        }
                        map = new google.maps.Map(document.getElementById('map'), {
                            zoom: zoom,
                            center: { lat: lat, lng: lng }
                        });
                    }
                    else {
                        map = new google.maps.Map(document.getElementById('map'), {
                            zoom: 16,
                            center: { lat: 10.7983398, lng: 106.7390165 }
                        });
                    }
                    markerCluster = new MarkerClusterer(map, markers, { imagePath: '/Content/images/m' });
                }
                else {
                    map = new google.maps.Map(document.getElementById('map'), {
                        zoom: 16,
                        center: { lat: 10.7983398, lng: 106.7390165 }
                    });
                }
            });


           
        }


    </script>
    <dx:ASPxCallbackPanel ID="aspCallbackPanel" runat="server" Width="100%" ClientSideEvents-EndCallback="OnEndCallback"
        ClientInstanceName="aspCallbackPanel" OnCallback="aspCallbackPanel_Callback">
        <ClientSideEvents EndCallback="OnEndCallback"></ClientSideEvents>
        <PanelCollection>
            <dx:PanelContent runat="server">
                <div class="row">
                    <div class="col-md-7">
                        <div class="filter">
                            <fieldset class="scheduler-border">
                                <legend class="scheduler-border">Search</legend>
                                <div class="row">
                                    <div class="col-md-6" style="display: none">
                                        <dx:ASPxComboBox Caption="Term *" runat="server" ID="cbTerm" Width="100%" DataSourceID="odsTerm" ValueField="Id" ValueType="System.Int32" NullText="--All--"
                                            ClientInstanceName="cbTerm" DropDownStyle="DropDownList">
                                            <ClearButton DisplayMode="OnHover"></ClearButton>
                                            <Columns>
                                                <dx:ListBoxColumn FieldName="TermCycle" Caption="Term" />
                                            </Columns>
                                        </dx:ASPxComboBox>
                                        <asp:ObjectDataSource ID="odsTerm" runat="server" SelectMethod="getList" TypeName="LogicTier.Controllers.TermController"></asp:ObjectDataSource>
                                    </div>
                                    <div class="col-md-6">
                                        <dx:ASPxDateEdit runat="server" ID="txtDate" OnInit="txtDate_Init" ClientInstanceName="txtDate" Caption="Date *" Width="100%" DisplayFormatString="MMM dd"
                                            EditFormat="Custom" EditFormatString="dd/MM/yyyy">
                                            <ClearButton DisplayMode="OnHover"></ClearButton>
                                        </dx:ASPxDateEdit>
                                    </div>
                                    <div class="col-md-6" style="display: none">
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
                                    <div class="col-md-6">
                                        <dx:ASPxDropDownEdit ClientInstanceName="checkComboBox" Width="100%" NullText="--All--" Caption="Area" ID="checkRegion" runat="server" AnimationType="None">
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
                                    <div class="col-md-6" style="display: none">
                                        <dx:ASPxComboBox runat="server" ID="cbProduct" Caption="Product *" ValueField="Product" Width="100%"
                                            ValueType="System.String" NullText="--All--" ClientInstanceName="cbProduct" DataSourceID="odsProduct">
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
                                </div>
                                <div class="row marginTop20">
                                    <div class="col-md-6">
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
                                    <div class="col-md-6">
                                        <dx:ASPxComboBox Caption="Status" runat="server" Width="100%" ID="cbStatus" ValueType="System.String" NullText="--All--"
                                            ClientInstanceName="cbStatus" EnableCallbackMode="true" DropDownStyle="DropDownList">
                                            <Items>
                                                <dx:ListEditItem Value="All" Text="All" />
                                                <dx:ListEditItem Value="Ontime" Text="Ontime" />
                                                <dx:ListEditItem Value="Late,Early" Text="Late/Out early" />
                                                <dx:ListEditItem Value="Off" Text="Off" />
                                                <dx:ListEditItem Value="NA" Text="NA" />
                                            </Items>
                                        </dx:ASPxComboBox>
                                    </div>
                                </div>
                                <div class="row marginTop20">
                                    <div class="col-md-6">
                                        <dx:ASPxDropDownEdit ClientInstanceName="checkShopComboBox" Width="100%" NullText="--All--" Caption="Shop" ID="checkShopComboBox" runat="server" AnimationType="None">
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
                                    <div class="col-md-6">
                                        <dx:ASPxButton ID="FilterButton" AutoPostBack="false" runat="server" Text="Filter" Style="float: left; margin-right: 10px;">
                                            <ClientSideEvents Click="function(s, e) {  aspCallbackPanel.PerformCallback('filter'); initMap();}"></ClientSideEvents>
                                        </dx:ASPxButton>
                                        <dx:ASPxButton ID="ExportButton" AutoPostBack="false" runat="server" Text="Export" Style="float: left; margin-right: 10px;">
                                            <ClientSideEvents Click="function(s, e) {  aspCallbackPanel.PerformCallback('export'); initMap();}"></ClientSideEvents>
                                        </dx:ASPxButton>
                                        <asp:HyperLink ID="hplexcel" Visible="false" runat="server">HyperLink</asp:HyperLink>
                                    </div>
                                </div>
                            </fieldset>
                        </div>
                        <dx:ASPxGridView ID="grData" runat="server" AutoGenerateColumns="false" Theme="Material" Width="100%">
                            <Columns>
                                <dx:GridViewDataColumn FieldName="City" Width="85px" Visible="false" Caption="Province"></dx:GridViewDataColumn>
                                <dx:GridViewDataColumn FieldName="Account" Visible="false" Width="95px" Caption="Dealer"></dx:GridViewDataColumn>
                                <dx:GridViewDataColumn FieldName="ShopName" Caption="Shop Name"></dx:GridViewDataColumn>
                                <dx:GridViewDataColumn FieldName="EmployeeName" Caption="PC"></dx:GridViewDataColumn>
                                <dx:GridViewDataColumn Width="120px" Caption="Shift">
                                    <CellStyle HorizontalAlign="Center"></CellStyle>
                                    <DataItemTemplate>
                                        <a style="text-transform: capitalize; color: #484848"><%# Convert.ToString(Eval("ShiftType")) == "Off" ? "Off" : (Eval("ShiftType") + " <small>("+Eval("From")+" - "+Eval("To")+")</small>" ) %></a>
                                    </DataItemTemplate>
                                </dx:GridViewDataColumn>
                                <dx:GridViewDataColumn FieldName="CheckInTime" Visible="false" Caption="IN"></dx:GridViewDataColumn>
                                <dx:GridViewDataColumn FieldName="CheckOutTime" Visible="false" Caption="OUT"></dx:GridViewDataColumn>
                                <dx:GridViewDataColumn Width="100px" Caption="IN">
                                    <CellStyle HorizontalAlign="Center"></CellStyle>
                                    <DataItemTemplate>
                                        <a onclick='javascript: panToMarker(<%# Container.ItemIndex%>,<%# Convert.ToString(Eval("Latitude")).Replace(",",".")  %>,<%# Convert.ToString( Eval("Longitude")).Replace(",",".") %>)' <%# Convert.ToString(Eval("Status1")) == "ONTIME" ? "style='background:green'" : (Convert.ToString(Eval("Status1")) == "OFF" ? "style='background:gray'" : Convert.ToString(Eval("Status1")) == "NA" ? "style='background:gray'" : Convert.ToString(Eval("Status1")) == "NOT YET" ? "style='background:gray'" : "style='background:red'") %>><%# Eval("Status1") + (Convert.ToString(Eval("CheckInTime")) != "" ? (" | " + Eval("CheckInTime")) : "") %></a>
                                    </DataItemTemplate>
                                </dx:GridViewDataColumn>
                                <dx:GridViewDataColumn Width="100px" Caption="OUT">
                                    <CellStyle HorizontalAlign="Center"></CellStyle>
                                    <DataItemTemplate>
                                        <a onclick='javascript: panToMarker(<%# Container.ItemIndex%>,<%# Convert.ToString(Eval("Latitude")).Replace(",",".")  %>,<%# Convert.ToString( Eval("Longitude")).Replace(",",".") %>)' <%# Convert.ToString(Eval("Status2")) == "ONTIME" ? "style='background:green'" : (Convert.ToString(Eval("Status2")) == "OFF" ? "style='background:gray'" : Convert.ToString(Eval("Status2")) == "NA" ? "style='background:gray'" : Convert.ToString(Eval("Status2")) == "NOT YET" ? "style='background:gray'" : "style='background:red'") %>><%# Eval("Status2") + (Convert.ToString(Eval("CheckOutTime")) != "" ? (" | " + Eval("CheckOutTime")) : "") %></a>
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
                    <div class="col-md-5">
                        <div class="row" style="padding: 28px 0 0 0;">
                            <div class="col-md-12">
                                <div style="display: block; margin: 0 auto; width: 400px">
                                    <table class="table table-bordered">
                                        <thead>
                                            <tr>
                                                <th>Status</th>
                                                <th>No.Of PC</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <asp:Literal ID="ltrsum" runat="server"></asp:Literal>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                        <div class="row" style="padding: 0 0 0 20px;">
                            <div id="map"></div>
                        </div>
                    </div>
                </div>
            </dx:PanelContent>
        </PanelCollection>
    </dx:ASPxCallbackPanel>
    <dx:ASPxHiddenField ID="hdfKey" ClientInstanceName="hdfKey" runat="server"></dx:ASPxHiddenField>
</asp:Content>
