<%@ Page Title="Online Training" Language="C#" MasterPageFile="~/Layout.master" AutoEventWireup="true" CodeBehind="PC_OnlineTraining.aspx.cs" Inherits="WebApplication.Pages.PC_OnlineTraining" %>
<asp:Content ID="Content1" ContentPlaceHolderID="Content" runat="server">
    <script>
        function OnEndCallback(s, e) {
            if (s.cpAlert != '' && (typeof s.cpAlert !== 'undefined')) {
                alert(s.cpAlert);
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

        
        .dxEditors_edtRadioButtonUnchecked_Moderno {
            background-position: -18px -18px !important;
            width: 18px !important;
            height: 18px !important;
        }
        .dxEditors_edtRadioButtonUnchecked_Moderno,.dxEditors_edtRadioButtonChecked_Moderno {
            background-size: 36px !important;
        }
        .dxEditors_edtRadioButtonChecked_Moderno {
            background-position: 0 0 !important;
            width: 18px !important;
            height: 18px !important;
        }
        .dxeRoot_Moderno td:first-child{
            width: 85px
        }
        .dxeRoot_Moderno td:last-child{
            width: calc(100% - 85px)
        }
        .dxeRadioButtonList_Moderno td{
            width: auto!important
        }
        .dxeRadioButtonList_Moderno {
            border: none !important
        }

        .dxeCaption_Moderno {
            font-weight: 600;
        }
        .dxeFocused_Moderno{
            box-shadow: none!important; 
            webkit-box-shadow: none!important;
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
                                <SettingsItemCaptions Location="Top" />
                                <Items>
                                    <dx:LayoutGroup Caption="Search" ColCount="2">
                                        <Items>
                                            <dx:LayoutItem ShowCaption="False" Width="30%">
                                                <LayoutItemNestedControlCollection>
                                                    <dx:LayoutItemNestedControlContainer>
                                                        <dx:ASPxRadioButtonList runat="server" Caption="Product *" ID="rdProduct" RepeatColumns="5" DataSourceID="odsProduct" ValueField="Product" TextField="Product" RepeatDirection="Vertical">
                                                            <RadioButtonStyle Font-Size="10px"></RadioButtonStyle>
                                                        </dx:ASPxRadioButtonList>
                                                        <asp:ObjectDataSource ID="odsProduct" runat="server" SelectMethod="getDivision" TypeName="LogicTier.Controllers.ProductsBL">
                                                            <SelectParameters>
                                                                <asp:Parameter DefaultValue="Product" Name="fieldName" Type="String" />
                                                                <asp:Parameter Name="fieldValue" Type="String" />
                                                                <asp:Parameter DefaultValue="Product" Name="fieldDisplay" Type="String" />
                                                            </SelectParameters>
                                                        </asp:ObjectDataSource>
                                                    </dx:LayoutItemNestedControlContainer>
                                                </LayoutItemNestedControlCollection>
                                            </dx:LayoutItem>
                                            <dx:LayoutItem ShowCaption="False">
                                                <LayoutItemNestedControlCollection>
                                                    <dx:LayoutItemNestedControlContainer>
                                                        <dx:ASPxButton ID="btFilter" AutoPostBack="false" runat="server" Text="Search">
                                                            <ClientSideEvents Click="function(s, e) {  cp.PerformCallback('filter') }"></ClientSideEvents>
                                                        </dx:ASPxButton>
                                                    </dx:LayoutItemNestedControlContainer>
                                                </LayoutItemNestedControlCollection>
                                            </dx:LayoutItem>
                                        </Items>
                                    </dx:LayoutGroup>
                                </Items>
                            </dx:ASPxFormLayout>
                        </div>
                    </div>
                    <div class="row marginTop20">
                        <div class="col-md-12">
                            <dx:ASPxGridView runat="server" AutoGenerateColumns="False" ID="gvLessions" ClientInstanceName="gvLessions" Width="100%"
                                KeyFieldName="LessonId">
                                <SettingsBehavior EnableCustomizationWindow="true" AllowFocusedRow="true" />
                                <SettingsDetail ShowDetailRow="True" AllowOnlyOneMasterRowExpanded="True" />
                                <ClientSideEvents EndCallback="OnEndCallback" RowClick="function(s, e) {s.ExpandDetailRow(s.GetFocusedRowIndex());}" />
                                <SettingsPopup>
                                    <EditForm Width="400" HorizontalAlign="Center" VerticalAlign="Middle" />
                                </SettingsPopup>
                                <Styles>
                                    <Header Wrap="True" VerticalAlign="Middle" HorizontalAlign="Center"></Header>
                                    <Cell Wrap="True" VerticalAlign="Middle"></Cell>
                                    <AlternatingRow Enabled="true" />
                                </Styles>
                                <Columns>
                                    <dx:GridViewDataColumn VisibleIndex="0" Caption="Stt">
                                        <CellStyle HorizontalAlign="Center"></CellStyle>
                                        <DataItemTemplate>
                                            <%# Container.ItemIndex+1 %>
                                        </DataItemTemplate>
                                        <EditFormSettings Visible="False" />
                                    </dx:GridViewDataColumn>
                                    <dx:GridViewDataTextColumn FieldName="CourseName" Caption="Tên bài học" VisibleIndex="1">
                                        <EditFormSettings VisibleIndex="0" />
                                    </dx:GridViewDataTextColumn>
                                    <dx:GridViewDataTextColumn FieldName="LBNo" Caption="Tổng số Slide" VisibleIndex="2">
                                        <EditFormSettings Visible="False" />
                                    </dx:GridViewDataTextColumn>
                                </Columns>
                                <Templates>
                                    <DetailRow>
                                        <div class="row" style="margin: 3px;">
                                            <dx:ASPxPageControl runat="server" ID="pageControl" Width="100%" EnableCallBacks="true" ActiveTabIndex="0">
                                                <TabPages>
                                                    <dx:TabPage Text="Nội dung bài học" Visible="true">
                                                        <ContentCollection>
                                                            <dx:ContentControl runat="server">
                                                                <div class="row">
                                                                    <ul id="gallery">
                                                                        <asp:Repeater ID="rptGallery" runat="server" OnInit="rptGallery_Init" OnItemDataBound="rptGallery_ItemDataBound">
                                                                            <ItemTemplate>
                                                                                <li data-itemid='<%# Eval("slide_Id") %>' class="col-md-3">
                                                                                    <div class="thumbnail">
                                                                                        <asp:Literal runat="server" ID="ltrSlide" Text='<%#Eval("IsVideo") +";"+Eval("SlideContent") +";"+Eval("LessonId") +";"+ (Container.ItemIndex + 1) %>'></asp:Literal>
                                                                                    </div>
                                                                                </li>
                                                                            </ItemTemplate>
                                                                        </asp:Repeater>
                                                                    </ul>
                                                                </div>
                                                            </dx:ContentControl>
                                                        </ContentCollection>
                                                    </dx:TabPage>
                                                </TabPages>
                                            </dx:ASPxPageControl>
                                        </div>
                                    </DetailRow>
                                </Templates>
                            </dx:ASPxGridView>
                        </div>
                    </div>
                </div>
            </dx:PanelContent>
        </PanelCollection>
    </dx:ASPxCallbackPanel>
    <asp:HiddenField runat="server" ID="hfLessionId" />
</asp:Content>