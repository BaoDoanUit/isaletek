<%@ Page Title="Notify" Language="C#" MasterPageFile="~/Layout.master" AutoEventWireup="true" CodeBehind="Notify.aspx.cs" 
    Inherits="WebApplication.Pages.Notify" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Content" runat="server">
    <script type="text/javascript" src="../Scripts/jquery.dragsort-0.5.2.min.js"></script>
    <script>

</script>
    <script type="text/javascript">
        $(document).ready(function () {
            $("#TopPanel_NavMenu ul li:eq(6)").addClass("dxm-selected");
        })

        function Edit(Id) {
            console.log(Id);
            hdfKey.Set("ArticleId", Id);
            PopupCallback.PerformCallback('edit;' + Id);
            popupEdit.SetHeaderText('Edit Notify');
            popupEdit.Show();
        }
        function Del(Id) {
            if (confirm("Bạn chắc chắn muốn xóa không?")) {
                PopupCallback.PerformCallback('delete;' + Id);
            }
        }
        function New() {
            clear();
            hdfKey.Set("ArticleId", 0);
            PopupCallback.PerformCallback('new;-1');
            popupEdit.SetHeaderText('Add New Notify');
            popupEdit.Show();
        }
        function Save() {
            PopupCallback.PerformCallback('save;0');
        }

        function clear() {
            txtNotifyName.SetText('');
            memoContent.SetText('');
        }

        function PopupEndCallback(s, e) {
            if (s.cpAlert == "Thành công") {
                alert(s.cpAlert);
                popupEdit.Hide();
                dataCallback.PerformCallback();
            } else if (s.cpAlert !== '') {
                alert(s.cpAlert);
            } else {

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

        ul#gallery {
            float: left;
            width: 100%;
            padding: 0;
            margin: 0
        }

            ul#gallery li {
                float: left;
                height: 85px;
            }

        .thumbnail {
            position: relative
        }

        ul#gallery li a {
            padding-left: 15px
        }
        td#Content_popupEdit_Panel1_PopupCallback_ASPxFormLayout1_3 td.dxflCaptionCellSys{
            vertical-align: middle;
        }
    </style>

    <div class="row marginTop20">
        <div class="col-md-12">
            <dx:ASPxFormLayout ID="SearchFormLayout" ClientInstanceName="SearchFormLayout"
                runat="server" UseDefaultPaddings="false">
                <SettingsItems Width="100%" />
                <SettingsItemCaptions Location="Top" />
                <Items>
                    <dx:LayoutGroup Caption="Search">
                        <Items>
                            <dx:LayoutItem ShowCaption="False">
                                <LayoutItemNestedControlCollection>
                                    <dx:LayoutItemNestedControlContainer>
                                        <div class="row">
                                            <div class="col-md-3">
                                                <label>From</label>
                                                <dx:ASPxDateEdit runat="server" Width="100%" ID="fFromDate"
                                                    ClientInstanceName="fFromDate"
                                                    DisplayFormatString="yyyy-MM-dd"
                                                    EditFormat="Custom" EditFormatString="yyyy-MM-dd">
                                                    <ClearButton DisplayMode="OnHover"></ClearButton>
                                                </dx:ASPxDateEdit>
                                            </div>
                                            <div class="col-md-3">
                                                <label>To</label>
                                                <dx:ASPxDateEdit Width="100%" runat="server" ID="fToDate" DisplayFormatString="yyyy-MM-dd"
                                                    EditFormat="Custom" EditFormatString="yyyy-MM-dd">
                                                    <ClearButton DisplayMode="OnHover"></ClearButton>
                                                </dx:ASPxDateEdit>
                                            </div>
                                            <div class="col-md-6">
                                                <label style="color: white">Tool</label><br />
                                                <dx:ASPxButton ID="FilterButton" AutoPostBack="false"
                                                    CssClass="btn btn-primary" runat="server" Text="Tìm kiếm">
                                                    <ClientSideEvents Click="function(s, e) {  dataCallback.PerformCallback('filter'); }"></ClientSideEvents>
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
            <div class="row">
                <div class="col-md-12 marginTop20 marginBot20">
                    <div style="clear: both; height: 20px"></div>
                    <a onclick="New()" class="btn btn-blue"><i class="fa fa-plus-circle"></i>&nbsp; Add New&nbsp;  </a>

                    <dx:ASPxCallbackPanel ID="DataCallback" runat="server" Width="100%"
                        ClientInstanceName="dataCallback" OnCallback="DataCallback_Callback">
                        <PanelCollection>
                            <dx:PanelContent runat="server">
                                <dx:ASPxGridView runat="server" AutoGenerateColumns="False" ID="gvNotify"
                                    ClientInstanceName="gvNotify" Width="100%"
                                    DataSourceID="odsNotify"
                                    KeyFieldName="Id">
                                    <Styles>
                                        <Header Wrap="True" VerticalAlign="Middle" HorizontalAlign="Center"></Header>
                                        <Cell Wrap="True" VerticalAlign="Middle"></Cell>
                                        <AlternatingRow Enabled="true" />
                                    </Styles>
                                    <Columns>
                                        <dx:GridViewDataColumn VisibleIndex="0" Width="100px" Caption="Stt">
                                            <CellStyle HorizontalAlign="Center"></CellStyle>
                                            <DataItemTemplate>
                                                <%# Container.ItemIndex+1 %>
                                            </DataItemTemplate>
                                            <EditFormSettings Visible="False" />
                                        </dx:GridViewDataColumn>
                                        <dx:GridViewDataTextColumn FieldName="ArticleName"
                                            Caption="Notify Name"
                                            VisibleIndex="1">
                                            <EditFormSettings VisibleIndex="0" />
                                        </dx:GridViewDataTextColumn>

                                        <dx:GridViewDataTextColumn FieldName="Position"
                                            VisibleIndex="1">
                                            <EditFormSettings VisibleIndex="0" />
                                        </dx:GridViewDataTextColumn>
                                        <dx:GridViewDataTextColumn FieldName="Region"
                                            VisibleIndex="1">
                                            <EditFormSettings VisibleIndex="0" />
                                        </dx:GridViewDataTextColumn>
                                        <dx:GridViewDataTextColumn FieldName="ArticleContent" Width="300px" Caption="Content"
                                            VisibleIndex="2">
                                        </dx:GridViewDataTextColumn>
                                        <dx:GridViewDataDateColumn FieldName="DatePost" VisibleIndex="4" Caption="DatePost">
                                            <CellStyle VerticalAlign="Middle" HorizontalAlign="Center"></CellStyle>
                                        </dx:GridViewDataDateColumn>
                                        <dx:GridViewDataTextColumn FieldName="CountView"
                                            VisibleIndex="6">
                                            <EditFormSettings Visible="False" />
                                        </dx:GridViewDataTextColumn>
                                        <dx:GridViewDataTextColumn FieldName="Priority"
                                            VisibleIndex="7">
                                        </dx:GridViewDataTextColumn>
                                        <dx:GridViewDataTextColumn FieldName="StatusName" Caption="Status"
                                            VisibleIndex="7">
                                        </dx:GridViewDataTextColumn>
                                        <dx:GridViewDataImageColumn FieldName="IconUrl"
                                            VisibleIndex="7">
                                            <PropertiesImage ImageWidth="32px"></PropertiesImage>
                                            <CellStyle HorizontalAlign="Center"></CellStyle>
                                        </dx:GridViewDataImageColumn>
                                        <dx:GridViewDataColumn VisibleIndex="8" Caption="" Width="190px">
                                            <EditFormSettings Visible="False" />
                                            <CellStyle HorizontalAlign="Center"></CellStyle>
                                            <DataItemTemplate>
                                                <a onclick='<%# "Edit(" +Eval("Id") +")" %>' style="padding: 0 10px; cursor: pointer">Edit</a>
                                                <a onclick='<%# "Del(" +Eval("Id") +")" %>' style="cursor: pointer">Delete</a>
                                            </DataItemTemplate>
                                        </dx:GridViewDataColumn>
                                    </Columns>
                                    <Settings
                                        VerticalScrollBarStyle="Standard"
                                        VerticalScrollableHeight="370"
                                        VerticalScrollBarMode="Visible" />
                                    <SettingsBehavior AllowSort="true" ColumnResizeMode="Control" />
                                    <Styles>
                                        <Header HorizontalAlign="Center" Wrap="True" Paddings-Padding="3px"></Header>
                                        <Cell Wrap="True" VerticalAlign="Middle" Paddings-Padding="5px"></Cell>
                                    </Styles>
                                    <SettingsPager PageSize="12"></SettingsPager>
                                </dx:ASPxGridView>
                                <asp:ObjectDataSource runat="server" ID="odsNotify"
                                    SelectMethod="GetList"
                                    TypeName="LogicTier.Controllers.ArticlesBL">
                                    <SelectParameters>
                                        <asp:Parameter Name="ID" ConvertEmptyStringToNull="true" DbType="Int32" DefaultValue="" />
                                        <asp:ControlParameter ControlID="SearchFormLayout$fFromDate" Name="From" />
                                        <asp:ControlParameter ControlID="SearchFormLayout$fToDate" Name="To" />
                                        <asp:Parameter Name="ArticleType" DefaultValue="Notify" />
                                    </SelectParameters>
                                </asp:ObjectDataSource>
                            </dx:PanelContent>
                        </PanelCollection>
                    </dx:ASPxCallbackPanel>
                </div>
            </div>
        </div>
    </div>
    <dx:ASPxHiddenField ID="hdfKey" ClientInstanceName="hdfKey" runat="server"></dx:ASPxHiddenField>
    <dx:ASPxPopupControl ID="popupEdit" runat="server" Width="600"
        CloseAction="CloseButton" CloseOnEscape="true" Modal="True"
        PopupHorizontalAlign="WindowCenter" PopupVerticalAlign="WindowCenter"
        ClientInstanceName="popupEdit"
        AllowDragging="True" PopupAnimationType="None"
        EnableViewState="False" AutoUpdatePosition="true">
        <ContentCollection>
            <dx:PopupControlContentControl runat="server">
                <dx:ASPxPanel ID="Panel1" runat="server" DefaultButton="btOK">
                    <PanelCollection>
                        <dx:PanelContent runat="server">
                            <dx:ASPxCallbackPanel ID="PopupCallback" runat="server" Width="100%"
                                ClientInstanceName="PopupCallback" OnCallback="PopupCallback_Callback">
                                <ClientSideEvents EndCallback="PopupEndCallback" />
                                <PanelCollection>
                                    <dx:PanelContent runat="server">
                                        <dx:ASPxFormLayout runat="server" ID="ASPxFormLayout1" Width="100%" Height="100%">
                                            <Items>
                                                <dx:LayoutItem Caption="Notify Name">
                                                    <LayoutItemNestedControlCollection>
                                                        <dx:LayoutItemNestedControlContainer>
                                                            <dx:ASPxButtonEdit runat="server" Width="100%"
                                                                ID="txtNotifyName" ClientInstanceName="txtNotifyName">
                                                                <ClearButton DisplayMode="OnHover"></ClearButton>
                                                            </dx:ASPxButtonEdit>
                                                        </dx:LayoutItemNestedControlContainer>
                                                    </LayoutItemNestedControlCollection>
                                                </dx:LayoutItem>
                                                <dx:LayoutItem Caption="Content">
                                                    <LayoutItemNestedControlCollection>
                                                        <dx:LayoutItemNestedControlContainer>
                                                            <dx:ASPxMemo runat="server" Width="100%" Height="150px"
                                                                ID="memoContent" ClientInstanceName="memoContent">
                                                            </dx:ASPxMemo>
                                                        </dx:LayoutItemNestedControlContainer>
                                                    </LayoutItemNestedControlCollection>
                                                </dx:LayoutItem>
                                                <dx:LayoutItem Caption="Date Post">
                                                    <LayoutItemNestedControlCollection>
                                                        <dx:LayoutItemNestedControlContainer>
                                                            <asp:HiddenField ID="hfId" runat="server" />
                                                            <dx:ASPxDateEdit runat="server" Width="100%" ID="deDatePost" 
                                                                OnInit="deDatePost_Init"
                                                                DisplayFormatString="yyyy-MM-dd" ClientInstanceName="deDatePost"
                                                                EditFormat="Custom" EditFormatString="yyyy-MM-dd">
                                                                <ClearButton DisplayMode="OnHover"></ClearButton>
                                                            </dx:ASPxDateEdit>
                                                        </dx:LayoutItemNestedControlContainer>
                                                    </LayoutItemNestedControlCollection>
                                                </dx:LayoutItem>
                                                <dx:LayoutItem Caption="Status">
                                                    <LayoutItemNestedControlCollection>
                                                        <dx:LayoutItemNestedControlContainer>
                                                            <dx:ASPxRadioButtonList ID="rdStatus" 
                                                                runat="server" RepeatDirection="Horizontal" RepeatColumn="1" >
                                                                <Items>
                                                                    <dx:ListEditItem Value="1" Text="Level 1" />
                                                                    <dx:ListEditItem Value="2" Text="Level 2" />
                                                                    <dx:ListEditItem Value="3" Text="Level 3" />
                                                                </Items>
                                                            </dx:ASPxRadioButtonList>
                                                        </dx:LayoutItemNestedControlContainer>
                                                    </LayoutItemNestedControlCollection>
                                                </dx:LayoutItem>

                                                <dx:LayoutItem Caption="Region">
                                                    <LayoutItemNestedControlCollection>
                                                        <dx:LayoutItemNestedControlContainer>
                                                            <dx:ASPxCheckBoxList ID="clbRegion"
                                                                RepeatColumns="5"
                                                                ClientInstanceName="clbRegion"
                                                                runat="server"
                                                                RepeatDirection="Horizontal">
                                                                <Items>
                                                                    <dx:ListEditItem Value="ALL" Text="ALL" />
                                                                    <dx:ListEditItem Value="HCM" Text="HCM" />
                                                                    <dx:ListEditItem Value="HN" Text="HN" />
                                                                    <dx:ListEditItem Value="DN" Text="DN" />
                                                                    <dx:ListEditItem Value="MRD" Text="MRD" />
                                                                    <dx:ListEditItem Value="RRD" Text="RRD" />
                                                                    <dx:ListEditItem Value="NES" Text="NES" />
                                                                    <dx:ListEditItem Value="SCC" Text="SCC" />
                                                                    <dx:ListEditItem Value="NCC" Text="NCC" />
                                                                    <dx:ListEditItem Value="NE" Text="NE" />
                                                                    <dx:ListEditItem Value="CH" Text="CH" />
                                                                    <dx:ListEditItem Value="NW" Text="NW" />
                                                                </Items>

                                                            </dx:ASPxCheckBoxList>
                                                        </dx:LayoutItemNestedControlContainer>
                                                    </LayoutItemNestedControlCollection>
                                                </dx:LayoutItem>
                                                <dx:LayoutItem Caption="Position">
                                                    <LayoutItemNestedControlCollection>
                                                        <dx:LayoutItemNestedControlContainer>
                                                            <dx:ASPxCheckBoxList ID="clbPosition" ClientInstanceName="clbPosition"
                                                                RepeatDirection="Horizontal" runat="server">
                                                                <Items>
                                                                    <dx:ListEditItem Value="ALL" Text="ALL" />
                                                                    <dx:ListEditItem Value="HA" Text="HA" />
                                                                    <dx:ListEditItem Value="SHA" Text="SHA" />
                                                                </Items>
                                                            </dx:ASPxCheckBoxList>

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
