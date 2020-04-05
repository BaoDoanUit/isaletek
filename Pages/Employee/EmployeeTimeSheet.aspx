<%@ Page Title="Employee timesheet" Language="C#" MasterPageFile="~/Layout.master" AutoEventWireup="true" CodeBehind="EmployeeTimeSheet.aspx.cs" Inherits="WebApplication.Pages.Employee.EmployeeTimeSheet" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Content" runat="server">
  <script type="text/javascript">
       function OnEndCallback(s, e) {
           if (s.cpAlert != '') {
               alert(s.cpAlert);
           }
       }
    </script>
    <div class="container">
        <div class="row marginTop20">
            <div class="col-xs-12">
                <h4>Tìm kiếm</h4>
                <div class="row">
                    Từ ngày:&nbsp; 
                     <dx:ASPxDateEdit runat="server" ID="fFromDate" DisplayFormatString="yyyy-MM-dd"
                         EditFormat="Custom" EditFormatString="yyyy-MM-dd">
                         <ClearButton DisplayMode="OnHover"></ClearButton>
                     </dx:ASPxDateEdit>
                </div>
                <div class="row">
                    Đến ngày:&nbsp;
                    <dx:ASPxDateEdit runat="server" ID="fToDate" DisplayFormatString="yyyy-MM-dd"
                        EditFormat="Custom" EditFormatString="yyyy-MM-dd">
                        <ClearButton DisplayMode="OnHover"></ClearButton>
                    </dx:ASPxDateEdit>
                </div>
                <div class="row marginTop20">
                    <dx:ASPxButton ID="btnFilter" AutoPostBack="false" runat="server" Text="Tìm kiếm">
                        <ClientSideEvents Click="function(s, e) {  cp.PerformCallback('filter'); }"></ClientSideEvents>
                    </dx:ASPxButton>
                </div>
                <div class="row marginTop20">
                    <dx:ASPxCallbackPanel ID="ASPxCallbackPanel1" runat="server" Width="100%"
                        ClientInstanceName="cp" OnCallback="ASPxCallbackPanel1_Callback">
                        <ClientSideEvents EndCallback="OnEndCallback" />
                        <PanelCollection>
                            <dx:PanelContent runat="server">
                                <dx:ASPxCardView ID="CardView" runat="server" Width="100%" Theme="Default" OnLoad="CardView_Load">
                                    <Columns>
                                        <dx:CardViewTextColumn FieldName="ShopName" Caption="Tên CH" />
                                        <dx:CardViewTextColumn FieldName="ShiftType" Caption="Ca làm việc" />
                                        <dx:CardViewDateColumn FieldName="AttendantDate" Caption="Ngày chấm công">
                                            <PropertiesDateEdit DisplayFormatString="{0:yyyy-MM-dd}"></PropertiesDateEdit>
                                        </dx:CardViewDateColumn>
                                        <dx:CardViewDateColumn FieldName="CheckIn" Caption="Giờ vào">
                                            <PropertiesDateEdit DisplayFormatString="{0:yyyy-MM-dd HH:mm:ss}"></PropertiesDateEdit>
                                        </dx:CardViewDateColumn>
                                        <dx:CardViewDateColumn FieldName="CheckOut" Caption="Giờ ra">
                                            <PropertiesDateEdit DisplayFormatString="{0:yyyy-MM-dd HH:mm:ss}"></PropertiesDateEdit>
                                        </dx:CardViewDateColumn>
                                        <dx:CardViewDateColumn FieldName="time_grsc" Caption="Tổng giờ công">
                                            <PropertiesDateEdit DisplayFormatString="{0:t}"></PropertiesDateEdit>
                                        </dx:CardViewDateColumn>
                                    </Columns>
                                    <SettingsPager NumericButtonCount="3" ShowNumericButtons="false">
                                        <PageSizeItemSettings Position="Left"></PageSizeItemSettings>
                                        <SettingsTableLayout ColumnCount="1" RowsPerPage="2" />
                                    </SettingsPager>
                                </dx:ASPxCardView>

                            </dx:PanelContent>
                        </PanelCollection>
                    </dx:ASPxCallbackPanel>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
