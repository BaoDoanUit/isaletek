<%@ Page Title="Báo cáo thị trường" Language="C#" MasterPageFile="~/Layout.master" AutoEventWireup="true" CodeBehind="Compertitor.aspx.cs" Inherits="WebApplication.Pages.Employee.Compertitor" Async="true" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Content" runat="server">
    <script type="text/javascript">
        function OnEndCallback(s, e) {
            if (s.cpAlert != '') {
                alert(s.cpAlert);
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
    <dx:ASPxCallbackPanel ID="ASPxCallbackPanel1" runat="server" Width="100%"
        ClientInstanceName="ASPxCallbackPanel1" OnCallback="ASPxCallbackPanel1_Callback">
        <ClientSideEvents EndCallback="OnEndCallback" />
        <PanelCollection>
            <dx:PanelContent runat="server">
                <div class="row text-center">
                    <h3>Số bán thị trường</h3>
                    <h4></h4>
                    <div class="col-xs-12" style="margin-top: 5px;">
                        <div class="row" style="margin: 0 4px;">
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
                        <div class="row marginTop20">
                            <dx:ASPxPageControl ID="ASPxPageControl1" runat="server" ActiveTabIndex="0" Width="100%">
                                <TabPages>
                                    <dx:TabPage Text="BC Giá">
                                        <ContentCollection>
                                            <dx:ContentControl runat="server">
                                                <div class="row" style="margin: 15px;">
                                                    <div class="row marginTop5 text-left">
                                                        <div class="col-xs-12 text-primary">
                                                            <dx:ASPxLabel runat="server" ID="ASPxLabel1" Text="Ngành hàng:"></dx:ASPxLabel>
                                                            <dx:ASPxLabel runat="server" ID="lbProduct" Text="REF"></dx:ASPxLabel>
                                                        </div>
                                                    </div>
                                                    <div class="row marginTop10">
                                                        <dx:ASPxComboBox runat="server" ID="cbCompetitorName" Width="100%"
                                                            ValueType="System.String" NullText="Chọn Brand" ValueField="ObjectName"
                                                            ClientInstanceName="cbCompetitorName"
                                                            IncrementalFilteringMode="Contains" TextFormatString="{0}" EnableCallbackMode="true"
                                                            DropDownStyle="DropDownList" DataSourceID="odsObjectData">
                                                            <ClientSideEvents SelectedIndexChanged="function(s,e){ASPxCallbackPanel1.PerformCallback('bindPri;'+s.GetValue());}" />
                                                            <ClearButton DisplayMode="OnHover"></ClearButton>
                                                            <Columns>
                                                                <dx:ListBoxColumn Caption="Brand" FieldName="ObjectName" />
                                                            </Columns>
                                                        </dx:ASPxComboBox>
                                                        <asp:ObjectDataSource ID="odsObjectData" runat="server" SelectMethod="getlist" TypeName="LogicTier.Controllers.ObjectDataBL">
                                                            <SelectParameters>
                                                                <asp:Parameter Name="objId" Type="Int32" />
                                                                <asp:Parameter DefaultValue="Compertitor" Name="objType" Type="String" />
                                                            </SelectParameters>
                                                        </asp:ObjectDataSource>
                                                    </div>
                                                    <div class="row marginTop10">
                                                        <dx:ASPxComboBox runat="server" ID="cbType" Width="100%"
                                                            ValueType="System.String" NullText="Chọn Type"
                                                            ClientInstanceName="cbType"
                                                            IncrementalFilteringMode="Contains" TextFormatString="{0}" EnableCallbackMode="true" DropDownStyle="DropDownList">
                                                            <ClearButton DisplayMode="OnHover"></ClearButton>
                                                            <Items>
                                                                <dx:ListEditItem Text="1D" Value="1D" />
                                                                <dx:ListEditItem Text="2D" Value="2D" />
                                                                <dx:ListEditItem Text="BF" Value="BF" />
                                                                <dx:ListEditItem Text="Big4" Value="Big4" />
                                                                <dx:ListEditItem Text="Multidoor" Value="Multidoor" />
                                                                <dx:ListEditItem Text="SBS" Value="SBS" />
                                                            </Items>
                                                        </dx:ASPxComboBox>
                                                    </div>
                                                    <div class="row marginTop10">
                                                        <dx:ASPxTextBox runat="server" ID="txModel" NullText="Nhập Model" Width="100%"></dx:ASPxTextBox>
                                                    </div>
                                                    <div class="row marginTop10">
                                                        <dx:ASPxSpinEdit runat="server" ID="txPrice" ClientInstanceName="txPrice" NullText="Nhập giá bán" Width="100%" MaxLength="9" DecimalPlaces="3" DisplayFormatString="{0:C}">
                                                            <SpinButtons ShowIncrementButtons="false"></SpinButtons>
                                                        </dx:ASPxSpinEdit>
                                                    </div>
                                                    <div class="row text-left marginTop20">
                                                        <dx:ASPxButton runat="server" ID="btPricing" ClientInstanceName="btPricing" CssClass="btn btn-primary" Text="Lưu" AutoPostBack="false">
                                                            <ClientSideEvents Click="function(s,e){ASPxCallbackPanel1.PerformCallback('Pricing');}" />
                                                        </dx:ASPxButton>
                                                    </div>
                                                </div>
                                            </dx:ContentControl>
                                        </ContentCollection>
                                    </dx:TabPage>
                                    <dx:TabPage Text="Thị phần TB">
                                        <ContentCollection>
                                            <dx:ContentControl runat="server">
                                                <div class="row" style="margin: 15px;">
                                                    <div class="row marginTop5">
                                                        <dx:ASPxComboBox runat="server" ID="cbCompetitorName2" Width="100%"
                                                            ValueType="System.String" NullText="Chọn Brand" ValueField="ObjectName"
                                                            ClientInstanceName="cbCompetitorName2" DataSourceID="odsObjectData"
                                                            IncrementalFilteringMode="Contains" TextFormatString="{0}" EnableCallbackMode="true" DropDownStyle="DropDownList">
                                                            <ClearButton DisplayMode="OnHover"></ClearButton>
                                                            <ClientSideEvents SelectedIndexChanged="function(s,e){ASPxCallbackPanel1.PerformCallback('bindDpl;'+s.GetValue());}" />
                                                            <Columns>
                                                                <dx:ListBoxColumn Caption="Brand" FieldName="ObjectName" />
                                                            </Columns>
                                                        </dx:ASPxComboBox>
                                                    </div>
                                                    <div class="row marginTop10">
                                                        <div class="col-xs-3">
                                                            REF:
                                                        </div>
                                                        <div class="col-xs-9">
                                                            <dx:ASPxSpinEdit runat="server" ID="txREF" ClientInstanceName="txREF" NullText="Nhập số lượng REF" Width="100%" MaxLength="2">
                                                                <SpinButtons ShowIncrementButtons="false"></SpinButtons>
                                                            </dx:ASPxSpinEdit>
                                                        </div>
                                                    </div>
                                                    <div class="row marginTop10">
                                                        <div class="col-xs-3">
                                                            WM:
                                                        </div>
                                                        <div class="col-xs-9">
                                                            <dx:ASPxSpinEdit runat="server" ID="txWM" ClientInstanceName="txWM" NullText="Nhập số lượng WM" Width="100%" MaxLength="2">
                                                                <SpinButtons ShowIncrementButtons="false"></SpinButtons>
                                                            </dx:ASPxSpinEdit>
                                                        </div>
                                                    </div>
                                                    <div class="row marginTop10">
                                                        <div class="col-xs-3">
                                                            RAC:
                                                        </div>
                                                        <div class="col-xs-9">
                                                            <dx:ASPxSpinEdit runat="server" ID="txRAC" ClientInstanceName="txRAC" NullText="Nhập số lượng RAC" Width="100%" MaxLength="2">
                                                                <SpinButtons ShowIncrementButtons="false"></SpinButtons>
                                                            </dx:ASPxSpinEdit>
                                                        </div>
                                                    </div>
                                                    <div class="row marginTop10">
                                                        <div class="col-xs-3">
                                                            VC:
                                                        </div>
                                                        <div class="col-xs-9">
                                                            <dx:ASPxSpinEdit runat="server" ID="txVC" ClientInstanceName="txVC" NullText="Nhập số lượng VC" Width="100%" MaxLength="2">
                                                                <SpinButtons ShowIncrementButtons="false"></SpinButtons>
                                                            </dx:ASPxSpinEdit>
                                                        </div>
                                                    </div>
                                                    <div class="row marginTop10">
                                                        <div class="col-xs-3">
                                                            RC:
                                                        </div>
                                                        <div class="col-xs-9">
                                                            <dx:ASPxSpinEdit runat="server" ID="txRC" ClientInstanceName="txRC" NullText="Nhập số lượng RC" Width="100%" MaxLength="2">
                                                                <SpinButtons ShowIncrementButtons="false"></SpinButtons>
                                                            </dx:ASPxSpinEdit>
                                                        </div>
                                                    </div>
                                                    <div class="row marginTop10">
                                                        <div class="col-xs-3">
                                                            AP:
                                                        </div>
                                                        <div class="col-xs-9">
                                                            <dx:ASPxSpinEdit runat="server" ID="txAP" ClientInstanceName="txAP" NullText="Nhập số lượng AP" Width="100%" MaxLength="2">
                                                                <SpinButtons ShowIncrementButtons="false"></SpinButtons>
                                                            </dx:ASPxSpinEdit>
                                                        </div>
                                                    </div>
                                                    <div class="row text-left marginTop20">
                                                        <dx:ASPxButton runat="server" ID="btDisplay" ClientInstanceName="btDisplay" CssClass="btn btn-primary" Text="Lưu" AutoPostBack="false">
                                                            <ClientSideEvents Click="function(s,e){ASPxCallbackPanel1.PerformCallback('Display');}" />
                                                        </dx:ASPxButton>
                                                    </div>
                                                </div>
                                            </dx:ContentControl>
                                        </ContentCollection>
                                    </dx:TabPage>
                                </TabPages>
                            </dx:ASPxPageControl>
                        </div>
                        <div class="row marginTop05 text-left">
                            <div class="col-xs-12">
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
