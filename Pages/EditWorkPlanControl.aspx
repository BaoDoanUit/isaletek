<%@ Page Title="Confirm Edit Working Plan" Language="C#" MasterPageFile="~/Layout.master" AutoEventWireup="true" CodeBehind="EditWorkPlanControl.aspx.cs" Inherits="WebApplication.Pages.EditWorkPlanControl" %>

<%@ Register Src="~/UserControls/ToolbarExport.ascx" TagPrefix="uc1" TagName="ToolbarExport" %>
<%@ Register TagPrefix="dx" Namespace="DevExpress.Web" Assembly="DevExpress.Web.v17.1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="Content" runat="server">
    <script>
        function OnEndCallback(s, e) {
            if (s.cpAlert != '') {
                alert(s.cpAlert);
            }
        }
        function gvEndCallback(s, e) {
            if (s.cpAlert != '') {
                alert(s.cpAlert);
            }

        }
    </script>
    <script type="text/javascript">
        $(document).ready(function () {
            $("#TopPanel_NavMenu ul li:eq(6)").addClass("dxm-selected");
        })
    </script>
    <div class="container">
        <div class="row marginTop20">
            <div class="col-md-12">
                <dx:ASPxFormLayout ID="AddCommentFormLayout" runat="server" UseDefaultPaddings="false" Width="100%">
                    <SettingsItems Width="100%" />
                    <SettingsItemCaptions Location="Top" />
                    <Items>
                        <dx:LayoutGroup Caption="Filter">
                            <Items>
                                <dx:LayoutItem ShowCaption="False">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer>
                                            <div class="row">
                                                <div class="col-md-3">
                                                    <label>From</label>
                                                    <dx:ASPxDateEdit runat="server" Width="100%" ID="fFromDate" DisplayFormatString="yyyy-MM-dd"
                                                        EditFormat="Custom" EditFormatString="yyyy-MM-dd">
                                                        <ClearButton DisplayMode="OnHover"></ClearButton>
                                                    </dx:ASPxDateEdit>
                                                </div>
                                                <div class="col-md-3">
                                                    <label>To</label>
                                                    <dx:ASPxDateEdit runat="server" Width="100%" ID="fToDate" DisplayFormatString="yyyy-MM-dd"
                                                        EditFormat="Custom" EditFormatString="yyyy-MM-dd">
                                                        <ClearButton DisplayMode="OnHover"></ClearButton>
                                                    </dx:ASPxDateEdit>
                                                </div>
                                                <div class="col-md-3">
                                                    <label>Suppervisor</label>
                                                    <dx:ASPxComboBox runat="server" Width="100%" ID="cbLearder" ValueField="EmployeeId"
                                                        ValueType="System.Int32" NullText="Choose to filter by Leader person"
                                                        ClientInstanceName="cbLearder" CallbackPageSize="10" DataSourceID="odsLeader" OnInit="cbLearder_Init"
                                                        IncrementalFilteringMode="Contains" TextFormatString="{0}" EnableCallbackMode="true" DropDownStyle="DropDownList">
                                                        <ClientSideEvents SelectedIndexChanged="function(s,e){cbEmployee.PerformCallback(s.GetValue());}" />
                                                        <ClearButton DisplayMode="OnHover"></ClearButton>
                                                        <Columns>
                                                            <dx:ListBoxColumn FieldName="EmployeeName" />
                                                        </Columns>
                                                    </dx:ASPxComboBox>
                                                    <asp:ObjectDataSource ID="odsLeader" runat="server" SelectMethod="getList" TypeName="LogicTier.Controllers.EmployeeBL">
                                                        <SelectParameters>
                                                            <asp:Parameter Name="AccountId" Type="Int32" DefaultValue="" ConvertEmptyStringToNull="true" />
                                                            <asp:Parameter Name="empId" Type="Int32" />
                                                            <asp:Parameter Name="empCode" Type="String" />
                                                            <asp:Parameter Name="pos" Type="String" />
                                                            <asp:Parameter Name="parentId" Type="Int32" />
                                                            <asp:Parameter Name="emplName" Type="String" DefaultValue="" ConvertEmptyStringToNull="true" />
                                                            <asp:ControlParameter ControlID="AddCommentFormLayout$OptionRadioButtonList" Name="Option" Type="Int32" PropertyName="Value" />
                                                            <asp:Parameter Name="userId" Type="Int32" />
                                                        </SelectParameters>
                                                    </asp:ObjectDataSource>
                                                </div>
                                                <div class="col-md-3">
                                                    <label>Employee</label>
                                                    <dx:ASPxComboBox runat="server" Width="100%" ID="cbEmployee" OnCallback="cbEmployee_Callback"
                                                        ValueType="System.Int32" NullText="Choose to filter by Employee person" ValueField="EmployeeId"
                                                        ClientInstanceName="cbEmployee" CallbackPageSize="10" DataSourceID="odsEmployee"
                                                        IncrementalFilteringMode="Contains" TextFormatString="{0}" EnableCallbackMode="true" DropDownStyle="DropDownList">
                                                        <ClearButton DisplayMode="OnHover"></ClearButton>
                                                        <Columns>
                                                            <dx:ListBoxColumn FieldName="EmployeeName" />
                                                        </Columns>
                                                    </dx:ASPxComboBox>
                                                    <asp:ObjectDataSource ID="odsEmployee" runat="server" SelectMethod="getList" TypeName="LogicTier.Controllers.EmployeeBL">
                                                        <SelectParameters>
                                                            <asp:Parameter Name="AccountId" Type="Int32" DefaultValue="" ConvertEmptyStringToNull="true" />
                                                            <asp:Parameter Name="empId" Type="Int32" />
                                                            <asp:Parameter Name="empCode" Type="String" />
                                                            <asp:Parameter Name="pos" Type="String" />
                                                            <asp:Parameter Name="parentId" Type="Int32" />
                                                            <asp:Parameter Name="emplName" Type="String" DefaultValue="" ConvertEmptyStringToNull="true" />
                                                            <asp:ControlParameter ControlID="AddCommentFormLayout$OptionRadioButtonList" Name="Option" Type="Int32" PropertyName="Value" />
                                                            <asp:Parameter Name="userId" Type="Int32" />
                                                        </SelectParameters>
                                                    </asp:ObjectDataSource>
                                                </div>
                                            </div>
                                            <div class="row">

                                                <div class="col-md-3">
                                                    <label>Status</label>
                                                    <dx:ASPxComboBox runat="server" Width="100%" ID="cpConfirmStatus"
                                                        ValueType="System.Int32" NullText="Choose to filter by status"
                                                        ClientInstanceName="cpConfirmStatus" DropDownStyle="DropDownList">
                                                        <ClearButton DisplayMode="OnHover"></ClearButton>
                                                        <Items>
                                                            <dx:ListEditItem Value="1" Text="Confirm" />
                                                            <dx:ListEditItem Value="-1" Text="Unconfirm" />
                                                        </Items>
                                                    </dx:ASPxComboBox>
                                                </div>
                                            </div>
                                            <div class="row marginTop20">
                                                <div class="col-md-4">
                                                    <label>Lọc NV</label>
                                                    <dx:ASPxRadioButtonList ID="OptionRadioButtonList" runat="server" Paddings-PaddingLeft="0" Paddings-PaddingRight="0" Paddings-PaddingBottom="0" Paddings-PaddingTop="0" RepeatDirection="Horizontal" RepeatColumns="2" Width="100%"
                                                        RepeatLayout="Table">
                                                        <Items>
                                                            <dx:ListEditItem Selected="true" Text="Tất cả NV" Value="0" />
                                                            <dx:ListEditItem Text="NV còn làm việc" Value="-1" />
                                                        </Items>
                                                    </dx:ASPxRadioButtonList>
                                                </div>
                                                <div class="col-md-3">
                                                    <label style="color: white">Tool</label><br />
                                                    <dx:ASPxButton ID="FilterButton" AutoPostBack="false" runat="server" CssClass="btn btn-primary" Text="Tìm kiếm">
                                                        <ClientSideEvents Click="function(s, e) {cp.PerformCallback('filter'); }"></ClientSideEvents>
                                                    </dx:ASPxButton>
                                                </div>
                                            </div>
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
            <ClientSideEvents EndCallback="OnEndCallback" />
            <PanelCollection>
                <dx:PanelContent runat="server">
                    <div class="row container marginTop20">
                        <div class="col-md-12 box-content">
                            <div class="row">
                                <div class="col-md-12">
                                    <uc1:ToolbarExport runat="server" ID="ToolbarExport1" OnItemClick="ToolbarExport1_ItemClick" />
                                    <dx:ASPxGridViewExporter ID="ASPxGridViewExporter1" OnRenderBrick="ASPxGridViewExporter1_RenderBrick" runat="server" GridViewID="gvEditWPlan">
                                    </dx:ASPxGridViewExporter>
                                </div>
                            </div>
                            <div class="row marginTop20 marginBot20">
                                <div class="col-md-12">
                                    <dx:ASPxGridView runat="server" AutoGenerateColumns="False" ID="gvEditWPlan" ClientInstanceName="gvEditWPlan" Width="100%"
                                        KeyFieldName="EmployeeId;WorkingDate;NewShift" OnLoad="gvEditWPlan_Load"
                                        OnRowDeleting="gvEditWPlan_RowDeleting" DataSourceID="odsEditWP">
                                        <ClientSideEvents EndCallback="gvEndCallback" />
                                        <SettingsCommandButton>
                                            <DeleteButton Text="Delete"></DeleteButton>
                                        </SettingsCommandButton>
                                        <SettingsBehavior ConfirmDelete="true" AllowFocusedRow="True" />
                                        <SettingsText ConfirmDelete="Are you sure?" />
                                        <Styles>
                                            <FixedColumn BackColor="LightYellow"></FixedColumn>
                                            <Header Wrap="True" VerticalAlign="Middle" HorizontalAlign="Center"></Header>
                                            <Cell Wrap="True" VerticalAlign="Middle"></Cell>
                                            <AlternatingRow Enabled="true" />
                                        </Styles>
                                        <Columns>
                                            <dx:GridViewDataColumn FieldName="EmployeeCode" VisibleIndex="0">
                                                <EditFormSettings Visible="False" />
                                            </dx:GridViewDataColumn>
                                            <dx:GridViewDataColumn FieldName="EmployeeName" VisibleIndex="1">
                                                <EditFormSettings Visible="False" />
                                            </dx:GridViewDataColumn>
                                            <dx:GridViewDataColumn FieldName="ShopName" VisibleIndex="2">
                                            </dx:GridViewDataColumn>
                                            <dx:GridViewDataTextColumn FieldName="WorkingDate" VisibleIndex="3">
                                                <PropertiesTextEdit DisplayFormatString="{0:yyyy-MM-dd}"></PropertiesTextEdit>
                                            </dx:GridViewDataTextColumn>
                                            <dx:GridViewDataColumn FieldName="CurrentShift" Caption="Current Shift" VisibleIndex="4">
                                            </dx:GridViewDataColumn>
                                            <dx:GridViewDataColumn FieldName="NewShift" Caption="New Shift" VisibleIndex="5">
                                            </dx:GridViewDataColumn>
                                            <dx:GridViewDataColumn FieldName="Comment" VisibleIndex="6">
                                            </dx:GridViewDataColumn>
                                            <dx:GridViewDataColumn FieldName="ConfirmBy" Caption="Confirm By" VisibleIndex="7">
                                                <DataItemTemplate>
                                                    <%#BindUser(Eval("ConfirmBy")) %>
                                                </DataItemTemplate>
                                            </dx:GridViewDataColumn>
                                            <dx:GridViewDataColumn Caption="Status" FieldName="BlockStatus" VisibleIndex="7">
                                                <DataItemTemplate>
                                                    <%#BindStatus(Eval("BlockStatus"))%>
                                                </DataItemTemplate>
                                            </dx:GridViewDataColumn>
                                            <dx:GridViewDataColumn Caption="Confirm" VisibleIndex="8">
                                                <DataItemTemplate>
                                                    <dx:ASPxButton runat="server" ID="btConfirm" Visible='<%# Convert.ToString(Eval("BlockStatus")) == "1" ? Convert.ToBoolean(0) : Convert.ToBoolean(1) %>' Text="Confirm" AutoPostBack="false" OnLoad="btConfirm_Load" CssClass="btn btn-warning"></dx:ASPxButton>
                                                </DataItemTemplate>
                                            </dx:GridViewDataColumn>
                                            <dx:GridViewCommandColumn ShowDeleteButton="true" VisibleIndex="9">
                                            </dx:GridViewCommandColumn>
                                        </Columns>
                                    </dx:ASPxGridView>
                                    <asp:ObjectDataSource ID="odsEditWP" runat="server"
                                        DataObjectTypeName="LogicTier.Models.EditWorkPlan"
                                        DeleteMethod="Delete"
                                        SelectMethod="getList" TypeName="LogicTier.Controllers.EditWorkPlanBL" UpdateMethod="Insert">
                                        <DeleteParameters>
                                            <asp:Parameter Name="empId" Type="Int32" />
                                            <asp:Parameter Name="wkDate" Type="String" />
                                        </DeleteParameters>
                                        <SelectParameters>
                                            <asp:Parameter Name="username" Type="String" />
                                            <asp:Parameter Name="empId" Type="Int32" />
                                            <asp:Parameter Name="parentId" Type="Int32" />
                                            <asp:Parameter Name="from" Type="String" />
                                            <asp:Parameter Name="to" Type="String" />
                                            <asp:Parameter Name="confirm" Type="Int32" />
                                        </SelectParameters>
                                    </asp:ObjectDataSource>
                                </div>
                            </div>
                        </div>
                    </div>
                </dx:PanelContent>
            </PanelCollection>
        </dx:ASPxCallbackPanel>
    </div>
</asp:Content>
