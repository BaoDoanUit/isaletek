<%@ Page Title="Issued" Language="C#" MasterPageFile="~/Layout.master" AutoEventWireup="true" CodeBehind="Issuedlist.aspx.cs" Inherits="WebApplication.Pages.Employee.Issuedlist" Async="true" %>

<%@ Import Namespace="System.Globalization" %>
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
    <script type="text/javascript">
        //for upload image

        function OnEndCallback(s, e) {
            if (s.cpAlert != '') {
                alert(s.cpAlert);
            }
        }
        function outletChange() {
            ASPxCallbackPanel1.PerformCallback();
        }
        function productChange(s, e) {
            ASPxCallbackPanel1.PerformCallback();
        }
        function SaveData() {
            var file = document.getElementById("canImg").toDataURL("image/jpeg");
            var images = file.replace("data:image/jpeg;base64,", "");
            //var lat = document.getElementById('lat').innerHTML;
            //var lng = document.getElementById('lng').innerHTML;

            var shop = Outlets.GetValue();
            if (shop === null)
                shop = '';

            var cm = txComment.GetText();
            if (cm === null)
                cm = '';

            var val = images + '][' + shop + '][' + cm;
            return val;
        }
    </script>
    <dx:ASPxCallbackPanel ID="ASPxCallbackPanel1" runat="server" Width="100%"
        ClientInstanceName="ASPxCallbackPanel1" OnCallback="ASPxCallbackPanel1_Callback">
        <ClientSideEvents EndCallback="OnEndCallback" />
        <PanelCollection>
            <dx:PanelContent runat="server">
                <div class="row text-center">
                    <h3>Báo cáo Issued</h3>
                    <div class="col-xs-12" style="margin-top: 5px;">
                        <div class="row">
                            <asp:HiddenField runat="server" ID="hfSaleId" />
                            <fieldset class="scheduler-border">
                                <div class="row marginTop20">
                                    <div class="col-xs-12">
                                        <div class="row" style="margin: 0 4px;">
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
                                    </div>
                                </div>
                                <div class="row marginTop20">
                                    <div class="col-xs-12">
                                        <div class="row" style="margin: 0 4px;">
                                            <dx:ASPxComboBox runat="server" ID="cboProduct" Width="100%" NullText="Chọn Product"
                                                ValueType="System.String" EnableViewState="false"
                                                EnableCallbackMode="true" ClientInstanceName="cboproduct" CallbackPageSize="10">
                                                <ClearButton DisplayMode="OnHover"></ClearButton>
                                                <ClientSideEvents SelectedIndexChanged="productChange" />
                                                <Items>
                                                    <dx:ListEditItem Text="--None--" Value="" />
                                                    <dx:ListEditItem Text="REF" Value="REF" />
                                                    <dx:ListEditItem Text="RAC" Value="RAC" />
                                                    <dx:ListEditItem Text="AP" Value="AP" />
                                                </Items>
                                            </dx:ASPxComboBox>
                                            <asp:ObjectDataSource ID="odsProduct" runat="server" SelectMethod="GetProductIssue" TypeName="LogicTier.Controllers.ProductsBL"></asp:ObjectDataSource>
                                        </div>
                                    </div>
                                </div>
                            </fieldset>
                        </div>
                        <div class="col-xs-12">
                            <dx:ASPxButton ID="btnNew" AutoPostBack="false" runat="server" Text="Issue mới">
                                <ClientSideEvents Click="function(s, e) { document.location.href = 'Issued.aspx'  ; }"></ClientSideEvents>
                            </dx:ASPxButton>
                        </div>
                        <div class="row">
                            <%--<ClientSideEvents CustomButtonClick="function(s, e) {var link = 'Issued.aspx?Id=' + e.nodeKey; window.location.href = link; }" />--%>
                            <fieldset class="scheduler-border">
                                <legend class="scheduler-border">Danh sách issue đã báo</legend>
                                <div class="col-xs-12">
                                    <dx:ASPxTreeList ID="treeList" runat="server" AutoGenerateColumns="false" Width="100%" DataSourceID="odsIssued"
                                        ClientInstanceName="treeList" KeyFieldName="Id" ParentFieldName="ParentID"                                        
                                        >
                                        <Settings GridLines="Both" />
                                        <SettingsEditing Mode="EditForm" />
                                        <SettingsBehavior ExpandCollapseAction="NodeDblClick" />
                                        <Styles Header-Wrap="True">
                                            <Header Wrap="True" VerticalAlign="Middle" HorizontalAlign="Center"></Header>
                                            <Cell Wrap="True" VerticalAlign="Middle" HorizontalAlign="Left"></Cell>
                                        </Styles>
                                        <ClientSideEvents CustomButtonClick="function(s, e) {var link = 'Issued.aspx?Id=' + e.nodeKey; window.location.href = link; }" />
                                        <Columns>
                                            <dx:TreeListDataColumn FieldName="IssueName" Caption="Tên Issue" VisibleIndex="0">
                                            </dx:TreeListDataColumn>
                                            <dx:TreeListDataColumn FieldName="IssuedState" Caption="Tên Issue" VisibleIndex="1">
                                            </dx:TreeListDataColumn>
                                            <dx:TreeListDateTimeColumn FieldName="ReportDate" Caption="Ngày báo" VisibleIndex="2">
                                                <PropertiesDateEdit DisplayFormatString="dd/MM/yyyy"></PropertiesDateEdit>
                                            </dx:TreeListDateTimeColumn>
                                            <dx:TreeListCommandColumn ShowNewButtonInHeader="false" VisibleIndex="3">
                                                <CustomButtons>
                                                    <dx:TreeListCommandColumnCustomButton ID="btnEdit" Text="Báo Issue">
                                                    </dx:TreeListCommandColumnCustomButton>
                                                </CustomButtons>
                                                
                                            </dx:TreeListCommandColumn>
                                            <dx:TreeListDataColumn FieldName="" VisibleIndex="4" Visible="false"></dx:TreeListDataColumn>
                                        </Columns>                                        
                                    </dx:ASPxTreeList>
                                    <asp:ObjectDataSource ID="odsIssued" runat="server" SelectMethod="GetListbyProduct" TypeName="LogicTier.Controllers.IssuedBL">
                                        <SelectParameters>
                                            <asp:ControlParameter ControlID="hdfKey" Name="UserName" PropertyName="['UserName']" Type="String" />
                                            <asp:Parameter Name="Id" Type="Int64" DefaultValue="" ConvertEmptyStringToNull="true" />
                                            <asp:ControlParameter ControlID="cboProduct" Name="Product" Type="String" PropertyName="Value" />
                                            <asp:ControlParameter ControlID="cbxOutlets" Name="shopId" Type="String" PropertyName="Value" />
                                            <asp:ControlParameter ControlID="hdfKey" Name="FromDate" PropertyName="['FromDate']" Type="String" />
                                            <asp:ControlParameter ControlID="hdfKey" Name="ToDate" PropertyName="['ToDate']" Type="String" />
                                        </SelectParameters>
                                    </asp:ObjectDataSource>
                                </div>
                            </fieldset>
                        </div>
                    </div>
                </div>
            </dx:PanelContent>
        </PanelCollection>
    </dx:ASPxCallbackPanel>
    <dx:ASPxHiddenField ID="hdfKey" ClientInstanceName="hdfKey" runat="server"></dx:ASPxHiddenField>
</asp:Content>
