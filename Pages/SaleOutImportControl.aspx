<%@ Page Title="Sale Out Report" Language="C#" MasterPageFile="~/Layout.master" AutoEventWireup="true" CodeBehind="SaleOutImportControl.aspx.cs" Inherits="WebApplication.Pages.SaleOutImportControl" Async="true" %>

<%@ Register Src="~/UserControls/ToolbarExport.ascx" TagPrefix="uc1" TagName="ToolbarExport" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Content" runat="server">
    <script>
        function OnEndCallback(s, e) {
            if (s.cpAlert != '') {
                alert(s.cpAlert);
            }
        }
        function gvEndCallback(s, e) {
            if (s.cpSale != '') {
                alert(s.cpSale);
            }
        }
    </script>
    <script type="text/javascript">
        $(document).ready(function () {
            $("#TopPanel_NavMenu ul li:eq(4)").addClass("dxm-selected");
        })
    </script>
    <div class="container">
        <dx:ASPxCallbackPanel ID="ASPxCallbackPanel1" runat="server" Width="100%"
            ClientInstanceName="cp" OnCallback="ASPxCallbackPanel1_Callback">
            <ClientSideEvents EndCallback="OnEndCallback" />
            <PanelCollection>
                <dx:PanelContent runat="server">
                    <div class="row container marginTop20">
                        <div class="col-md-12 box-content">
                            <div class="row marginTop20">
                                <div class="col-md-12">
                                    <table class="OptionsBottomMargin">
                                        <tr>
                                            <td style="padding-right: 4px; padding-top: 10px;">
                                                <dx:ASPxButton ID="btnSelectAll" runat="server" Text="Chọn tất cả" UseSubmitBehavior="False"
                                                    AutoPostBack="false">
                                                    <ClientSideEvents Click="function(s, e) { gvSale.SelectRows(); }" />
                                                </dx:ASPxButton>
                                            </td>
                                            <td style="padding-right: 4px; padding-top: 10px;">
                                                <dx:ASPxButton ID="btnSelectAllOnPage" runat="server" Text="Chọn 1 trang"
                                                    UseSubmitBehavior="False" AutoPostBack="false">
                                                    <ClientSideEvents Click="function(s, e) { gvSale.SelectAllRowsOnPage(); }" />
                                                </dx:ASPxButton>
                                            </td>
                                            <td style="padding-right: 4px; padding-top: 10px;">
                                                <dx:ASPxButton ID="btnUnselectAll" runat="server" Text="Bỏ chọn" UseSubmitBehavior="False"
                                                    AutoPostBack="false">
                                                    <ClientSideEvents Click="function(s, e) { gvSale.UnselectRows(); gvSale.UnselectAllRowsOnPage(); }" />
                                                </dx:ASPxButton>
                                            </td>
                                            <td style="padding-right: 4px; padding-top: 10px;">
                                                <dx:ASPxButton ID="btImport" AutoPostBack="false" runat="server" Text="Import" CssClass="btn btn-link">
                                                    <ClientSideEvents Click="function(s, e) { pcImport.Show(); }" />
                                                </dx:ASPxButton>
                                            </td>
                                            <td style="padding-right: 4px; padding-top: 10px;">
                                                <dx:ASPxButton ID="FilterButton" AutoPostBack="false" runat="server" Text="Tìm kiếm">
                                                    <ClientSideEvents Click="function(s, e) {cp.PerformCallback('filter'); }"></ClientSideEvents>
                                                </dx:ASPxButton>
                                            </td>
                                            <td style="padding-right: 4px; padding-top: 10px;">
                                                <dx:ASPxButton ID="btnConfirm" runat="server" Text="Xác nhận" UseSubmitBehavior="False"
                                                    AutoPostBack="false">
                                                    <ClientSideEvents Click="function(s, e) {if(confirm('Bạn có chắc chắn muốn xác nhận dữ liệu import?')){  cp.PerformCallback('confirm');} }"></ClientSideEvents>
                                                </dx:ASPxButton>
                                            </td>
                                        </tr>
                                    </table>
                                </div>
                            </div>
                            <div class="row marginTop20 marginBot20">
                                <div class="col-md-12">
                                    <dx:ASPxGridView runat="server" AutoGenerateColumns="False" ID="gvSale" ClientInstanceName="gvSale" Width="100%"
                                        KeyFieldName="SaleId" OnLoad="gvSale_Load" OnCustomCallback="gvSale_CustomCallback" OnHtmlDataCellPrepared="gvSale_HtmlDataCellPrepared"
                                        OnRowDeleting="gvSale_RowDeleting" DataSourceID="odsSale">
                                        <ClientSideEvents EndCallback="gvEndCallback" />
                                        <SettingsCommandButton>
                                            <DeleteButton Text="Delete"></DeleteButton>
                                            <EditButton Text="Edit"></EditButton>
                                        </SettingsCommandButton>
                                        <SettingsBehavior ConfirmDelete="true" AllowFocusedRow="True" AutoExpandAllGroups="true" />
                                        <SettingsText ConfirmDelete="Are you sure?" />
                                        <SettingsEditing EditFormColumnCount="2" Mode="PopupEditForm" />
                                        <Settings HorizontalScrollBarMode="Visible" ShowTitlePanel="true" />
                                        <SettingsDataSecurity AllowInsert="False" />
                                        <SettingsPopup>
                                            <EditForm Width="600" HorizontalAlign="Center" VerticalAlign="Middle" />
                                        </SettingsPopup>
                                        <Styles>
                                            <FixedColumn BackColor="LightYellow"></FixedColumn>
                                            <Header Wrap="True" VerticalAlign="Middle" HorizontalAlign="Center"></Header>
                                            <Cell Wrap="True" VerticalAlign="Middle"></Cell>
                                            <AlternatingRow Enabled="true" />
                                        </Styles>
                                        <Templates>
                                            <EditForm>
                                                <div class="row">
                                                    <div class="col-md-12">
                                                        <dx:ASPxGridViewTemplateReplacement runat="server" ReplacementType="EditFormEditors" />
                                                    </div>
                                                </div>
                                                <div style="text-align: right; padding: 8px 8px 8px">
                                                    <dx:ASPxButton runat="server" ID="btUpdate" Text="Update" CssClass="btn btn-link" AutoPostBack="false">
                                                        <ClientSideEvents Click="function(s,e){gvSale.PerformCallback('update');}" />
                                                    </dx:ASPxButton>
                                                    <dx:ASPxButton runat="server" ID="btCancel" Text="Cancel" CssClass="btn btn-link" AutoPostBack="false">
                                                        <ClientSideEvents Click="function(s,e){gvSale.PerformCallback('cancel');}" />
                                                    </dx:ASPxButton>
                                                </div>
                                            </EditForm>
                                        </Templates>
                                        <Columns>
                                            <dx:GridViewCommandColumn ShowSelectCheckbox="True" VisibleIndex="0" FixedStyle="Left" />
                                            <dx:GridViewDataTextColumn FieldName="Region" VisibleIndex="1" FixedStyle="Left">
                                                <EditFormSettings Visible="False" />
                                            </dx:GridViewDataTextColumn>
                                            <dx:GridViewDataComboBoxColumn FieldName="SaleStatus" Caption="Status" VisibleIndex="2" FixedStyle="Left">
                                                <EditFormSettings VisibleIndex="0" Visible="False" />
                                            </dx:GridViewDataComboBoxColumn>
                                            <dx:GridViewDataComboBoxColumn FieldName="ShopName" VisibleIndex="3" FixedStyle="Left">
                                                <EditFormSettings VisibleIndex="0" />

                                            </dx:GridViewDataComboBoxColumn>
                                            <dx:GridViewDataTextColumn FieldName="SaleDate" VisibleIndex="4" FixedStyle="Left">
                                                <PropertiesTextEdit DisplayFormatString="{0:yyyy-MM-dd}"></PropertiesTextEdit>
                                                <EditFormSettings VisibleIndex="2" />

                                            </dx:GridViewDataTextColumn>
                                            <dx:GridViewDataTextColumn FieldName="Product" VisibleIndex="5" FixedStyle="Left">
                                                <EditFormSettings Visible="False" />
                                            </dx:GridViewDataTextColumn>
                                            <dx:GridViewDataColumn FieldName="Range" VisibleIndex="6" FixedStyle="Left">
                                                <EditFormSettings Visible="False" />
                                            </dx:GridViewDataColumn>
                                            <dx:GridViewDataColumn FieldName="Model" VisibleIndex="7" FixedStyle="Left">
                                                <EditFormSettings VisibleIndex="1" />

                                            </dx:GridViewDataColumn>
                                            <dx:GridViewDataColumn FieldName="Color" VisibleIndex="8">
                                                <EditFormSettings VisibleIndex="3" />
                                                <EditItemTemplate>
                                                    <dx:ASPxTextBox runat="server" ID="txeColor" Text='<%#Eval("Color") %>'></dx:ASPxTextBox>
                                                </EditItemTemplate>
                                            </dx:GridViewDataColumn>
                                            <dx:GridViewDataColumn FieldName="Quantity" VisibleIndex="9">
                                                <EditFormSettings VisibleIndex="4" />
                                            </dx:GridViewDataColumn>
                                            <dx:GridViewDataSpinEditColumn FieldName="Price" VisibleIndex="10">
                                                <EditFormSettings VisibleIndex="5" />
                                                <PropertiesSpinEdit DisplayFormatString="{0:C}" DecimalPlaces="11"></PropertiesSpinEdit>
                                            </dx:GridViewDataSpinEditColumn>
                                            <dx:GridViewDataTextColumn FieldName="CusName" VisibleIndex="12" Caption="Customer Name">
                                                <EditFormSettings VisibleIndex="6" />
                                            </dx:GridViewDataTextColumn>
                                            <dx:GridViewDataTextColumn FieldName="CusPhone" VisibleIndex="13" Caption="Cell phone">
                                                <EditFormSettings VisibleIndex="7" />
                                            </dx:GridViewDataTextColumn>
                                            <dx:GridViewDataTextColumn FieldName="CussAdd" VisibleIndex="14" Caption="Address">
                                                <EditFormSettings VisibleIndex="8" />
                                            </dx:GridViewDataTextColumn>
                                            <dx:GridViewDataTextColumn FieldName="EmployeeCode" VisibleIndex="15">
                                                <EditFormSettings Visible="False" />
                                            </dx:GridViewDataTextColumn>
                                            <dx:GridViewDataTextColumn FieldName="EmployeeName" VisibleIndex="16">
                                                <EditFormSettings Visible="False" />
                                            </dx:GridViewDataTextColumn>
                                            <dx:GridViewCommandColumn ShowEditButton="false" ShowDeleteButton="true" VisibleIndex="17">
                                            </dx:GridViewCommandColumn>
                                        </Columns>
                                    </dx:ASPxGridView>
                                    <asp:ObjectDataSource ID="odsSale" runat="server" SelectMethod="getByusername" TypeName="LogicTier.Controllers.SaleOutBL">
                                        <SelectParameters>
                                            <asp:Parameter Name="EmployeeId" Type="Int32" ConvertEmptyStringToNull="true" DefaultValue="0" />
                                        </SelectParameters>
                                    </asp:ObjectDataSource>
                                    <asp:ObjectDataSource ID="odsEOutlets" runat="server" SelectMethod="getByEmployee" TypeName="LogicTier.Controllers.OutletBL">
                                        <SelectParameters>
                                            <asp:Parameter Name="empId" Type="Int32" />
                                            <asp:Parameter Name="activeDate" Type="String" />
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
    <dx:ASPxPopupControl ID="pcImport" runat="server" Width="320" CloseAction="CloseButton" CloseOnEscape="true" Modal="True"
        PopupHorizontalAlign="WindowCenter" PopupVerticalAlign="WindowCenter" ClientInstanceName="pcImport"
        HeaderText="Choose the Excel file to Import" AllowDragging="True" PopupAnimationType="None" EnableViewState="False" AutoUpdatePosition="true">
        <ContentCollection>
            <dx:PopupControlContentControl runat="server">
                <dx:ASPxPanel ID="Panel1" runat="server" DefaultButton="btOK">
                    <PanelCollection>
                        <dx:PanelContent runat="server">
                            <dx:ASPxFormLayout runat="server" ID="ASPxFormLayout1" Width="100%" Height="100%">
                                <Items>
                                    <dx:LayoutItem ShowCaption="False">
                                        <LayoutItemNestedControlCollection>
                                            <dx:LayoutItemNestedControlContainer>
                                                <dx:ASPxUploadControl ID="UploadControl" runat="server" ClientInstanceName="upload"
                                                    NullText="Bấm để chọn file excel..." OnFileUploadComplete="UploadControl_FileUploadComplete">
                                                    <AdvancedModeSettings EnableMultiSelect="false" EnableDragAndDrop="true" />
                                                    <ValidationSettings MaxFileSize="4194304" AllowedFileExtensions=".xls, .xlsx" ShowErrors="false"></ValidationSettings>
                                                    <ClientSideEvents FileUploadComplete="function(s,e){ 
                                                    if (e.callbackData != '') {
                                                       alert(e.callbackData); 
                                                   }}" />
                                                </dx:ASPxUploadControl>
                                            </dx:LayoutItemNestedControlContainer>
                                        </LayoutItemNestedControlCollection>
                                    </dx:LayoutItem>
                                    <dx:LayoutItem ShowCaption="False">
                                        <LayoutItemNestedControlCollection>
                                            <dx:LayoutItemNestedControlContainer>
                                                <div class="row marginTop20">
                                                    <div class="col-md-12 text-center">
                                                        <dx:ASPxButton ID="btOK" runat="server" Text="Import" Width="80px" AutoPostBack="False" CssClass="btn btn-success">
                                                            <ClientSideEvents Click="function(s, e) { upload.UploadFile();pcImport.Hide();}" />
                                                        </dx:ASPxButton>
                                                        &nbsp;
                                                        <dx:ASPxButton ID="btCancel" runat="server" Text="Cancel" Width="80px" AutoPostBack="False">
                                                            <ClientSideEvents Click="function(s, e) { pcImport.Hide(); }" />
                                                        </dx:ASPxButton>
                                                    </div>
                                                </div>
                                            </dx:LayoutItemNestedControlContainer>
                                        </LayoutItemNestedControlCollection>
                                    </dx:LayoutItem>
                                </Items>
                            </dx:ASPxFormLayout>
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
