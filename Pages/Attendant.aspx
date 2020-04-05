<%@ Page Title="Attendant Report" Language="C#" MasterPageFile="~/Layout.master" AutoEventWireup="true" CodeBehind="Attendant.aspx.cs" Inherits="WebApplication.Pages.Attendant" %>

<%@ Register Src="~/UserControls/ToolbarExport.ascx" TagPrefix="uc1" TagName="ToolbarExport" %>
<asp:Content ID="Content1" ContentPlaceHolderID="Content" runat="server">
    <style type="text/css">
        /*.templateTable {
            border-collapse: collapse;
            width: 100%;
        }

            .templateTable td {
                border: solid 1px #C2D4DA;
                padding: 6px;
            }

                .templateTable td.value {
                    font-weight: bold;
                }*/

        /*.imageCell {
            width: 120px;
        }*/
    </style>
    <script>
        function OnEndCallback(s, e) {
            if (s.cpAlert != '' && s.cpAlert != 'undefined') {
                alert(s.cpAlert);
            }
        }
        function grWPlanEndCallback(s, e) {
            if (s.cpDetail != '' && s.cpAlert != 'undefined') {
                alert(s.cpDetail);
            }
        }
    </script>
    <script type="text/javascript">
        $(document).ready(function () {
            $("#TopPanel_NavMenu ul li:eq(4)").addClass("dxm-selected");
        })
    </script>
    <div class="container">
        <div class="row marginTop20">
            <dx:ASPxFormLayout ID="AddCommentFormLayout" runat="server" UseDefaultPaddings="false">
                <SettingsItems Width="100%" />
                <SettingsItemCaptions Location="Top" />
                <Items>
                    <dx:LayoutGroup Caption="TÌM KIẾM" ColCount="6">
                        <Items>
                            <dx:LayoutItem ShowCaption="False">
                                <LayoutItemNestedControlCollection>
                                    <dx:LayoutItemNestedControlContainer>
                                        <div class="row">
                                            <div class="col-md-3">
                                                <label>From Date</label>
                                                <dx:ASPxDateEdit runat="server" ID="fFromDate" Width="100%" DisplayFormatString="yyyy-MM-dd"
                                                    EditFormat="Custom" EditFormatString="yyyy-MM-dd">
                                                    <ClearButton DisplayMode="OnHover"></ClearButton>
                                                </dx:ASPxDateEdit>
                                            </div>
                                            <div class="col-md-3">
                                                <label>To Date</label>
                                                <dx:ASPxDateEdit runat="server" ID="fToDate" Width="100%" DisplayFormatString="yyyy-MM-dd"
                                                    EditFormat="Custom" EditFormatString="yyyy-MM-dd">
                                                    <ClearButton DisplayMode="OnHover"></ClearButton>
                                                </dx:ASPxDateEdit>
                                            </div>
                                            <div class="col-md-3">
                                                <label>Leader</label>
                                                <dx:ASPxComboBox runat="server" ID="cbLearder" Width="100%" ValueField="EmployeeId"
                                                    ValueType="System.Int32" NullText="Choose to filter by Leader person"
                                                    ClientInstanceName="cbLearder" CallbackPageSize="10" DataSourceID="odsLeader" OnInit="cbLearder_Init" OnCallback="cbLearder_Callback"
                                                    IncrementalFilteringMode="Contains" TextFormatString="{0}" EnableCallbackMode="true" DropDownStyle="DropDownList">
                                                    <ClientSideEvents SelectedIndexChanged="function(s,e){cbEmployee.PerformCallback(s.GetValue());}" />
                                                    <ClearButton DisplayMode="OnHover"></ClearButton>
                                                    <Columns>
                                                        <dx:ListBoxColumn FieldName="EmployeeName" />
                                                    </Columns>
                                                </dx:ASPxComboBox>
                                                <asp:ObjectDataSource ID="odsLeader" runat="server"
                                                    SelectMethod="getList" TypeName="LogicTier.Controllers.EmployeeBL">
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
                                                <dx:ASPxComboBox runat="server" ID="cbEmployee" Width="100%" OnCallback="cbEmployee_Callback"
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
                                        <div class="row marginTop20">
                                            <div class="col-md-3">
                                                <label>Trạng thái</label>
                                                <dx:ASPxRadioButtonList ID="OptionRadioButtonList" Width="100%" runat="server" Paddings-PaddingLeft="0" Paddings-PaddingRight="0" Paddings-PaddingBottom="0" Paddings-PaddingTop="0" RepeatColumns="2"
                                                    RepeatLayout="UnorderedList">
                                                    <ClientSideEvents SelectedIndexChanged="function(s,e){cbLearder.PerformCallback('Sup');cbEmployee.PerformCallback();}" />
                                                    <Items>
                                                        <dx:ListEditItem Selected="true" Text="Tất cả NV" Value="0" />
                                                        <dx:ListEditItem Text="NV còn làm việc" Value="-1" />
                                                    </Items>
                                                </dx:ASPxRadioButtonList>
                                            </div>
                                            <div class="col-md-6">
                                                <label style="color: white">Tool</label><br />
                                                <dx:ASPxButton ID="FilterButton" AutoPostBack="false" CssClass="btn btn-primary" runat="server" Text="Tìm kiếm">
                                                    <ClientSideEvents Click="function(s, e) {  cp.PerformCallback('filter'); }"></ClientSideEvents>
                                                </dx:ASPxButton>
                                                <dx:ASPxButton ID="ASPxButton1" AutoPostBack="false" runat="server" CssClass="btn btn-warning" Text="Export">
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
                                    </dx:LayoutItemNestedControlContainer>
                                </LayoutItemNestedControlCollection>
                            </dx:LayoutItem>
                        </Items>
                    </dx:LayoutGroup>
                </Items>
            </dx:ASPxFormLayout>
        </div>
        <dx:ASPxCallbackPanel ID="ASPxCallbackPanel1" runat="server" Width="100%"
            ClientInstanceName="cp" OnCallback="ASPxCallbackPanel1_Callback">
            <PanelCollection>
                <dx:PanelContent runat="server">
                    <div class="row marginTop20">
                        <div class="col-md-12 box-content">
                            <div class="row">
                                <div class="col-md-12">
                                    <uc1:ToolbarExport runat="server" ID="ToolbarExport1" OnItemClick="ToolbarExport1_ItemClick" />
                                    <dx:ASPxGridViewExporter ID="ASPxGridViewExporter1"
                                        runat="server" ExportSelectedRowsOnly="true"
                                        GridViewID="grWPlan">
                                    </dx:ASPxGridViewExporter>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-12">
                                    <table class="OptionsBottomMargin">
                                        <tr>
                                            <td style="padding-right: 4px">
                                                <dx:ASPxButton ID="btnSelectAll" runat="server" Text="Chọn tất cả" UseSubmitBehavior="False"
                                                    AutoPostBack="false">
                                                    <ClientSideEvents Click="function(s, e) { grWPlan.SelectRows(); }" />
                                                </dx:ASPxButton>
                                            </td>
                                            <td style="padding-right: 4px">
                                                <dx:ASPxButton ID="btnSelectAllOnPage" runat="server" Text="Chọn 1 trang"
                                                    UseSubmitBehavior="False" AutoPostBack="false">
                                                    <ClientSideEvents Click="function(s, e) { grWPlan.SelectAllRowsOnPage(); }" />
                                                </dx:ASPxButton>
                                            </td>
                                            <td style="padding-right: 4px">
                                                <dx:ASPxButton ID="btnUnselectAll" runat="server" Text="Bỏ chọn" UseSubmitBehavior="False"
                                                    AutoPostBack="false">
                                                    <ClientSideEvents Click="function(s, e) { grWPlan.UnselectRows(); grWPlan.UnselectAllRowsOnPage(); }" />
                                                </dx:ASPxButton>
                                            </td>
                                        </tr>
                                    </table>
                                </div>
                            </div>
                            <div class="row marginTop20 marginBot20">
                                <div class="col-md-12">
                                    <dx:ASPxGridView runat="server"
                                        ID="grWPlan" ClientInstanceName="grWPlan" OnHtmlRowPrepared="grWPlan_HtmlRowPrepared"
                                        Width="100%" OnRowDeleting="grWPlan_RowDeleting" DataSourceID="odsAttendant"
                                        AutoGenerateColumns="False" OnCustomCallback="grWPlan_CustomCallback"
                                        KeyFieldName="Id;AttendantDate" OnLoad="grWPlan_Load">
                                        <ClientSideEvents EndCallback="grWPlanEndCallback" />
                                        <SettingsCommandButton>
                                            <DeleteButton Text="Delete"></DeleteButton>
                                        </SettingsCommandButton>
                                        <SettingsBehavior ConfirmDelete="true" AllowFocusedRow="True" />
                                        <SettingsText ConfirmDelete="Bạn có muốn xóa không?" />
                                        <Styles Header-Wrap="True">
                                            <Header Wrap="True" VerticalAlign="Middle" HorizontalAlign="Center"></Header>
                                            <Cell Wrap="True" VerticalAlign="Middle"></Cell>
                                            <AlternatingRow Enabled="true" />
                                        </Styles>
                                        <SettingsDetail ShowDetailRow="True" AllowOnlyOneMasterRowExpanded="True" />
                                        <ClientSideEvents RowClick="function(s, e) {s.ExpandDetailRow(s.GetFocusedRowIndex());}" />
                                        <Templates>
                                            <DetailRow>
                                                <asp:Repeater ID="gvDetail" runat="server" DataSourceID="odsDetails"
                                                    OnLoad="gvDetail_Load">
                                                    <HeaderTemplate>
                                                        <div class="col-md-12">
                                                    </HeaderTemplate>
                                                    <ItemTemplate>
                                                        <div class="row">
                                                            <div class="col-md-5">
                                                                <%-- <dx:ASPxBinaryImage ID="BinaryImg" runat="server" ClientInstanceName="BinaryImg" OnInit="BinaryImg_Init"
                                                                    Value='<%# Eval("BinaryImg") %>' ImageAlign="AbsMiddle" >
                                                                    <ClientSideEvents ValueChanged="function(s,e){grWPlan.PerformCallback('UpdatePic');}" />
                                                                    <EditingSettings Enabled="true">
                                                                        <UploadSettings>
                                                                            <UploadValidationSettings MaxFileSize="4194304" AllowedFileExtensions=".jpe, .jpeg, .jpg, .gif, .png"></UploadValidationSettings>
                                                                        </UploadSettings>
                                                                    </EditingSettings>
                                                                </dx:ASPxBinaryImage>--%>
                                                                <asp:HiddenField runat="server" ID="hdfType" Value='<%# Eval("aType") %>' />
                                                                <img src='<%# Eval("PhotoUrl") %>' alt="" width="300" />
                                                            </div>
                                                            <div class="col-md-5 text-justify">
                                                                <div class="row">
                                                                    <h4>Loại chấm công:</h4>
                                                                    <dx:ASPxLabel runat="server" ID="lbaType" Text='<%#Eval("aType") %>'></dx:ASPxLabel>
                                                                </div>
                                                                <div class="row marginTop20">
                                                                    <h4>Giờ chấm công:</h4>
                                                                    <div class="col-md-6">
                                                                        <dx:ASPxTimeEdit ID="txCreatedDate" runat="server" Value='<%#Eval("CreatedDate") %>' DisplayFormatString="yyyy-MM-dd HH:mm:ss" EditFormatString="yyyy-MM-dd HH:mm:ss" EditFormat="DateTime" Width="220px">
                                                                            <ClearButton DisplayMode="OnHover"></ClearButton>
                                                                            <ValidationSettings ErrorDisplayMode="None" />
                                                                        </dx:ASPxTimeEdit>
                                                                    </div>
                                                                    <div class="col-md-6 text-left">
                                                                        <dx:ASPxButton runat="server" ID="btUpdate" CssClass="btn btn-warning" Text="Cập nhật" AutoPostBack="false" OnInit="btUpdate_Init" CommandArgument='<%#Eval("aType")%>'>
                                                                        </dx:ASPxButton>
                                                                    </div>
                                                                </div>
                                                                <div class="row marginTop20">
                                                                    <h4>Ghi chú:</h4>
                                                                    <dx:ASPxMemo runat="server" ID="txComments" Text='<%#Eval("Comments") %>' Height="40px" Width="100%"></dx:ASPxMemo>
                                                                </div>
                                                                <div class="row marginTop20">
                                                                    <h4>Sup xác nhận:</h4>
                                                                    <dx:ASPxLabel runat="server" ID="txtSupSubmit" Text='<%#Eval("Comments") %>' Height="40px" Width="100%"></dx:ASPxLabel>
                                                                </div>
                                                            </div>
                                                            <div class="col-md-2">
                                                                <div class="row text-center marginTop20">
                                                                    <div class="col-md-5">
                                                                        <dx:ASPxButton runat="server" ID="btDuplicate" Text="Duplicate" CssClass="btn btn-warning" AutoPostBack="false" OnInit="btDuplicate_Init" Visible='<%# showBtDuplicate(Convert.ToInt64(Eval("Id"))) %>'>
                                                                        </dx:ASPxButton>
                                                                    </div>
                                                                    <div class="col-md-2">
                                                                        &nbsp;
                                                                    </div>
                                                                    <div class="col-md-5">
                                                                        <dx:ASPxButton runat="server" ID="btDelete" Text="Xóa" CssClass="btn btn-danger" AutoPostBack="false" OnInit="btDelete_Init" CommandArgument='<%#Eval("aType")%>'>
                                                                        </dx:ASPxButton>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </ItemTemplate>
                                                    <FooterTemplate>
                                                        </div>
                                                    </FooterTemplate>
                                                </asp:Repeater>
                                            </DetailRow>
                                        </Templates>
                                        <Columns>
                                            <dx:GridViewCommandColumn ShowSelectCheckbox="True" VisibleIndex="0" />
                                            <dx:GridViewDataTextColumn HeaderStyle-Wrap="True" FieldName="EmployeeCode" VisibleIndex="1">
                                                <HeaderStyle Wrap="True"></HeaderStyle>
                                            </dx:GridViewDataTextColumn>
                                            <dx:GridViewDataTextColumn HeaderStyle-Wrap="True" FieldName="EmployeeName" VisibleIndex="2">
                                                <HeaderStyle Wrap="True"></HeaderStyle>
                                            </dx:GridViewDataTextColumn>
                                            <dx:GridViewDataTextColumn HeaderStyle-Wrap="True" FieldName="ShopName" VisibleIndex="3">
                                                <HeaderStyle Wrap="True"></HeaderStyle>
                                            </dx:GridViewDataTextColumn>
                                            <dx:GridViewDataTextColumn HeaderStyle-Wrap="True" FieldName="AttendantDate" VisibleIndex="4">
                                                <PropertiesTextEdit DisplayFormatString="{0:yyyy-MM-dd}">
                                                </PropertiesTextEdit>
                                                <HeaderStyle Wrap="True"></HeaderStyle>
                                                <CellStyle HorizontalAlign="Right"></CellStyle>
                                            </dx:GridViewDataTextColumn>
                                            <dx:GridViewDataTextColumn FieldName="ShiftType" VisibleIndex="5">
                                            </dx:GridViewDataTextColumn>
                                            <dx:GridViewDataTextColumn FieldName="CheckIn" VisibleIndex="6">
                                                <DataItemTemplate>
                                                    <%# string.Format("{0: HH:mm:ss}", Eval("CheckIn")) %>
                                                    <br />
                                                    <a title="" target="_blank" <%#String.IsNullOrEmpty(Convert.ToString(Eval("LatitudeIn")))|| Convert.ToString(Eval("LatitudeIn"))=="0"?"style='display:none'":"" %> href='http://maps.google.com/?q=<%# Convert.ToString(Eval("LatitudeIn")).Replace(",", ".") %>,<%# Convert.ToString(Eval("LongitudeIn")).Replace(",", ".") %>'>Xem bản đồ</a>
                                                </DataItemTemplate>
                                                <CellStyle HorizontalAlign="Right"></CellStyle>
                                            </dx:GridViewDataTextColumn>
                                            <dx:GridViewDataTextColumn FieldName="CheckOut" VisibleIndex="7">
                                                <DataItemTemplate>
                                                    <%# string.Format("{0: HH:mm:ss}", Eval("CheckOut")) %>
                                                    <br />
                                                    <a title="" target="_blank" <%# String.IsNullOrEmpty(Convert.ToString(Eval("LatitudeOut")))|| Convert.ToString(Eval("LatitudeOut"))=="0"?"style='display:none'":"" %> href='http://maps.google.com/?q=<%# Convert.ToString(Eval("LatitudeOut")).Replace(",", ".") %>,<%# Convert.ToString(Eval("LongitudeOut")).Replace(",", ".") %>'>Xem bản đồ</a>
                                                </DataItemTemplate>
                                                <HeaderStyle Wrap="True"></HeaderStyle>
                                                <CellStyle HorizontalAlign="Right"></CellStyle>
                                            </dx:GridViewDataTextColumn>
                                            <dx:GridViewDataDateColumn FieldName="Duration" VisibleIndex="8">
                                                <PropertiesDateEdit DisplayFormatString="t"></PropertiesDateEdit>
                                                <DataItemTemplate>
                                                    <%# FormatTime(Eval("Duration")) %>
                                                </DataItemTemplate>
                                                <HeaderStyle Wrap="True"></HeaderStyle>
                                                <CellStyle HorizontalAlign="Right"></CellStyle>
                                            </dx:GridViewDataDateColumn>
                                            <dx:GridViewCommandColumn ShowEditButton="false" ShowDeleteButton="true" VisibleIndex="10">
                                            </dx:GridViewCommandColumn>
                                        </Columns>
                                    </dx:ASPxGridView>
                                    <asp:ObjectDataSource ID="odsAttendant" runat="server" SelectMethod="getList" TypeName="LogicTier.Controllers.AttendanceBL">
                                        <SelectParameters>
                                            <asp:Parameter Name="username" Type="String" />
                                            <asp:Parameter Name="empId" Type="Int32" />
                                            <asp:Parameter Name="parentId" Type="Int32" />
                                            <asp:Parameter Name="from" Type="String" />
                                            <asp:Parameter Name="to" Type="String" />
                                            <asp:Parameter Name="shift" Type="String" />
                                            <asp:Parameter Name="shopId" Type="Int32" />
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
    <asp:ObjectDataSource ID="odsDetails" runat="server" SelectMethod="getListDetails" TypeName="LogicTier.Controllers.AttendanceBL">
        <SelectParameters>
            <asp:Parameter Name="Id" Type="Int64" />
        </SelectParameters>
    </asp:ObjectDataSource>
</asp:Content>
