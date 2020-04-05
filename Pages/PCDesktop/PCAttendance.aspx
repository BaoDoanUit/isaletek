<%@ Page Title="Báo cáo chấm công" Language="C#" MasterPageFile="~/Pages/PCDesktop/PCMaster.Master" AutoEventWireup="true" CodeBehind="PCAttendance.aspx.cs" Inherits="WebApplication.Pages.PCDesktop.PCAttendance" %>
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
                                <legend class="scheduler-border">Báo cáo chấm công</legend>
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
                                    <div class="col-md-4">
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
                                        <dx:ASPxGridView runat="server" ID="gvAttendance" ClientInstanceName="gvAttendance"
                                            AutoGenerateColumns="false" Width="100%" EnableCallBacks="false">
                                            <SettingsBehavior ConfirmDelete="true" AllowFocusedRow="True" />
                                            <Styles Header-Wrap="True">
                                                <Header Wrap="True" VerticalAlign="Middle" HorizontalAlign="Center"></Header>
                                                <Cell Wrap="True" VerticalAlign="Middle" HorizontalAlign="Left"></Cell>
                                                <AlternatingRow Enabled="true" />
                                            </Styles>
                                            <Settings ShowFooter="true" />
                                            <Columns>
                                                <dx:GridViewDataTextColumn FieldName="WorkingDate" VisibleIndex="0" Caption="Ngày">
                                                    <PropertiesTextEdit DisplayFormatString="yyyy-MM-dd"></PropertiesTextEdit>
                                                    <EditFormSettings Visible="False" />
                                                    <CellStyle VerticalAlign="Middle" HorizontalAlign="Center"></CellStyle>
                                                </dx:GridViewDataTextColumn>
                                                <dx:GridViewDataTextColumn HeaderStyle-Wrap="True" FieldName="ShopName" Caption="Cửa hàng" VisibleIndex="1">
                                                    <HeaderStyle Wrap="True"></HeaderStyle>
                                                </dx:GridViewDataTextColumn>
                                                <dx:GridViewDataTextColumn HeaderStyle-Wrap="True" FieldName="ShiftType" Caption="Ca" VisibleIndex="2">
                                                    <HeaderStyle Wrap="True"></HeaderStyle>
                                                    <CellStyle HorizontalAlign="Center"></CellStyle>
                                                </dx:GridViewDataTextColumn>
                                                <dx:GridViewDataTextColumn HeaderStyle-Wrap="True" FieldName="FromTime" Caption="Từ" VisibleIndex="3">
                                                    <CellStyle HorizontalAlign="Center"></CellStyle>
                                                </dx:GridViewDataTextColumn>
                                                <dx:GridViewDataTextColumn HeaderStyle-Wrap="True" FieldName="ToTime" Caption="Đến" VisibleIndex="4">
                                                    <CellStyle HorizontalAlign="Center"></CellStyle>
                                                </dx:GridViewDataTextColumn>
                                                <dx:GridViewDataColumn VisibleIndex="5" Caption="CHECK IN">
                                                    <CellStyle HorizontalAlign="Center"></CellStyle>
                                                    <DataItemTemplate>
                                                        <%# !string.IsNullOrEmpty(Convert.ToString(Eval("ShiftType"))) ? Eval("StatusIn") + ":" + Eval("CheckInTime") : "" %>
                                                    </DataItemTemplate>
                                                </dx:GridViewDataColumn>
                                                <dx:GridViewDataColumn VisibleIndex="6" Caption="CHECK OUT">
                                                    <CellStyle HorizontalAlign="Center"></CellStyle>
                                                    <DataItemTemplate>
                                                        <%# !string.IsNullOrEmpty(Convert.ToString(Eval("ShiftType"))) ? Eval("StatusOut") + ":" + Eval("CheckOutTime") : "" %>
                                                    </DataItemTemplate>
                                                </dx:GridViewDataColumn>
                                            </Columns>
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