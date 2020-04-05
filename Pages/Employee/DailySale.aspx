<%@ Page Title="Daily Sale" Language="C#" MasterPageFile="~/Layout.master" AutoEventWireup="true" CodeBehind="DailySale.aspx.cs" Inherits="WebApplication.Pages.Employee.DailySale" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Content" runat="server">
    <script type="text/javascript">
        function OnEndCallback(s, e) {
            if (s.cpAlert != '') {
                alert(s.cpAlert);
            }
        }
        function OnInit(s, e) {
            var calendar = s.GetCalendar();
            calendar.owner = s;
        }

        function OnDropDown(s, e) {
            var calendar = s.GetCalendar();
            var fastNav = calendar.fastNavigation;
            fastNav.activeView = calendar.GetView(0, 0);
            fastNav.Prepare();
            fastNav.GetPopup().popupVerticalAlign = "Below";
            fastNav.GetPopup().ShowAtElement(s.GetMainElement())


            fastNav.OnOkClick = function () {
                var parentDateEdit = this.calendar.owner;
                var currentDate = new Date(fastNav.activeYear, fastNav.activeMonth, 1);
                parentDateEdit.SetDate(currentDate);
                parentDateEdit.HideDropDown();
                fastNav.GetPopup().Hide();
            }

            fastNav.OnCancelClick = function () {
                var parentDateEdit = this.calendar.owner;
                parentDateEdit.HideDropDown();
                fastNav.GetPopup().Hide();
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
                    <h3>Doanh số bán hàng</h3>
                    <div class="row">
                        <div class="col-xs-5">
                            <dx:ASPxDateEdit runat="server" ID="txReportDate" DisplayFormatString="yyyy-MM"
                                EditFormat="Custom" EditFormatString="yyyy-MM" OnInit="txReportDate_Init">
                                <ClearButton DisplayMode="OnHover"></ClearButton>
                                <ClientSideEvents Init="OnInit" DropDown="OnDropDown" />
                            </dx:ASPxDateEdit>
                        </div>
                        <div class="col-xs-2">
                            &nbsp;
                            </div>
                        <div class="col-xs-5">
                            <dx:ASPxButton ID="btFilter" runat="server" Text="Tìm kiếm" UseSubmitBehavior="False" AutoPostBack="false">
                                <ClientSideEvents Click="function(s, e) {ASPxCallbackPanel1.PerformCallback('filter');}"></ClientSideEvents>
                            </dx:ASPxButton>
                        </div>
                    </div>
                    <div class="row marginTop20">
                        <div class="col-xs-12">
                            <dx:ASPxCardView ID="cvSale" ClientInstanceName="cvSale" runat="server" Width="100%" Theme="Default" OnLoad="cvSale_Load" DataSourceID="odsDailySale">
                                <Columns>
                                    <dx:CardViewTextColumn FieldName="Target" Caption="Chỉ tiêu" />
                                    <dx:CardViewTextColumn FieldName="Quantity" Caption="Doanh số" />
                                    <dx:CardViewTextColumn FieldName="Percent" Caption="Tỉ lệ">
                                        <DataItemTemplate>
                                            <dx:ASPxLabel runat="server" ID="lbPercent" Text='<%# Eval("Percent")+"%" %>'></dx:ASPxLabel>
                                        </DataItemTemplate>
                                    </dx:CardViewTextColumn>
                                    <dx:CardViewDateColumn FieldName="SaleDate" Caption="Ngày cập nhật">
                                        <PropertiesDateEdit DisplayFormatString="{0:yyyy-MM-dd}"></PropertiesDateEdit>
                                    </dx:CardViewDateColumn>
                                </Columns>
                                <SettingsPager NumericButtonCount="3" ShowNumericButtons="false">
                                    <PageSizeItemSettings Position="Left"></PageSizeItemSettings>
                                    <SettingsTableLayout ColumnCount="1" RowsPerPage="1" />
                                </SettingsPager>
                            </dx:ASPxCardView>
                            <asp:ObjectDataSource ID="odsDailySale" runat="server" SelectMethod="DailybyEmployee" TypeName="LogicTier.Controllers.SaleOutBL">
                                <SelectParameters>
                                    <asp:Parameter Name="userName" Type="String" />
                                    <asp:Parameter Name="empId" Type="Int32" />
                                    <asp:Parameter Name="parentId" Type="Int32" />
                                    <asp:Parameter Name="shopId" Type="Int32" />
                                    <asp:Parameter Name="account" Type="Int32" />
                                    <asp:Parameter Name="month" Type="Int32" />
                                    <asp:Parameter Name="year" Type="Int32" />
                                </SelectParameters>
                            </asp:ObjectDataSource>
                        </div>
                    </div>
                </div>
            </dx:PanelContent>
        </PanelCollection>
    </dx:ASPxCallbackPanel>
</asp:Content>
