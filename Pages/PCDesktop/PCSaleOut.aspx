<%@ Page Title="Báo cáo doanh số" Language="C#" MasterPageFile="~/Pages/PCDesktop/PCMaster.Master" AutoEventWireup="true" CodeBehind="PCSaleOut.aspx.cs" Inherits="WebApplication.Pages.PCDesktop.PCSaleOut" %>
<asp:Content ID="Content1" ContentPlaceHolderID="Content" runat="server">
    <script type="text/javascript">
        function OnEndCallback(s, e) {
            if (s.cpAlert != null && s.cpAlert != '') {
                alert(s.cpAlert);
            }
        }
    </script>
    <dx:ASPxCallbackPanel ID="ASPxCallbackPanel1" runat="server" Width="100%"
        ClientInstanceName="cp" OnCallback="ASPxCallbackPanel1_Callback">
        <ClientSideEvents EndCallback="OnEndCallback" />
        <PanelCollection>
            <dx:PanelContent runat="server">
                <div class="row text-center">
                    <div class="col-md-12" style="margin-top: 5px;">
                        <div class="row">
                            <fieldset class="scheduler-border">
                                <legend class="scheduler-border">Báo cáo doanh số</legend>
                                <div class="row text-left">
                                    <div class="col-md-3">
                                        <label>Từ ngày</label>
                                        <dx:ASPxDateEdit runat="server" ID="txFrom" Width="100%" DisplayFormatString="yyyy-MM-dd"
                                            EditFormat="Custom" EditFormatString="yyyy-MM-dd">
                                            <ClearButton DisplayMode="OnHover"></ClearButton>
                                            <ClientSideEvents DateChanged="function(s,e){ASPxCallbackPanel1.PerformCallback('filter');}" />
                                        </dx:ASPxDateEdit>
                                    </div>
                                    <div class="col-md-3">
                                        <label>Đến ngày</label>
                                        <dx:ASPxDateEdit runat="server" ID="txTo" Width="100%" DisplayFormatString="yyyy-MM-dd"
                                            EditFormat="Custom" EditFormatString="yyyy-MM-dd">
                                            <ClearButton DisplayMode="OnHover"></ClearButton>
                                        </dx:ASPxDateEdit>
                                    </div>
                                    <div class="col-md-3">
                                        <label style="color: #FFF">Tool</label><br />
                                        <dx:ASPxButton ID="FilterButton" CssClass="btn btn-primary" AutoPostBack="false" runat="server" Text="Tìm kiếm">
                                            <ClientSideEvents Click="function(s, e) {  cp.PerformCallback('filter'); }"></ClientSideEvents>
                                        </dx:ASPxButton>
                                        <dx:ASPxButton ID="ASPxButton1" AutoPostBack="false" runat="server" CssClass="btn btn-warning" Text="Download">
                                            <ClientSideEvents Click="function(s, e) {  ImageExcelCallbackPanel.PerformCallback(); }"></ClientSideEvents>
                                        </dx:ASPxButton>
                                        <dx:ASPxCallbackPanel runat="server" ID="ImageExcelCallbackPanel" Style="float: right; margin-right: 10px; margin-top: 5px;" ClientInstanceName="ImageExcelCallbackPanel"
                                            OnCallback="ImageExcelCallbackPanel_Callback" SettingsLoadingPanel-Text="Exporting Data, please wait.">
                                            <ClientSideEvents EndCallback="OnEndCallback" />
                                            <PanelCollection>
                                                <dx:PanelContent ID="PanelContent3" runat="server">
                                                    <asp:HyperLink ID="hplexcel" runat="server"></asp:HyperLink>
                                                </dx:PanelContent>
                                            </PanelCollection>
                                        </dx:ASPxCallbackPanel>
                                    </div>
                                </div>
                                <div class="row" style="margin-top: 5px;">
                                    <div class="col-md-12">
                                        <dx:ASPxGridView runat="server" ID="gvSale" ClientInstanceName="gvSale"
                                            AutoGenerateColumns="false" KeyFieldName="SaleId;BlockStatus" Width="100%" EnableCallBacks="false">
                                            <SettingsBehavior ConfirmDelete="true" AllowFocusedRow="True" />
                                            <Styles Header-Wrap="True">
                                                <Header Wrap="True" VerticalAlign="Middle" HorizontalAlign="Center"></Header>
                                                <Cell Wrap="True" VerticalAlign="Middle" HorizontalAlign="Left"></Cell>
                                                <AlternatingRow Enabled="true" />
                                            </Styles>
                                            <Settings ShowFooter="true" />
                                            <Columns>
                                                <dx:GridViewDataTextColumn FieldName="SaleDate" VisibleIndex="0" Caption="Date">
                                                    <PropertiesTextEdit DisplayFormatString="yyyy-MM-dd"></PropertiesTextEdit>
                                                    <EditFormSettings Visible="False" />
                                                    <CellStyle VerticalAlign="Middle" HorizontalAlign="Center"></CellStyle>
                                                </dx:GridViewDataTextColumn>
                                                <dx:GridViewDataTextColumn HeaderStyle-Wrap="True" FieldName="ShopName" Caption="Cửa hàng" VisibleIndex="1">
                                                    <HeaderStyle Wrap="True"></HeaderStyle>
                                                </dx:GridViewDataTextColumn>
                                                <dx:GridViewDataTextColumn HeaderStyle-Wrap="True" FieldName="Model" VisibleIndex="2">
                                                    <HeaderStyle Wrap="True"></HeaderStyle>
                                                </dx:GridViewDataTextColumn>
                                                <dx:GridViewDataTextColumn HeaderStyle-Wrap="True" FieldName="Quantity" Caption="Số lượng" VisibleIndex="3">
                                                    <HeaderStyle Wrap="True"></HeaderStyle>
                                                    <CellStyle HorizontalAlign="Right"></CellStyle>
                                                </dx:GridViewDataTextColumn>
                                                <dx:GridViewDataSpinEditColumn HeaderStyle-Wrap="True" FieldName="Price" Caption="Giá bán" VisibleIndex="4">
                                                    <HeaderStyle Wrap="True"></HeaderStyle>
                                                    <PropertiesSpinEdit DecimalPlaces="3" DisplayFormatString="{0:C}"></PropertiesSpinEdit>
                                                    <CellStyle HorizontalAlign="Right"></CellStyle>
                                                </dx:GridViewDataSpinEditColumn>
                                                <dx:GridViewDataSpinEditColumn HeaderStyle-Wrap="True" FieldName="TotalValue" Caption="Thành tiền" VisibleIndex="5">
                                                    <HeaderStyle Wrap="True"></HeaderStyle>
                                                    <PropertiesSpinEdit DecimalPlaces="3" DisplayFormatString="{0:C}"></PropertiesSpinEdit>
                                                    <CellStyle HorizontalAlign="Right"></CellStyle>
                                                </dx:GridViewDataSpinEditColumn>
                                            </Columns>
                                            <TotalSummary>
                                                <dx:ASPxSummaryItem FieldName="Quantity" SummaryType="Sum" />
                                                <dx:ASPxSummaryItem FieldName="TotalValue" SummaryType="Sum" />
                                            </TotalSummary>
                                        </dx:ASPxGridView>
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