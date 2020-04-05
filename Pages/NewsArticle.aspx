<%@ Page Title="News" Language="C#" MasterPageFile="~/Layout.master"
    AutoEventWireup="true"
    CodeBehind="NewsArticle.aspx.cs" Inherits="WebApplication.Pages.NewsArticle" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Content" runat="server">
    <script type="text/javascript" src="../Scripts/jquery.dragsort-0.5.2.min.js"></script>
    <script>

</script>
    <script type="text/javascript">
        $(document).ready(function () {
            $("#TopPanel_NavMenu ul li:eq(6)").addClass("dxm-selected");
        })


        function New() {
            window.location = "/Pages/NewsCreate.aspx?Id=0";
        }

        function Edit(Id) {
            window.location = "/Pages/NewsCreate.aspx?Id=" + Id;
        }


        function Del(Id) {
            if (confirm("Bạn chắc chắn muốn xóa tin tức này?")) {
                dataCallback.PerformCallback('delete;' + Id);
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

        td#Content_popupEdit_Panel1_PopupCallback_ASPxFormLayout1_3 td.dxflCaptionCellSys {
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
                                <dx:ASPxGridView runat="server" AutoGenerateColumns="False"
                                    ID="gvNews"
                                    ClientInstanceName="gvNews" Width="100%"
                                    DataSourceID="odsNews"
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
                                        </dx:GridViewDataColumn>
                                        <dx:GridViewDataTextColumn FieldName="ArticleName"
                                            Caption="News"
                                            VisibleIndex="1">
                                        </dx:GridViewDataTextColumn>
                                        <dx:GridViewDataTextColumn FieldName="Position"
                                            VisibleIndex="2">
                                            <EditFormSettings VisibleIndex="0" />
                                        </dx:GridViewDataTextColumn>
                                        <dx:GridViewDataTextColumn FieldName="Region"
                                            VisibleIndex="3">
                                            <EditFormSettings VisibleIndex="0" />
                                        </dx:GridViewDataTextColumn>
                                        <dx:GridViewDataDateColumn FieldName="DatePost" VisibleIndex="4" Caption="DatePost">
                                            <CellStyle VerticalAlign="Middle" HorizontalAlign="Center"></CellStyle>
                                        </dx:GridViewDataDateColumn>
                                        <dx:GridViewDataTextColumn FieldName="CountView"
                                            VisibleIndex="5">
                                            <EditFormSettings Visible="False" />
                                        </dx:GridViewDataTextColumn>
                                        <dx:GridViewDataTextColumn FieldName="Priority"
                                            VisibleIndex="6">
                                        </dx:GridViewDataTextColumn>
                                        <dx:GridViewDataTextColumn FieldName="StatusName" Caption="Status"
                                            VisibleIndex="7">
                                        </dx:GridViewDataTextColumn>
                                        <dx:GridViewDataImageColumn FieldName="IconUrl"
                                            VisibleIndex="8">
                                            <PropertiesImage ImageWidth="32px"></PropertiesImage>
                                            <CellStyle HorizontalAlign="Center"></CellStyle>
                                        </dx:GridViewDataImageColumn>
                                        <dx:GridViewDataColumn VisibleIndex="9" Caption="" >
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
                                <asp:ObjectDataSource runat="server" ID="odsNews"
                                    SelectMethod="GetList"
                                    TypeName="LogicTier.Controllers.ArticlesBL">
                                    <SelectParameters>
                                        <asp:Parameter Name="ID" ConvertEmptyStringToNull="true" DbType="Int32" DefaultValue="" />
                                        <asp:ControlParameter ControlID="SearchFormLayout$fFromDate" Name="From" />
                                        <asp:ControlParameter ControlID="SearchFormLayout$fToDate" Name="To" />
                                        <asp:Parameter Name="ArticleType" DefaultValue="News" />
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
</asp:Content>
