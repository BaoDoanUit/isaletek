<%@ Page Title="Home" Language="C#" AutoEventWireup="true" MasterPageFile="~/Layout.master" CodeBehind="Home.aspx.cs" Inherits="WebApplication.Home" %>

<%@ Register Src="~/UserControls/GoogleMapAPI.ascx" TagPrefix="uc1" TagName="GoogleMapAPI" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Content" runat="server">
    <style>
        a:hover {
            cursor: pointer;
        }

        .gm-style-iw {
            width: 350px !important;
            top: 15px !important;
            left: 0px !important;
            background-color: #fff;
            box-shadow: 0 1px 6px rgba(178, 178, 178, 0.6);
            border: 1px solid rgba(72, 181, 233, 0.6);
            border-radius: 2px 2px 10px 10px;
        }

        #iw-container {
            margin-bottom: 10px;
        }

            #iw-container .iw-title {
                font-family: 'Open Sans Condensed', sans-serif;
                font-size: 22px;
                font-weight: 400;
                padding: 10px;
                background-color: #48b5e9;
                color: white;
                margin: 0;
                border-radius: 2px 2px 0 0;
            }

            #iw-container .iw-content {
                font-size: 13px;
                line-height: 18px;
                font-weight: 400;
                margin-right: 1px;
                padding: 15px 5px 20px 15px;
                max-height: 140px;
                overflow-y: auto;
                overflow-x: hidden;
            }

        .iw-content img {
            float: right;
            margin: 0 5px 5px 10px;
        }

        .iw-subTitle {
            font-size: 16px;
            font-weight: 700;
            padding: 5px 0;
        }

        .iw-bottom-gradient {
            position: absolute;
            width: 326px;
            height: 25px;
            bottom: 10px;
            right: 18px;
            background: linear-gradient(to bottom, rgba(255,255,255,0) 0%, rgba(255,255,255,1) 100%);
            background: -webkit-linear-gradient(top, rgba(255,255,255,0) 0%, rgba(255,255,255,1) 100%);
            background: -moz-linear-gradient(top, rgba(255,255,255,0) 0%, rgba(255,255,255,1) 100%);
            background: -ms-linear-gradient(top, rgba(255,255,255,0) 0%, rgba(255,255,255,1) 100%);
        }
    </style>

    <script>

        function getByShopId(Id) {
            $.ajax({
                type: "POST",
                url: "Home.aspx/ajax_shopInfo",
                data: "{'shopId':'" + Id + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: OnSuccess,
                failure: function (response) {
                    //alert(response.d);
                },
                error: function (response) {
                    //alert(response.d);
                }
            });
        }
        function OnSuccess(response) {
            var outlet = response.d;
            var html = [];

            if (outlet == null) {
                html.push('No data..');
            }
            else {
                html.push('<div class="iw-title">' + outlet.ShopCode + '</div>');
                html.push('<div class="iw-content">');
                html.push('<div class="iw-subTitle">' + outlet.ShopName + '</div>');
                html.push('<img src="../Content/Images/shop.png" alt="" height="51" width="51">');
                html.push('<p>' + outlet.Address + '</p>');
                html.push('<div class="iw-subTitle">Contacts</div>');
                html.push(outlet.PicIn);
                html.push('<p>' + outlet.EmployeeName + '<br>');
                html.push(outlet.Mobile + '<br>e-mail: nvb@congnghenguon.com.vn<br>');
                html.push('<b>Check In:</b> ' + outlet.CheckIn + '<br>');
                html.push('<b>Check Out:</b> ' + outlet.CheckOut + '<br>');
                html.push('</p>');
                html.push('<div class="iw-bottom-gradient"></div>');
            }

            document.getElementById('iw-container').innerHTML = html.join('');
        }
    </script>
    <div class="container">
        <div class="row marginTop20">
            <div class="col-md-12">
                <dx:ASPxFormLayout ID="AddCommentFormLayout" runat="server" UseDefaultPaddings="false">
                    <SettingsItems Width="100%" />
                    <SettingsItemCaptions Location="Top" />
                    <Items>
                        <dx:LayoutGroup Caption="Employees" ColCount="5">
                            <Items>
                                <dx:LayoutItem Caption="City/Tỉnh, Thành phố">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer>
                                            <dx:ASPxComboBox runat="server" ID="City" Width="100%" 
                                                
                                                TextField="City" ValueField="City">
                                                <ClearButton DisplayMode="OnHover"></ClearButton>
                                                <ClientSideEvents SelectedIndexChanged="function(s,e){District.PerformCallback(s.GetValue());}" />
                                                <Items>
                                                    <dx:ListEditItem Text="Tp Hồ Chí Minh" Value="Tp Hồ Chí Minh" />
                                                </Items>
                                            </dx:ASPxComboBox>
                                            <%--<asp:ObjectDataSource ID="odsCity" runat="server" SelectMethod="getByCityOrDistrict" TypeName="LogicTier.Controllers.OutletBL">
                                                <SelectParameters>
                                                    <asp:Parameter Name="city" Type="String" />
                                                    <asp:Parameter Name="disc" Type="String" />
                                                </SelectParameters>
                                            </asp:ObjectDataSource>--%>
                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>
                                </dx:LayoutItem>
                                <dx:LayoutItem Caption="District/Quận, Huyện">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer>
                                            <dx:ASPxComboBox runat="server" ID="District" Width="100%"
                                                DataSourceID="odsDistrict" TextField="District" ValueField="District" OnCallback="District_Callback"
                                                EnableCallbackMode="true" ClientInstanceName="District" CallbackPageSize="10">
                                                <ClearButton DisplayMode="OnHover"></ClearButton>
                                            </dx:ASPxComboBox>
                                            <asp:ObjectDataSource ID="odsDistrict" runat="server" SelectMethod="getByCityOrDistrict" TypeName="LogicTier.Controllers.OutletBL">
                                                <SelectParameters>
                                                    <asp:Parameter Name="city" Type="String" />
                                                    <asp:Parameter Name="disc" Type="String" />
                                                </SelectParameters>
                                            </asp:ObjectDataSource>
                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>
                                </dx:LayoutItem>
                                <dx:LayoutItem Caption="Outtlets/Cửa hàng">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer>
                                            <dx:ASPxButtonEdit runat="server" ID="ShopName">
                                                <ClearButton DisplayMode="OnHover"></ClearButton>
                                            </dx:ASPxButtonEdit>
                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>
                                </dx:LayoutItem>
                                <dx:EmptyLayoutItem></dx:EmptyLayoutItem>
                                <dx:LayoutItem ShowCaption="False">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer>
                                            <dx:ASPxButton ID="FilterButton" AutoPostBack="false" runat="server" Text="Tìm kiếm">
                                                <ClientSideEvents Click="function(s, e) {  cp.PerformCallback('filter'); }"></ClientSideEvents>
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
            <PanelCollection>
                <dx:PanelContent runat="server">
                    <div class="row marginTop20">
                        <div class="col-md-3">
                            <dx:ASPxGridView runat="server"
                                ID="grOutlet"
                                Width="100%"
                                AutoGenerateColumns="False"
                                DataSourceID="odsOutlets"
                                KeyFieldName="ShopId" OnInit="grOutlet_Init">
                                <SettingsPager PageSize="12" ShowNumericButtons="False">
                                    <PageSizeItemSettings Position="Left">
                                    </PageSizeItemSettings>
                                </SettingsPager>
                                <Columns>
                                    <dx:GridViewDataTextColumn Caption="Outlet/Cửa hàng" VisibleIndex="0">
                                        <DataItemTemplate>
                                            <a onclick='initMap(<%# Eval("Latitude")+","+Eval("Longitude")+","+Eval("ShopId")%>)'><%# Eval("ShopName") %></a>
                                        </DataItemTemplate>
                                    </dx:GridViewDataTextColumn>
                                </Columns>
                            </dx:ASPxGridView>
                            <asp:ObjectDataSource ID="odsOutlets" runat="server" SelectMethod="getOutletWithReference" TypeName="LogicTier.Controllers.OutletBL">
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
                        </div>
                        <div class="col-md-9">
                            <div class="row" style="height: 480px;">
                                <uc1:GoogleMapAPI runat="server" ID="GoogleMapAPI" />
                                <div id="iw-container"></div>
                            </div>
                        </div>
                    </div>
                </dx:PanelContent>
            </PanelCollection>
        </dx:ASPxCallbackPanel>
    </div>
</asp:Content>
