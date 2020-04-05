<%@ Page Title="Stock" Language="C#" MasterPageFile="~/Layout.master" AutoEventWireup="true" CodeBehind="Stock.aspx.cs" Inherits="WebApplication.Pages.Employee.Stock" Async="true" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Content" runat="server">
    <style>
        .image-upload > div > input {
            display: none;
        }

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
    </style>
    <script>
        function OnEndCallback(s, e) {
            if (s.cpAlert != '') {
                alert(s.cpAlert);
            }
        }
        function outletChange(s, e) {
            ASPxCallbackPanel1.PerformCallback('outlet;' + s.GetValue());
        }
        function productChange(s, e) {
            ASPxCallbackPanel1.PerformCallback('product;' + s.GetValue() + ';' + Outlets.GetValue());
        }
    </script>
    <dx:ASPxCallbackPanel ID="ASPxCallbackPanel1" runat="server" Width="100%"
        ClientInstanceName="ASPxCallbackPanel1" OnCallback="ASPxCallbackPanel1_Callback">
        <ClientSideEvents EndCallback="OnEndCallback" />
        <PanelCollection>
            <dx:PanelContent runat="server">
                <div class="row text-center">
                    <h3>Báo cáo tồn kho</h3>
                    <h4></h4>
                    <div class="col-xs-12" style="margin-top: 5px;">
                        <div class="row" style="margin: 0 4px;">
                            <asp:HiddenField runat="server" ID="hfSaleId" />
                           <dx:ASPxComboBox runat="server" ID="cbxOutlets" Width="100%" OnInit="cbxOutlets_Init" NullText="Chọn cửa hàng"
                                DataSourceID="odsOutlet" ValueField="ShopId" ValueType="System.Int32"
                                EnableCallbackMode="true" ClientInstanceName="Outlets" CallbackPageSize="10">
                                <ClearButton DisplayMode="OnHover"></ClearButton>
                                <ClientSideEvents SelectedIndexChanged="outletChange" />
                                <Columns>
                                    <dx:ListBoxColumn FieldName="ShiftType" />
                                    <dx:ListBoxColumn FieldName="ShopName" />
                                </Columns>
                            </dx:ASPxComboBox>
                            <asp:ObjectDataSource ID="odsOutlet" runat="server" SelectMethod="getByDay" TypeName="LogicTier.Controllers.WorkingPlanBL">
                                <SelectParameters>
                                    <asp:Parameter Name="empId" Type="Int32" />
                                    <asp:Parameter Name="wkDate" Type="String" />
                                </SelectParameters>
                            </asp:ObjectDataSource>
                        </div>
                        <div class="row" style="margin: 3px 4px 0;">
                           <dx:ASPxComboBox runat="server" ID="cbProduct" ValueField="Product" Width="100%"
                                ValueType="System.String" NullText="Chọn Product" OnInit="cbProduct_Init"
                                ClientInstanceName="cbProduct" CallbackPageSize="10" DataSourceID="odsProduct">
                                <ClearButton DisplayMode="OnHover"></ClearButton>
                                <ClientSideEvents SelectedIndexChanged="productChange" />
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
                        <div class="row">
                            <fieldset class="scheduler-border">
                                <legend class="scheduler-border">Nhập số lượng Tồn</legend>
                                <div class="row">
                                    <div class="col-xs-12">
                                        <asp:Repeater runat="server" ID="rptProduct" DataSourceID="odsStock">
                                            <HeaderTemplate>
                                                <div class="row text-primary">
                                                    <div class="col-xs-7 text-uppercase text-success">
                                                        Sản phẩm
                                                    </div>
                                                    <div class="col-xs-5 text-center text-uppercase text-success">
                                                        SL Tồn
                                                    </div>
                                                </div>
                                            </HeaderTemplate>
                                            <ItemTemplate>
                                                <div class="row marginTop20">
                                                    <div class="col-xs-7 text-info text-left">
                                                        <%# Container.ItemIndex + 1 %>.
                                                        <dx:ASPxLabel runat="server" ID="lbModel" Text='<%# Eval("Model") %>'></dx:ASPxLabel>
                                                    </div>
                                                    <div class="col-xs-5 text-center">
                                                        <dx:ASPxSpinEdit runat="server" ID="txQuantity" ClientInstanceName="txQuantity" MinValue="0" MaxValue="99" Width="100%" MaxLength="2" Text='<%# Eval("Quantity") %>'>
                                                            <SpinButtons ShowIncrementButtons="false"></SpinButtons>
                                                        </dx:ASPxSpinEdit>
                                                    </div>
                                                </div>
                                            </ItemTemplate>
                                        </asp:Repeater>
                                        <asp:ObjectDataSource ID="odsStock" runat="server" SelectMethod="getProduct" TypeName="LogicTier.Controllers.StockBL">
                                            <SelectParameters>
                                                <asp:Parameter Name="empId" Type="Int32" />
                                                <asp:Parameter Name="shopId" Type="Int32" />
                                                <asp:Parameter Name="rpDate" Type="String" />
                                                <asp:Parameter Name="product" Type="String" />
                                            </SelectParameters>
                                        </asp:ObjectDataSource>
                                    </div>
                                </div>
                            </fieldset>
                        </div>
                        <div class="row text-left">
                            <div class="col-xs-12">
                                <dx:ASPxButton runat="server" ID="btSave" ClientInstanceName="btSave" CssClass="btn btn-primary" Text="Lưu" AutoPostBack="false">
                                    <ClientSideEvents Click="function(s,e){ASPxCallbackPanel1.PerformCallback('Save');}" />
                                </dx:ASPxButton>
                                &nbsp;
                                <%--<dx:ASPxButton runat="server" ID="btnConfirm" ClientInstanceName="btnConfirm" CssClass="btn btn-danger" Text="[Khóa dữ liệu]" AutoPostBack="false">
                                    <ClientSideEvents Click="function(s,e){ASPxCallbackPanel1.PerformCallback('Confirm');}" />
                                </dx:ASPxButton>--%>
                            </div>
                        </div>
                    </div>
                </div>
            </dx:PanelContent>
        </PanelCollection>
    </dx:ASPxCallbackPanel>
</asp:Content>
