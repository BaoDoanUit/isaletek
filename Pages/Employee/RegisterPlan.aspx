<%@ Page Title="Register Plan" Language="C#" MasterPageFile="~/Layout.master" AutoEventWireup="true" CodeBehind="RegisterPlan.aspx.cs" Inherits="WebApplication.Pages.Employee.RegisterPlan" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Content" runat="server">
    <script type="text/javascript">
        function OnEndCallback(s, e) {
            if (s.cpAlert != null && s.cpAlert != "") {
                alert(s.cpAlert);
            }
        }
        function OnEndCallback2(s, e) {
            if (s.cpAlert != null && s.cpAlert != "") {
                alert(s.cpAlert);
            }
        }
        function gvEndCallback(s, e) {
            if (s.cpAlert != '') {
                alert(s.cpAlert);
            }
        }
        function PopupClick(element, key) {
            cp2.PerformCallback("edit;" +key);
            pcImport.Show();
        }
    </script>
    <div class="container">
        <div class="row marginTop20">
            <div class="col-xs-12">
                <h4>Lịch làm việc</h4>
                <div class="row">
                    Từ ngày:&nbsp; 
                     <dx:ASPxDateEdit runat="server" ID="txFromDate" DisplayFormatString="yyyy-MM-dd"
                         EditFormat="Custom" EditFormatString="yyyy-MM-dd">
                         <CalendarProperties FirstDayOfWeek="Monday"></CalendarProperties>
                         <ClearButton DisplayMode="OnHover"></ClearButton>
                     </dx:ASPxDateEdit>
                </div>
                <div class="row marginTop05">
                    Đến ngày:&nbsp; 
                     <dx:ASPxDateEdit runat="server" ID="txToDate" DisplayFormatString="yyyy-MM-dd"
                         EditFormat="Custom" EditFormatString="yyyy-MM-dd">
                         <CalendarProperties FirstDayOfWeek="Monday"></CalendarProperties>
                         <ClearButton DisplayMode="OnHover"></ClearButton>
                     </dx:ASPxDateEdit>
                </div>
                <div class="row marginTop10">
                    <dx:ASPxButton ID="FilterButton" AutoPostBack="false" runat="server" Text="Tìm kiếm">
                        <ClientSideEvents Click="function(s, e) {  cp.PerformCallback('filter'); }"></ClientSideEvents>
                    </dx:ASPxButton>
                </div>
                <div class="row marginTop20">
                    <dx:ASPxCallbackPanel ID="ASPxCallbackPanel1" runat="server" Width="100%"
                        ClientInstanceName="cp" OnCallback="ASPxCallbackPanel1_Callback">
                        <ClientSideEvents EndCallback="OnEndCallback" />
                        <PanelCollection>
                            <dx:PanelContent runat="server">
                                <dx:ASPxGridView runat="server" AutoGenerateColumns="False" ID="gvTimeSheet" ClientInstanceName="gvTimeSheet" Width="100%"
                                    KeyFieldName="EmployeeId;WorkingDate;ShiftType;EmployeeName" OnLoad="gvTimeSheet_Load"
                                    DataSourceID="odsWorkplan">
                                    <ClientSideEvents EndCallback="gvEndCallback" />
                                    <Styles Header-Wrap="True">
                                        <Header Wrap="True"></Header>
                                        <AlternatingRow Enabled="true" />
                                    </Styles>
                                    <Columns>
                                        <dx:GridViewDataDateColumn FieldName="WorkingDate" Caption="Ngày làm việc" VisibleIndex="0">
                                            <PropertiesDateEdit DisplayFormatString="yyyy-MM-dd"></PropertiesDateEdit>
                                            <EditFormSettings Visible="False" />
                                        </dx:GridViewDataDateColumn>
                                        <dx:GridViewDataDateColumn FieldName="WorkingDate" Caption="Thứ" VisibleIndex="1">
                                            <PropertiesDateEdit DisplayFormatString="ddd"></PropertiesDateEdit>
                                        </dx:GridViewDataDateColumn>
                                        <dx:GridViewDataColumn FieldName="ShiftType" Caption="Ca làm việc" VisibleIndex="2">
                                        </dx:GridViewDataColumn>
                                        <%--<dx:GridViewDataColumn FieldName="NewShift" Caption="Ca đổi" VisibleIndex="3">
                                            <DataItemTemplate>
                                                <%# Eval("NewShift") %><br />
                                                 <i><%# !string.IsNullOrEmpty(Convert.ToString(Eval("NewShift"))) ? "Lý do: " + Eval("editComment") : "" %></i>
                                            </DataItemTemplate>
                                        </dx:GridViewDataColumn>--%>
                                        <dx:GridViewDataColumn VisibleIndex="3" Caption="">
                                            <CellStyle HorizontalAlign="Center"></CellStyle>
                                            <DataItemTemplate>
                                                <a href="javascript:void(0);" onclick="PopupClick(this, '<%# Convert.ToString(Eval("EmployeeId")) + ";" +Convert.ToString(Eval("EmployeeName")) + ";" + Convert.ToDateTime(Eval("WorkingDate")).ToString("yyyy-MM-dd") + ";" + Convert.ToString(Eval("ShiftType"))  %>')" style="cursor: pointer">Đổi ca</a>
                                            </DataItemTemplate>
                                        </dx:GridViewDataColumn>
                                    </Columns>
                                </dx:ASPxGridView>
                                <asp:ObjectDataSource ID="odsWorkplan" runat="server" SelectMethod="getListbyDate" TypeName="LogicTier.Controllers.WorkingPlanBL">
                                    <SelectParameters>
                                        <asp:Parameter Name="username" Type="String" />
                                        <asp:Parameter Name="empId" Type="Int32" />
                                        <asp:Parameter Name="parentId" Type="Int32" />
                                        <asp:Parameter Name="from" Type="String" />
                                        <asp:Parameter Name="to" Type="String" />
                                    </SelectParameters>
                                </asp:ObjectDataSource>
                            </dx:PanelContent>
                        </PanelCollection>
                    </dx:ASPxCallbackPanel>
                </div>
            </div>
        </div>
    </div>
    <dx:ASPxPopupControl ID="pcImport" runat="server" Width="390px" CloseAction="CloseButton" CloseOnEscape="true" Modal="True"
        PopupHorizontalAlign="WindowCenter" PopupVerticalAlign="WindowCenter" ClientInstanceName="pcImport"
        HeaderText="Working Plan" AllowDragging="True" PopupAnimationType="None" EnableViewState="False" AutoUpdatePosition="true">
        <ContentCollection>
            <dx:PopupControlContentControl runat="server">
                <dx:ASPxPanel ID="Panel1" runat="server" DefaultButton="btOK">
                    <PanelCollection>
                        <dx:PanelContent runat="server">
                            <dx:ASPxCallbackPanel ID="ASPxCallbackPanel2" runat="server" Width="100%"
                                ClientInstanceName="cp2" OnCallback="cp2_Callback">
                                <ClientSideEvents EndCallback="OnEndCallback2" />
                                <PanelCollection>
                                    <dx:PanelContent runat="server">
                                        <dx:ASPxFormLayout runat="server" ID="ASPxFormLayout1" Width="100%" Height="100%">
                                            <Items>
                                                <dx:LayoutItem Caption="Chọn ca">
                                                    <LayoutItemNestedControlCollection>
                                                        <dx:LayoutItemNestedControlContainer>
                                                            <dx:ASPxComboBox Caption=" " runat="server" ID="cbShift" Width="100%" ValueField="Id" TextField="ShiftName" ValueType="System.Int32" NullText="--Chọn ca--"
                                                                ClientInstanceName="cbShift" DropDownStyle="DropDownList">
                                                                <ClearButton DisplayMode="OnHover"></ClearButton>
                                                            </dx:ASPxComboBox>
                                                        </dx:LayoutItemNestedControlContainer>
                                                    </LayoutItemNestedControlCollection>
                                                </dx:LayoutItem>
                                                <dx:LayoutItem Caption="Lý do">
                                                    <LayoutItemNestedControlCollection>
                                                        <dx:LayoutItemNestedControlContainer>
                                                            <dx:ASPxButtonEdit runat="server" Width="100%" ID="txreason" ClientInstanceName="txreason">
                                                                <ClearButton DisplayMode="OnHover"></ClearButton>
                                                            </dx:ASPxButtonEdit>
                                                        </dx:LayoutItemNestedControlContainer>
                                                    </LayoutItemNestedControlCollection>
                                                </dx:LayoutItem>
                                                <dx:LayoutItem ShowCaption="False">
                                                    <LayoutItemNestedControlCollection>
                                                        <dx:LayoutItemNestedControlContainer>
                                                            <asp:Literal ID="ltrbSave" runat="server"></asp:Literal>
                                                        </dx:LayoutItemNestedControlContainer>
                                                    </LayoutItemNestedControlCollection>
                                                </dx:LayoutItem>
                                            </Items>
                                        </dx:ASPxFormLayout>
                                    </dx:PanelContent>
                                </PanelCollection>
                            </dx:ASPxCallbackPanel>
                        </dx:PanelContent>
                    </PanelCollection>
                </dx:ASPxPanel>
            </dx:PopupControlContentControl>
        </ContentCollection>
        <ContentStyle>
            <Paddings PaddingBottom="5px" />
        </ContentStyle>
    </dx:ASPxPopupControl>
</asp:Content>
