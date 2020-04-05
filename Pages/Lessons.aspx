<%@ Page Title="Training Online" Language="C#" MasterPageFile="~/Layout.master" AutoEventWireup="true" CodeBehind="Lessons.aspx.cs" Inherits="WebApplication.Pages.Lessons" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Content" runat="server">
    <script type="text/javascript" src="../Scripts/jquery.dragsort-0.5.2.min.js"></script>


    <script>
        function OnEndCallback(s, e) {
            if (s.cpAlert != '' && (typeof s.cpAlert !== 'undefined')) {
                alert(s.cpAlert);
            }
        }
        function FilterOnEndCallback(s, e) {
            if (s.cpAlert != '' && (typeof s.cpAlert !== 'undefined')) {
                if (s.cpAlert == 'Thành công' || s.cpAlert == 'KHÔNG thành công') {
                    alert(s.cpAlert);
                }
                cpfilter.PerformCallback();
            }
        }
        function Edit(Id) {
            cp.PerformCallback('edit;' + Id);
            pcImport.Show();
        }
        function Del(Id) {
            if (confirm("Bạn chắc chắn muốn xóa không?")) {
                cp.PerformCallback('delete;' + Id);
            }
        }
        function New() {
            cp.PerformCallback('new;0');
            pcImport.Show();
        }
        function Save() {
            cp.PerformCallback('save;0');
            pcImport.Hide();
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
    </style>
    <dx:ASPxCallbackPanel ID="ASPxCallbackPanel3" runat="server" Width="100%"
        ClientInstanceName="cpfilter" OnCallback="ASPxCallbackPanel3_Callback">
        <ClientSideEvents EndCallback="FilterOnEndCallback" />
        <PanelCollection>
            <dx:PanelContent runat="server">
                <div class="container">
                    <div class="row">
                        <div class="col-md-12 marginTop20">
                            <dx:ASPxFormLayout ID="AddCommentFormLayout" runat="server" UseDefaultPaddings="false">
                                <SettingsItems Width="100%" />
                                <SettingsItemCaptions Location="Top" />
                                <Items>
                                    <dx:LayoutGroup Caption="Courses" ColCount="6">
                                        <Items>
                                            <dx:LayoutItem ShowCaption="False">
                                                <LayoutItemNestedControlCollection>
                                                    <dx:LayoutItemNestedControlContainer>
                                                        <div class="row">
                                                            <div class="col-lg-3">
                                                                <label>Tên bài học</label>
                                                                <dx:ASPxButtonEdit runat="server" ID="txtname" Width="100%" ClientInstanceName="txtname">
                                                                    <ClearButton DisplayMode="OnHover"></ClearButton>
                                                                </dx:ASPxButtonEdit>
                                                            </div>
                                                            <div class="col-lg-3">
                                                                <label>Product</label>
                                                                <dx:ASPxComboBox runat="server" ID="cbCategories" Width="100%" ClientInstanceName="cbCategories" DropDownStyle="DropDownList"
                                                                    EnableCallbackMode="true" CallbackPageSize="10">
                                                                    <Items>
                                                                        <dx:ListEditItem Text="All" Value="0" />
                                                                        <dx:ListEditItem Text="REF" Value="1" />
                                                                        <dx:ListEditItem Text="WM" Value="2" />
                                                                        <dx:ListEditItem Text="VC" Value="3" />
                                                                        <dx:ListEditItem Text="RC" Value="4" />
                                                                        <dx:ListEditItem Text="AP" Value="5" />
                                                                    </Items>
                                                                    <ClearButton DisplayMode="OnHover"></ClearButton>
                                                                </dx:ASPxComboBox>
                                                            </div>
                                                            <div class="col-lg-6">
                                                                <label style="color: white">Tool</label><br />
                                                                <dx:ASPxButton ID="btFilter" AutoPostBack="false" runat="server" CssClass="btn btn-primary" Text="Tìm kiếm">
                                                                    <ClientSideEvents Click="function(s, e) {  cp.PerformCallback('filter;'+lbSelected.GetText()); }"></ClientSideEvents>
                                                                </dx:ASPxButton>
                                                                <dx:ASPxButton ID="btCreateNew" AutoPostBack="false" runat="server" Text="Thêm mới" CssClass="btn btn-warning">
                                                                    <ClientSideEvents Click="function(s, e) { New(); }"></ClientSideEvents>
                                                                </dx:ASPxButton>
                                                                <dx:ASPxButton ID="btSort" AutoPostBack="false" runat="server" Text="Sắp xếp" CssClass="btn btn-danger">
                                                                    <ClientSideEvents Click="function(s, e) { pcSort.Show(); }"></ClientSideEvents>
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
                                    <dx:ASPxGridView runat="server" AutoGenerateColumns="False" ID="gvLessions" ClientInstanceName="gvLessions" Width="100%"
                                        KeyFieldName="LessonId">
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
                                            <dx:GridViewDataTextColumn FieldName="CourseName" Width="420px" Caption="Tên bài học" VisibleIndex="1">
                                                <EditFormSettings VisibleIndex="0" />
                                            </dx:GridViewDataTextColumn>
                                            <dx:GridViewDataTextColumn FieldName="LBNo" Width="200px" Caption="Tổng số Slide" VisibleIndex="2">
                                                <EditFormSettings Visible="False" />
                                                <CellStyle VerticalAlign="Middle" HorizontalAlign="Center"></CellStyle>
                                            </dx:GridViewDataTextColumn>
                                            <dx:GridViewDataColumn VisibleIndex="4" Caption=" " Width="400px">
                                                <CellStyle HorizontalAlign="Center"></CellStyle>
                                                <DataItemTemplate>
                                                    <a style="cursor: pointer" href='<%# "/Pages/LessonDetail.aspx?Id=" + Eval("Id") %>'>Slide</a>
                                                    <a href='<%# "/Pages/LessonCourse.aspx?Id=" + Eval("Id") %>' style="padding: 0 10px; cursor: pointer; padding-right: 0">Course</a>
                                                    <a onclick='<%# "Edit(" +Eval("Id") +")" %>' style="padding: 0 10px; cursor: pointer">Edit</a>
                                                    <a onclick='<%# "Del(" +Eval("Id") +")" %>' style="cursor: pointer">Delete</a>
                                                </DataItemTemplate>
                                            </dx:GridViewDataColumn>
                                        </Columns>
                                        <Settings HorizontalScrollBarMode="Visible" VerticalScrollBarStyle="Standard" VerticalScrollableHeight="370" VerticalScrollBarMode="Visible" />
                                        <SettingsBehavior AllowSort="true" ColumnResizeMode="Control" />
                                        <Styles>
                                            <Header HorizontalAlign="Center" Wrap="True" Paddings-Padding="3px"></Header>
                                            <Cell Wrap="True" VerticalAlign="Middle" Paddings-Padding="5px"></Cell>
                                        </Styles>
                                        <SettingsPager PageSize="12"></SettingsPager>
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
        HeaderText="Lesson" AllowDragging="True" PopupAnimationType="None" EnableViewState="False" AutoUpdatePosition="true">
        <ContentCollection>
            <dx:PopupControlContentControl runat="server">
                <dx:ASPxPanel ID="Panel1" runat="server" DefaultButton="btOK">
                    <PanelCollection>
                        <dx:PanelContent runat="server">
                            <dx:ASPxCallbackPanel ID="ASPxCallbackPanel1" runat="server" Width="100%"
                                ClientInstanceName="cp" OnCallback="ASPxCallbackPanel1_Callback">
                                <ClientSideEvents EndCallback="FilterOnEndCallback" />
                                <PanelCollection>
                                    <dx:PanelContent runat="server">
                                        <dx:ASPxFormLayout runat="server" ID="ASPxFormLayout1" Width="100%" Height="100%">
                                            <Items>
                                                <dx:LayoutItem Caption="Hitachi">
                                                    <LayoutItemNestedControlCollection>
                                                        <dx:LayoutItemNestedControlContainer>
                                                            <dx:ASPxCheckBox runat="server" ID="ckHitachi"></dx:ASPxCheckBox>
                                                        </dx:LayoutItemNestedControlContainer>
                                                    </LayoutItemNestedControlCollection>
                                                </dx:LayoutItem>
                                                <dx:LayoutItem Caption="Lesson Name">
                                                    <LayoutItemNestedControlCollection>
                                                        <dx:LayoutItemNestedControlContainer>
                                                            <dx:ASPxButtonEdit runat="server" Width="100%" ID="txtnameedit" ClientInstanceName="txtnameedit">
                                                                <ClearButton DisplayMode="OnHover"></ClearButton>
                                                            </dx:ASPxButtonEdit>
                                                        </dx:LayoutItemNestedControlContainer>
                                                    </LayoutItemNestedControlCollection>
                                                </dx:LayoutItem>
                                                <dx:LayoutItem Caption="Product">
                                                    <LayoutItemNestedControlCollection>
                                                        <dx:LayoutItemNestedControlContainer>
                                                            <dx:ASPxComboBox runat="server" ID="cbCategoriesedit" ClientInstanceName="cbCategoriesedit" DropDownStyle="DropDownList"
                                                                EnableCallbackMode="true" CallbackPageSize="10">
                                                                <Items>
                                                                    <dx:ListEditItem Text="All" Value="0" />
                                                                    <dx:ListEditItem Text="REF" Value="1" />
                                                                    <dx:ListEditItem Text="WM" Value="2" />
                                                                    <dx:ListEditItem Text="VC" Value="3" />
                                                                    <dx:ListEditItem Text="RC" Value="4" />
                                                                    <dx:ListEditItem Text="AP" Value="5" />
                                                                </Items>
                                                                <ClearButton DisplayMode="OnHover"></ClearButton>
                                                            </dx:ASPxComboBox>
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
    <dx:ASPxPopupControl ID="pcSort" runat="server" Width="700" CloseAction="CloseButton" CloseOnEscape="true" Modal="True"
        PopupHorizontalAlign="WindowCenter" PopupVerticalAlign="WindowCenter" ClientInstanceName="pcSort"
        HeaderText="Lesson" AllowDragging="True" PopupAnimationType="None" EnableViewState="False" AutoUpdatePosition="true">
        <ContentCollection>
            <dx:PopupControlContentControl runat="server">
                <dx:ASPxPanel ID="ASPxPanel1" runat="server">
                    <PanelCollection>
                        <dx:PanelContent runat="server">
                            <dx:ASPxCallbackPanel ID="ASPxCallbackPanel2" runat="server" Width="100%"
                                ClientInstanceName="cp2" OnCallback="ASPxCallbackPanel2_Callback">
                                <ClientSideEvents EndCallback="FilterOnEndCallback" />
                                <PanelCollection>
                                    <dx:PanelContent runat="server">
                                        <ul id="gallery" style="padding: 0;">
                                            <asp:Repeater ID="rptGallery" runat="server">
                                                <ItemTemplate>
                                                    <li data-itemid='<%# Eval("Id") %>' class="col-md-3" style="position: relative">
                                                        <div class="thumbnail">
                                                            <i style="position: absolute; left: 3px; top: 0; color: blueviolet"><%# Container.ItemIndex+1 %></i>
                                                            <a><%# Eval("CourseName") %></a>
                                                        </div>
                                                    </li>
                                                </ItemTemplate>
                                            </asp:Repeater>
                                        </ul>
                                        <script type="text/javascript">
                                            $("#gallery").dragsort({ dragSelector: "li", dragEnd: saveOrder, placeHolderTemplate: "<li class='col-md-2 img' style='float:left; margin-bottom: 10px'><div></div></li>" });

                                            function saveOrder() {
                                                var data = $("#gallery li").map(function () { return $(this).data("itemid"); }).get();
                                                cp2.PerformCallback('sort_' + data.join('_'));
                                                pcSort.Hide();
                                            };
                                        </script>
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
    <asp:HiddenField runat="server" ID="hfLessionId" />
</asp:Content>
