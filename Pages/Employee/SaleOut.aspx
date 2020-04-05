<%@ Page Title="Sales Out" Language="C#" MasterPageFile="~/Layout.master" AutoEventWireup="true" CodeBehind="SaleOut.aspx.cs" Inherits="WebApplication.Pages.Employee.SaleOut" Async="true" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Content" runat="server">
    <script type="text/javascript">
        function OnEndCallback(s, e) {
            if (s.cpAlert != '') {
                alert(s.cpAlert);
            }
        }
        function gvOnEndCallback(s, e) {
            if (s.cpSale != '') {
                alert(s.cpSale);
            }
        }
        function productChange(s, e) {
            cbModel.PerformCallback(s.GetValue());
            cbColor.PerformCallback(s.GetValue());
        }
        function updateTotal(s, e) {
            var qty = txQuantity.GetText();
            var pri = txPrice.GetValue();
            if (!isNaN(qty) && !isNaN(pri)) {
                var total = parseInt(qty) * parseFloat(pri);
                lbTotalValue.SetText(
                    total.toLocaleString('vi-VN', {
                        style: 'currency',
                        currency: 'VND'
                    })
                );
            }
        }
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
    </style>
    
    <style>
        .modal-dialog {
            top: 30%;
        }

        .modal {
            background-color: rgba(242, 242, 242, 0.24);
        }
    </style>
    <dx:ASPxCallbackPanel ID="ASPxCallbackPanel1" runat="server" Width="100%"
        ClientInstanceName="ASPxCallbackPanel1" OnCallback="ASPxCallbackPanel1_Callback">
        <ClientSideEvents EndCallback="OnEndCallback" />
        <PanelCollection>
            <dx:PanelContent runat="server">
                <div class="row text-center">
                    <h3>Báo cáo doanh số</h3>
                    <div class="col-xs-12" style="margin-top: 5px;">
                        <div class="row" style="margin: 0 4px;">
                            <asp:HiddenField runat="server" ID="hfSaleId" />
                            <dx:ASPxComboBox runat="server" ID="cbxOutlets" Width="100%" OnInit="cbxOutlets_Init" NullText="Chọn cửa hàng"
                                DataSourceID="odsOutlet" ValueField="ShopId" ValueType="System.Int32"
                                EnableCallbackMode="true" ClientInstanceName="Outlets" CallbackPageSize="10">
                                <ClearButton DisplayMode="OnHover"></ClearButton>
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
                        <div class="row">
                            <fieldset class="scheduler-border">
                                <legend class="scheduler-border">Thông tin số bán</legend>
                                <div class="row">
                                    <div class="col-xs-12">
                                        <dx:ASPxComboBox runat="server" ID="cbProduct" ValueField="Product" Width="100%"
                                            ValueType="System.String" NullText="Chọn Product" OnInit="cbProduct_Init"
                                            ClientInstanceName="cbProduct" CallbackPageSize="10" DataSourceID="odsProduct"
                                            IncrementalFilteringMode="Contains" TextFormatString="{0}" EnableCallbackMode="true" DropDownStyle="DropDownList">
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
                                </div>
                                <div class="row marginTop20">
                                    <div class="col-xs-12">
                                        <dx:ASPxComboBox runat="server" ID="cbModel" ValueType="System.Int32" NullText="Chọn Model" Width="100%"
                                            DataSourceID="odsModel" ValueField="ProductId" OnCallback="cbModel_Callback" OnInit="cbModel_Init"
                                            ClientInstanceName="cbModel" CallbackPageSize="10"
                                            IncrementalFilteringMode="Contains" TextFormatString="{0}" EnableCallbackMode="true" DropDownStyle="DropDownList">
                                            <ClearButton DisplayMode="OnHover"></ClearButton>
                                            <ClientSideEvents SelectedIndexChanged="
                                                function(s,e){
                                                    ASPxCallbackPanel1.PerformCallback('product;'+s.GetValue());
                                                }" />
                                            <Columns>
                                                <dx:ListBoxColumn FieldName="Model" />
                                            </Columns>
                                        </dx:ASPxComboBox>
                                        <asp:ObjectDataSource ID="odsModel" runat="server" SelectMethod="getList" TypeName="LogicTier.Controllers.ProductsBL">
                                            <SelectParameters>
                                                <asp:Parameter Name="productId" Type="Int32" />
                                                <asp:Parameter Name="product" Type="String" />
                                                <asp:Parameter Name="range" Type="String" />
                                                <asp:Parameter Name="model" Type="String" />
                                                <asp:Parameter Name="capacity" Type="String" />
                                                <asp:Parameter Name="type" Type="String" />
                                                <asp:Parameter Name="status" Type="Boolean" />
                                            </SelectParameters>
                                        </asp:ObjectDataSource>
                                    </div>
                                </div>
                                <div class="row marginTop10 text-left">
                                    <div class="col-xs-3">
                                        Range:
                                    </div>
                                    <div class="col-xs-9 text-left">
                                        <dx:ASPxLabel runat="server" ID="lbRange" CssClass="text-info"></dx:ASPxLabel>
                                    </div>
                                </div>
                                <div class="row marginTop10 text-left">
                                    <div class="col-xs-3">
                                        Capacity:
                                    </div>
                                    <div class="col-xs-9 text-left">
                                        <dx:ASPxLabel runat="server" ID="lbCapacity" CssClass="text-info"></dx:ASPxLabel>
                                    </div>
                                </div>
                                <div class="row marginTop10 text-left">
                                    <div class="col-xs-3">
                                        Type:
                                    </div>
                                    <div class="col-xs-9 text-left">
                                        <dx:ASPxLabel runat="server" ID="lbType" CssClass="text-info"></dx:ASPxLabel>
                                    </div>
                                </div>
                                <div class="row marginTop20">
                                    <div class="col-xs-12">
                                        <dx:ASPxComboBox runat="server" ID="cbColor" ValueType="System.String" NullText="Chọn Màu" Width="100%"
                                            DataSourceID="odsColor" ValueField="ObjectName" OnCallback="cbColor_Callback"
                                            ClientInstanceName="cbColor" CallbackPageSize="10"
                                            IncrementalFilteringMode="Contains" TextFormatString="{0}" EnableCallbackMode="true" DropDownStyle="DropDownList">
                                            <ClearButton DisplayMode="OnHover"></ClearButton>
                                            <Columns>
                                                <dx:ListBoxColumn FieldName="ObjectName" Caption="Màu" />
                                            </Columns>
                                        </dx:ASPxComboBox>
                                        <asp:ObjectDataSource ID="odsColor" runat="server" SelectMethod="getlist" TypeName="LogicTier.Controllers.ObjectDataBL">
                                            <SelectParameters>
                                                <asp:Parameter Name="objId" Type="Int32" />
                                                <asp:Parameter Name="objType" Type="String" />
                                            </SelectParameters>
                                        </asp:ObjectDataSource>
                                    </div>
                                </div>
                                <div class="row marginTop20">
                                    <div class="col-xs-12">
                                        <dx:ASPxSpinEdit runat="server" ID="txQuantity" ClientInstanceName="txQuantity" NullText="Nhập số bán" Width="100%" MaxLength="2">
                                            <SpinButtons ShowIncrementButtons="false"></SpinButtons>
                                            <ClientSideEvents NumberChanged="updateTotal" />
                                        </dx:ASPxSpinEdit>
                                    </div>
                                </div>
                                <div class="row marginTop20">
                                    <div class="col-xs-12">
                                        <dx:ASPxSpinEdit runat="server" ID="txPrice" ClientInstanceName="txPrice" NullText="Nhập giá bán" Width="100%" MaxLength="9" DecimalPlaces="3" DisplayFormatString="{0:C}">
                                            <SpinButtons ShowIncrementButtons="false"></SpinButtons>
                                            <ClientSideEvents NumberChanged="updateTotal" />
                                        </dx:ASPxSpinEdit>
                                    </div>
                                </div>
                                <div class="row marginTop20">
                                    <div class="col-xs-12 text-left">
                                        <b>Thành tiền:</b>
                                        <dx:ASPxLabel runat="server" ID="lbTotalValue" ClientInstanceName="lbTotalValue" CssClass="text-success"></dx:ASPxLabel>
                                    </div>
                                </div>
                            </fieldset>
                            <fieldset class="scheduler-border">
                                <legend class="scheduler-border">Thông tin khách hàng</legend>
                                <div class="row">
                                    <div class="col-xs-12">
                                        <dx:ASPxTextBox runat="server" ID="txCustomerName" NullText="Tên khách hàng" Width="100%"></dx:ASPxTextBox>
                                    </div>
                                </div>
                                <div class="row marginTop20">
                                    <div class="col-xs-12">
                                        <dx:ASPxTextBox runat="server" ID="txMobile" NullText="Số điện thoại" Width="100%"></dx:ASPxTextBox>
                                    </div>
                                </div>
                                <div class="row marginTop20">
                                    <div class="col-xs-12">
                                        <dx:ASPxTextBox runat="server" ID="txAddress" NullText="Địa chỉ khách hàng" Width="100%"></dx:ASPxTextBox>
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
                                <dx:ASPxButton runat="server" ID="btnClearText" ClientInstanceName="btnClearText" CssClass="btn btn-link" Text="Tạo mới" Visible="false" OnClick="btnClearText_Click">
                                </dx:ASPxButton>
                                &nbsp;
                                <%--<dx:ASPxButton runat="server" ID="btnConfirm" ClientInstanceName="btnConfirm" CssClass="btn btn-danger" Text="[Khóa dữ liệu]" AutoPostBack="false">
                                    <ClientSideEvents Click="function(s,e){
                                        if(confirm('Bạn có muốn khóa dữ liệu không?'))
                                            ASPxCallbackPanel1.PerformCallback('Confirm');
                                    }" />
                                </dx:ASPxButton>--%>
                            </div>
                        </div>
                        <div class="row">
                            <fieldset class="scheduler-border">
                                <legend class="scheduler-border">Doanh số bán</legend>
                                <div class="row">
                                    <div class="col-xs-12">
                                        <dx:ASPxDateEdit runat="server" ID="txReportDate" DisplayFormatString="yyyy-MM-dd"
                                            EditFormat="Custom" EditFormatString="yyyy-MM-dd">
                                            <ClearButton DisplayMode="OnHover"></ClearButton>
                                            <ClientSideEvents DateChanged="function(s,e){ASPxCallbackPanel1.PerformCallback('filter');}" />
                                        </dx:ASPxDateEdit>
                                    </div>
                                </div>
                                <div class="row" style="margin-top: 5px;">
                                    <div class="col-xs-12">
                                        <dx:ASPxGridView runat="server" ID="gvSale" ClientInstanceName="gvSale" OnCustomButtonCallback="gvSale_CustomButtonCallback"
                                            AutoGenerateColumns="false" OnInit="gvSale_Init" OnRowDeleting="gvSale_RowDeleting" OnDataBound="gvSale_DataBound" OnLoad="gvSale_Load"
                                            KeyFieldName="SaleId;BlockStatus" DataSourceID="odsSale" Width="100%" EnableCallBacks="false">
                                            <ClientSideEvents EndCallback="gvOnEndCallback" />
                                            <SettingsCommandButton>
                                                <DeleteButton Text="Xóa"></DeleteButton>
                                            </SettingsCommandButton>
                                            <SettingsBehavior ConfirmDelete="true" AllowFocusedRow="True" />
                                            <SettingsText ConfirmDelete="Bạn có muốn xóa không?" />
                                            <Styles Header-Wrap="True">
                                                <Header Wrap="True" VerticalAlign="Middle" HorizontalAlign="Center"></Header>
                                                <Cell Wrap="True" VerticalAlign="Middle" HorizontalAlign="Left"></Cell>
                                                <AlternatingRow Enabled="true" />
                                            </Styles>
                                            <Settings ShowFooter="true" />
                                            <Columns>
                                                <dx:GridViewCommandColumn VisibleIndex="0" Visible="false">
                                                    <CustomButtons>
                                                        <dx:GridViewCommandColumnCustomButton ID="btnEdit" Text="Sửa">
                                                        </dx:GridViewCommandColumnCustomButton>
                                                    </CustomButtons>
                                                </dx:GridViewCommandColumn>
                                                <dx:GridViewDataTextColumn HeaderStyle-Wrap="True" FieldName="Model" VisibleIndex="1">
                                                    <HeaderStyle Wrap="True"></HeaderStyle>
                                                </dx:GridViewDataTextColumn>
                                                <dx:GridViewDataTextColumn HeaderStyle-Wrap="True" FieldName="Quantity" Caption="Số lượng" VisibleIndex="2">
                                                    <HeaderStyle Wrap="True"></HeaderStyle>
                                                    <CellStyle HorizontalAlign="Right"></CellStyle>
                                                </dx:GridViewDataTextColumn>
                                                <dx:GridViewDataSpinEditColumn HeaderStyle-Wrap="True" FieldName="Price" Caption="Giá bán" VisibleIndex="3">
                                                    <HeaderStyle Wrap="True"></HeaderStyle>
                                                    <PropertiesSpinEdit DecimalPlaces="3" DisplayFormatString="{0:C}"></PropertiesSpinEdit>
                                                    <CellStyle HorizontalAlign="Right"></CellStyle>
                                                </dx:GridViewDataSpinEditColumn>
                                                <dx:GridViewDataSpinEditColumn HeaderStyle-Wrap="True" FieldName="TotalValue" Caption="Thành tiền" VisibleIndex="4">
                                                    <HeaderStyle Wrap="True"></HeaderStyle>
                                                    <PropertiesSpinEdit DecimalPlaces="3" DisplayFormatString="{0:C}"></PropertiesSpinEdit>
                                                    <CellStyle HorizontalAlign="Right"></CellStyle>
                                                </dx:GridViewDataSpinEditColumn>
                                                <dx:GridViewCommandColumn ShowDeleteButton="true" VisibleIndex="5" Visible="false">
                                                </dx:GridViewCommandColumn>
                                            </Columns>
                                            <TotalSummary>
                                                <dx:ASPxSummaryItem FieldName="Quantity" SummaryType="Sum" />
                                                <dx:ASPxSummaryItem FieldName="TotalValue" SummaryType="Sum" />
                                            </TotalSummary>
                                        </dx:ASPxGridView>
                                        <asp:ObjectDataSource ID="odsSale" runat="server" SelectMethod="getList" TypeName="LogicTier.Controllers.SaleOutBL">
                                            <SelectParameters>
                                                <asp:Parameter Name="userName" Type="String" />
                                                <asp:Parameter Name="empId" Type="Int32" />
                                                <asp:Parameter Name="saleId" Type="Int64" />
                                                <asp:Parameter Name="productId" Type="Int32" />
                                                <asp:Parameter Name="product" Type="String" />
                                                <asp:Parameter Name="range" Type="String" />
                                                <asp:Parameter Name="capacity" Type="String" />
                                                <asp:Parameter Name="type" Type="String" />
                                                <asp:Parameter Name="model" Type="String" />
                                                <asp:Parameter Name="from" Type="String" />
                                                <asp:Parameter Name="to" Type="String" />
                                            </SelectParameters>
                                        </asp:ObjectDataSource>
                                    </div>
                                </div>
                            </fieldset>
                        </div>
                    </div>
                </div>
            </dx:PanelContent>
        </PanelCollection>
    </dx:ASPxCallbackPanel>
</asp:Content>
