<%@ Page Title="Shop Checking" Language="C#" MasterPageFile="~/Layout.master" AutoEventWireup="true" CodeBehind="ShopChecking.aspx.cs" Inherits="WebApplication.Pages.ShopChecking" %>
<asp:Content ID="Content1" ContentPlaceHolderID="Content" runat="server">
    <script type="text/javascript" src="../Scripts/jquery.dragsort-0.5.2.min.js"></script>
    <script>
        function OnEndCallback(s, e) {
            if (s.cpAlert != '' && (typeof s.cpAlert !== 'undefined')) {
                alert(s.cpAlert);
                cp.PerformCallback('filter;0'); pcImport.Hide();
            }
        }
        function ShowWindow() {
            pcImport.Show();
        }
        function onFileUploadComplete(s, e) {
            if (e.callbackData) {
                if (e.callbackData != null && e.callbackData != "")
                    alert(e.callbackData);
                if (e.callbackData === "Lưu thành công!") {
                    cp.PerformCallback('filter;0');
                } pcImport.Hide();
            }
        }
        function Del(Id) {
            if (confirm("Bạn chắc chắn muốn xóa không?")) {
                cp.PerformCallback('delete;' + Id);
            }
        }
    </script>
    <script type="text/javascript">
        $(document).ready(function () {
            $("#TopPanel_NavMenu ul li:eq(6)").addClass("dxm-selected");
        })
    </script>
    <style type="text/css">
        ul {
            list-style-type: none;
        }

        .placeHolder div {
            background-color: white !important;
            border: dashed 1px gray !important;
        }
    </style>
    <dx:ASPxCallbackPanel ID="ASPxCallbackPanel1" runat="server" Width="100%"
        ClientInstanceName="cp" OnCallback="ASPxCallbackPanel1_Callback">
        <ClientSideEvents EndCallback="OnEndCallback" />
        <PanelCollection>
            <dx:PanelContent runat="server">
                <div class="container">
                    <div class="row container marginTop20">
                        <div class="col-md-12 box-content">
                            <div class="row marginBot20">
                                <div class="col-md-6">
                                    <label style="color: white">Tool</label><br />
                                    <dx:ASPxButton ID="btCreateNew" AutoPostBack="false" runat="server" Text="Thêm mới" CssClass="btn btn-primary">
                                        <ClientSideEvents Click="function(s, e) { ShowWindow();}"></ClientSideEvents>
                                    </dx:ASPxButton>
                                </div>
                            </div>
                            <div class="row marginTop20 marginBot20">
                                <div class="col-md-12">
                                    <dx:ASPxGridView ID="grData" runat="server" AutoGenerateColumns="false" Theme="Material" Width="100%">
                                        <Columns>
                                            <dx:GridViewDataColumn Width="72px" VisibleIndex="0" Caption="Stt">
                                                <CellStyle HorizontalAlign="Center"></CellStyle>
                                                <DataItemTemplate>
                                                    <%# Container.ItemIndex + 1 %>
                                                </DataItemTemplate>
                                            </dx:GridViewDataColumn>
                                            <dx:GridViewDataColumn FieldName="FileName" VisibleIndex="2" Caption="FileName"></dx:GridViewDataColumn>
                                            <dx:GridViewDataColumn Caption="Month" VisibleIndex="3">
                                                <CellStyle HorizontalAlign="Center"></CellStyle>
                                                <DataItemTemplate>
                                                    <%# Eval("Month") %> / <%# Eval("Year") %>
                                                </DataItemTemplate>
                                            </dx:GridViewDataColumn>
                                            <dx:GridViewDataColumn Caption="View" VisibleIndex="4">
                                                <CellStyle HorizontalAlign="Center"></CellStyle>
                                                <DataItemTemplate>
                                                    <a href='<%# Eval("FilePath") %>' target="_blank">Click</a>
                                                </DataItemTemplate>
                                            </dx:GridViewDataColumn>
                                            <dx:GridViewDataColumn Caption="" VisibleIndex="4">
                                                <CellStyle HorizontalAlign="Center"></CellStyle>
                                                <DataItemTemplate>
                                                    <a onclick='<%# "Del(" +Eval("Id") +")" %>' style="cursor: pointer; color: orangered">Delete</a>
                                                </DataItemTemplate>
                                            </dx:GridViewDataColumn>
                                        </Columns>
                                        <Settings VerticalScrollableHeight="330" VerticalScrollBarMode="Visible" />
                                        <SettingsBehavior AllowSort="true" ColumnResizeMode="Control" />
                                        <Styles>
                                            <Header HorizontalAlign="Center" Wrap="True" Paddings-Padding="3px">
                                                <Paddings Padding="3px"></Paddings>
                                            </Header>
                                            <Cell Wrap="True" VerticalAlign="Middle" Paddings-Padding="5px">
                                                <Paddings Padding="5px"></Paddings>
                                            </Cell>
                                        </Styles>
                                        <SettingsPager PageSize="200000"></SettingsPager>
                                    </dx:ASPxGridView>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </dx:PanelContent>
        </PanelCollection>
    </dx:ASPxCallbackPanel>
    <dx:ASPxPopupControl ID="pcImport" runat="server" Width="600" CloseAction="CloseButton" CloseOnEscape="true" Modal="True"
        PopupHorizontalAlign="WindowCenter" PopupVerticalAlign="WindowCenter" ClientInstanceName="pcImport"
        HeaderText="Shop Checking" AllowDragging="True" PopupAnimationType="None" EnableViewState="False" AutoUpdatePosition="true">
        <ContentCollection>
            <dx:PopupControlContentControl runat="server">
                <dx:ASPxPanel ID="Panel1" runat="server" DefaultButton="btOK">
                    <PanelCollection>
                        <dx:PanelContent runat="server">
                            <dx:ASPxFormLayout runat="server" ID="ASPxFormLayout1" Width="100%" Height="100%">
                                <Items>
                                    <dx:LayoutItem Caption="Month">
                                        <LayoutItemNestedControlCollection>
                                            <dx:LayoutItemNestedControlContainer>
                                                <dx:ASPxComboBox runat="server" ID="cbmonth" NullText="Month" ClientInstanceName="cbmonth" EnableCallbackMode="true" CallbackPageSize="10"
                                                    DropDownStyle="DropDownList">
                                                    <ClearButton DisplayMode="OnHover"></ClearButton>
                                                    <Items>
                                                        <dx:ListEditItem Text="01" Value="1" />
                                                        <dx:ListEditItem Text="02" Value="2" />
                                                        <dx:ListEditItem Text="03" Value="3" />
                                                        <dx:ListEditItem Text="04" Value="4" />
                                                        <dx:ListEditItem Text="05" Value="5" />
                                                        <dx:ListEditItem Text="06" Value="6" />
                                                        <dx:ListEditItem Text="07" Value="7" />
                                                        <dx:ListEditItem Text="08" Value="8" />
                                                        <dx:ListEditItem Text="09" Value="9" />
                                                        <dx:ListEditItem Text="10" Value="10" />
                                                        <dx:ListEditItem Text="11" Value="11" />
                                                        <dx:ListEditItem Text="12" Value="12" />
                                                    </Items>
                                                </dx:ASPxComboBox>
                                            </dx:LayoutItemNestedControlContainer>
                                        </LayoutItemNestedControlCollection>
                                    </dx:LayoutItem>
                                    <dx:LayoutItem Caption="Year">
                                        <LayoutItemNestedControlCollection>
                                            <dx:LayoutItemNestedControlContainer>
                                                <dx:ASPxComboBox runat="server" ID="cbyear" NullText="Year" ClientInstanceName="cbyear" EnableCallbackMode="true" CallbackPageSize="10"
                                                    DropDownStyle="DropDownList">
                                                    <ClearButton DisplayMode="OnHover"></ClearButton>
                                                    <Items>
                                                        <dx:ListEditItem Text="2019" Value="2019" />
                                                        <dx:ListEditItem Text="2020" Value="2020" />
                                                        <dx:ListEditItem Text="2021" Value="2021" />
                                                        <dx:ListEditItem Text="2022" Value="2022" />
                                                    </Items>
                                                </dx:ASPxComboBox>
                                            </dx:LayoutItemNestedControlContainer>
                                        </LayoutItemNestedControlCollection>
                                    </dx:LayoutItem>
                                    <dx:LayoutItem Caption="Name">
                                        <LayoutItemNestedControlCollection>
                                            <dx:LayoutItemNestedControlContainer>
                                                <dx:ASPxButtonEdit runat="server" ID="txtnamenew" ClientInstanceName="txtnamenew">
                                                    <ClearButton DisplayMode="OnHover"></ClearButton>
                                                </dx:ASPxButtonEdit>
                                            </dx:LayoutItemNestedControlContainer>
                                        </LayoutItemNestedControlCollection>
                                    </dx:LayoutItem>
                                    <dx:LayoutItem ShowCaption="False">
                                        <LayoutItemNestedControlCollection>
                                            <dx:LayoutItemNestedControlContainer>
                                                <dx:ASPxUploadControl ID="upImages" runat="server" ClientInstanceName="upImages" Width="100%" UploadButton-ImagePosition="Bottom"
                                                    NullText="Chọn file (.jpe, .jpeg, .jpg, .gif, .png, .mp4, .pptx, .xlsx, .pdf)..." UploadMode="Advanced" ShowProgressPanel="True"
                                                    OnFileUploadComplete="upImages_FileUploadComplete" FileUploadMode="OnPageLoad">
                                                    <ValidationSettings AllowedFileExtensions=".jpe, .jpeg, .jpg, .gif, .png, .mp4, .pptx, .xlsx, .pdf"></ValidationSettings>
                                                    <AdvancedModeSettings EnableMultiSelect="True" EnableFileList="True" EnableDragAndDrop="false" />
                                                    <ClientSideEvents FileUploadComplete="onFileUploadComplete" />
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
                                                            <ClientSideEvents Click="function(s, e) { upImages.Upload(); }" />
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
    <asp:HiddenField ID="hfId" runat="server" />
    <dx:ASPxHiddenField ID="hdfKey" ClientInstanceName="hdfKey" runat="server"></dx:ASPxHiddenField>
</asp:Content>