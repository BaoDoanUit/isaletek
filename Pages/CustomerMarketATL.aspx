<%@ Page Title="Market Information ATL" Language="C#" MasterPageFile="~/Layout.master" AutoEventWireup="true" CodeBehind="CustomerMarketATL.aspx.cs" Inherits="WebApplication.Pages.CustomerMarketATL" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Content" runat="server">
    <script type="text/javascript" src="../Scripts/jquery.dragsort-0.5.2.min.js"></script>
    <script>
        function OnEndCallback(s, e) {
            if (s.cpAlert != '' && (typeof s.cpAlert !== 'undefined')) {
                alert(s.cpAlert);
                pcImport.Hide();
                if (s.cpAlert === "Xóa thành công!") {
                    cp.PerformCallback('filter;0');
                }
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
                    pcImport.Hide();
                }
            }
        }
        function Del(Id) {
            if (confirm("Bạn chắc chắn muốn xóa không?")) {
                cp.PerformCallback('delete;' + Id);
            }
        }
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
                    <div class="row">
                        <div class="col-md-12 marginTop20">
                            <dx:ASPxFormLayout ID="AddCommentFormLayout" runat="server" UseDefaultPaddings="false">
                                <SettingsItems Width="100%" />
                                <SettingsItemCaptions Location="Top" />
                                <Items>
                                    <dx:LayoutGroup Caption="Price Activities">
                                        <Items>
                                            <dx:LayoutItem ShowCaption="False">
                                                <LayoutItemNestedControlCollection>
                                                    <dx:LayoutItemNestedControlContainer>
                                                        <div class="row">
                                                            <div class="col-md-3" style="display: none">
                                                                <dx:ASPxComboBox Caption="Term *" runat="server" ID="cbTerm" Width="100%" DataSourceID="odsTerm" ValueField="Id" ValueType="System.Int32" NullText="--All--"
                                                                    ClientInstanceName="cbTerm" DropDownStyle="DropDownList">
                                                                    <ClearButton DisplayMode="OnHover"></ClearButton>
                                                                    <Columns>
                                                                        <dx:ListBoxColumn FieldName="TermCycle" Caption="Term" />
                                                                    </Columns>
                                                                </dx:ASPxComboBox>
                                                                <asp:ObjectDataSource ID="odsTerm" runat="server" SelectMethod="getList" TypeName="LogicTier.Controllers.TermController"></asp:ObjectDataSource>
                                                            </div>
                                                            <div class="col-md-3">
                                                                <dx:ASPxComboBox Caption="Month *" runat="server" ID="cbMonth" DataSourceID="odsMonth" ValueField="MonthCycle" ValueType="System.String" NullText="--All--"
                                                                    ClientInstanceName="cbMonth" EnableCallbackMode="true" DropDownStyle="DropDownList">
                                                                    <ClearButton DisplayMode="OnHover"></ClearButton>
                                                                    <Columns>
                                                                        <dx:ListBoxColumn FieldName="MonthCycle" Caption="Month" />
                                                                    </Columns>
                                                                </dx:ASPxComboBox>
                                                                <asp:ObjectDataSource ID="odsMonth" runat="server" SelectMethod="getMonth" TypeName="LogicTier.Controllers.TermController">
                                                                    <SelectParameters>
                                                                        <asp:ControlParameter ControlID="cbTerm" DbType="Int32" Name="Id" PropertyName="Value" />
                                                                    </SelectParameters>
                                                                </asp:ObjectDataSource>
                                                            </div>
                                                            <div class="col-md-6">
                                                                <label style="color: white">Tool</label>
                                                                <dx:ASPxButton ID="btFilter" AutoPostBack="false" runat="server" Text="Tìm kiếm" CssClass="btn btn-primary">
                                                                    <ClientSideEvents Click="function(s, e) {  cp.PerformCallback('filter;'+lbSelected.GetText()); }"></ClientSideEvents>
                                                                </dx:ASPxButton>
                                                                <dx:ASPxButton ID="btCreateNew" AutoPostBack="false" runat="server" Text="Thêm mới" CssClass="btn btn-warning">
                                                                    <ClientSideEvents Click="function(s, e) { ShowWindow();}"></ClientSideEvents>
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
                    <div class="row container marginTop20">
                        <div class="col-md-12 box-content">
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
                                            <dx:GridViewDataColumn FieldName="ActivityName" VisibleIndex="2" Caption="Activity Name"></dx:GridViewDataColumn>
                                            <dx:GridViewDataTextColumn FieldName="ActivityDate" VisibleIndex="3">
                                                <PropertiesTextEdit DisplayFormatString="yyyy-MM-dd"></PropertiesTextEdit>
                                            </dx:GridViewDataTextColumn>
                                            <dx:GridViewDataColumn Width="110px" Caption="View" VisibleIndex="4">
                                                <CellStyle HorizontalAlign="Center"></CellStyle>
                                                <DataItemTemplate>
                                                    <a href='<%# Eval("FilePath") %>' target="_blank">Click</a>
                                                </DataItemTemplate>
                                            </dx:GridViewDataColumn>
                                            <dx:GridViewDataColumn Caption="" VisibleIndex="5">
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
        HeaderText="Price Activities" AllowDragging="True" PopupAnimationType="None" EnableViewState="False" AutoUpdatePosition="true">
        <ContentCollection>
            <dx:PopupControlContentControl runat="server">
                <dx:ASPxPanel ID="Panel1" runat="server" DefaultButton="btOK">
                    <PanelCollection>
                        <dx:PanelContent runat="server">
                            <dx:ASPxFormLayout runat="server" ID="ASPxFormLayout1" Width="100%" Height="100%">
                                <Items>
                                    <dx:LayoutItem Caption="Date">
                                        <LayoutItemNestedControlCollection>
                                            <dx:LayoutItemNestedControlContainer>
                                                <dx:ASPxDateEdit runat="server" ID="txFrom" DisplayFormatString="yyyy-MM-dd"
                                                    EditFormat="Custom" EditFormatString="yyyy-MM-dd">
                                                    <ClearButton DisplayMode="OnHover"></ClearButton>
                                                </dx:ASPxDateEdit>
                                            </dx:LayoutItemNestedControlContainer>
                                        </LayoutItemNestedControlCollection>
                                    </dx:LayoutItem>
                                    <dx:LayoutItem Caption="Name">
                                        <LayoutItemNestedControlCollection>
                                            <dx:LayoutItemNestedControlContainer>
                                                <dx:ASPxButtonEdit runat="server" ID="txtnamenew" Width="100%" ClientInstanceName="txtnamenew">
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
