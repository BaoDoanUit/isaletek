<%@ Page Title="Events Slide" Language="C#" MasterPageFile="~/Layout.master"
    AutoEventWireup="true"
    CodeBehind="EventsSlide.aspx.cs" Inherits="WebApplication.Pages.EventsSlide" %>

<%@ Register TagPrefix="dx" Namespace="DevExpress.Web" Assembly="DevExpress.Web.v17.1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="Content" runat="server">
    <script src="../Scripts/jquery.dragsort-0.5.2.min.js"></script>
    <script type="text/javascript">
        function OnEndCallback(s, e) {
            if (s.cpAlert != null && s.cpAlert != "") {
                aspxCallback.PerformCallback('filter');
                alert(s.cpAlert);
                if (s.cpAlert === "Lưu thành công!") {
                    popupClient.Hide();
                }
            }
            SaveImageName();
            enableSortList();
        }
        function openpopup() {
            popupClient.Show();
        }
        function deleteSlide(id) {
            if (confirm("Bạn có chắc chắn muốn slide này không?")) {
                aspxCallback.PerformCallback('delete_' + id);
            }
        }
        function delMulti() {

        }
        function onFileUploadComplete(s, e) {
            if (e.callbackData) {
                if (e.callbackData != null && e.callbackData != "")
                    alert(e.callbackData);
                if (e.callbackData === "Lưu thành công!") {
                    aspxCallback.PerformCallback("filter");
                    popupClient.Hide();
                }
            }
            enableSortList();
        }
        function enableSortList() {
            $("#gallery").dragsort({ dragSelector: "li", dragEnd: saveOrder, placeHolderTemplate: "<li><div></div></li>" });
        }
        function ActiveTabChange() {
            aspxCallback.PerformCallback("filter");
        }

       
    </script>
    <script>
        $(document).ready(function () {
            SaveImageName();
        });

        function SaveImageName() {
            $('input.edit').change(function () {
                console.log('error');
                var arr = { Id: $(this).attr('editid'), value: $(this).val() };
                console.log(arr.Id);
                console.log(arr.value);
                $.ajax({
                    type: "POST",
                    url: "/Pages/FunctionArticleService.asmx/SaveImageName",
                    data: JSON.stringify(arr),
                    dataType: "json",
                    contentType: "application/json;charset=utf-8",
                    success: function (data) {

                    }
                })

            })
        }
    </script>
    <style type="text/css">
        input[type=text], select {
            width: 100%;
            padding: 12px 20px;
            margin: 8px 0;
            display: inline-block;
            border: 1px solid #ccc;
            border-radius: 4px;
            box-sizing: border-box;
        }

        .dxpc-headerContent {
            line-height: 10px !important;
            background-color: transparent !important;
        }

        .img-slide {
            max-width: 220px;
            max-height: 130px;
            margin-bottom: 10px
        }

        #gallery, #listgallery {
            float: left;
            width: 100%;
            padding: 0
        }

            #gallery li, #listgallery li {
                float: left;
                width: 25%;
                list-style: none
            }

        .ckdelmulti {
            width: 7% !important;
            margin-top: 5px
        }

        .dxpc-headerContent {
            line-height: 10px !important;
            background-color: transparent !important;
        }

        .img-responsive {
            max-width: 220px;
            height: auto;
            margin-bottom: 10px
        }

        #gallery, #listgallery {
            float: left;
            width: 100%;
            padding: 0
        }

            #gallery li, #listgallery li {
                float: left;
                width: 25%;
                list-style: none
            }

        strong.title-course > a {
            display: block;
            color: #0C4CA2;
            display: block;
            overflow: hidden;
            white-space: nowrap;
            text-overflow: ellipsis;
            font-size: 13px;
        }

            strong.title-course > a .no-course, .topic-detail h1 .no-course {
                background: #23539e;
                color: #fff;
                border-radius: 50%;
                width: 20px;
                height: 20px;
                display: inline-block;
                text-align: center;
                font-size: 11px;
                line-height: 20px;
                margin-right: 6px;
            }

        .ckdelmulti {
            width: 7% !important;
            margin-top: 5px
        }
    </style>
    <div class="row">
        <div class="col-md-12">
            <dx:ASPxPageControl ID="TabPage" ClientInstanceName="aspxCallback" OnCallback="aspxCallback_Callback" Width="100%" runat="server" CssClass="dxtcFixed"
                ActiveTabIndex="0" EnableHierarchyRecreation="True">
                <ClientSideEvents EndCallback="OnEndCallback" ActiveTabChanged="ActiveTabChange" />
                <TabPages>
                    <dx:TabPage Text="Edit">
                        <ContentCollection>
                            <dx:ContentControl>
                                <div class="col-md-12 text-center">
                                    <a onclick="openpopup()" style="cursor: pointer"><i class="fa fa-plus-circle"></i>&nbsp; Add</a>
                                </div>
                                <ul id="listgallery">
                                    <asp:Repeater ID="rplistGallery" runat="server" OnItemDataBound="rplistGallery_ItemDataBound">
                                        <ItemTemplate>
                                            <li class="col-md-3" data-itemid='<%# Eval("Id") %>' style="padding: 5px; position: relative; height: auto">
                                                <div class="element slide" style="float: left; position: relative; height: auto; padding: 5px; padding-bottom: 8px; list-style: none;">
                                                    <div style="width: 220px; height: 130px">
                                                        <asp:Literal runat="server" ID="ltrSlide" Text='<%#Eval("ImagePath") %>'></asp:Literal>
                                                    </div>
                                                    <div style="width: 220px; height: 20px">
                                                        <a href="javascript:void(0)" onclick="javascript: deleteSlide('<%# Eval("Id") %>');" title="Xóa"
                                                            style="width: 40px; height: auto; color: red; position: inherit; bottom: 10px; right: 10px;">[Delete]</a>
                                                    </div>
                                                    <div style="width: 220px; height: 60px">
                                                        <asp:TextBox ID="tbImageName" editid='<%#Eval("Id") %>' CssClass="edit" runat="server" Text='<%#Eval("ImageName") %>'></asp:TextBox>
                                                    </div>
                                                    <asp:CheckBox ID="ckcheck" Visible="false" CssClass="ckdelmulti" ToolTip='<%# Eval("Id") %>' runat="server" />
                                                    <asp:HiddenField ID="hfid" Value='<%# Eval("Id") %>' runat="server" />
                                                    <strong class="title-course" style="left: 0px; top: 0px; position: absolute">
                                                        <a>
                                                            <b class="no-course"><%# Container.ItemIndex+1 %></b>
                                                        </a>
                                                    </strong>
                                                </div>
                                            </li>
                                        </ItemTemplate>
                                    </asp:Repeater>
                                </ul>
                            </dx:ContentControl>
                        </ContentCollection>
                    </dx:TabPage>
                    <dx:TabPage Text="Sort">
                        <ContentCollection>
                            <dx:ContentControl>
                                <ul id="gallery">
                                    <asp:Repeater ID="rptGallery" runat="server" OnItemDataBound="rptGallery_ItemDataBound">
                                        <ItemTemplate>
                                            <li class="col-md-3" data-itemid='<%# Eval("Id") %>' style="padding: 5px; position: relative; height: auto;">
                                                <div class="element slide" style="float: left; padding: 5px; height: auto; list-style: none;">
                                                    <div style="width: 220px; height: 130px">
                                                        <asp:Literal runat="server" ID="ltrSlide" Text='<%#Eval("ImagePath") %>'></asp:Literal>
                                                    </div>
                                                    <div style="width: 220px; height: 60px">
                                                        <asp:Label ID="tbImageName" runat="server" Text='<%#Eval("ImageName") %>'></asp:Label>
                                                    </div>
                                                    <strong class="title-course" style="left: 3px; top: 3px; position: absolute">
                                                        <a>
                                                            <b class="no-course"><%# Container.ItemIndex+1 %></b>
                                                        </a>
                                                    </strong>
                                                </div>
                                            </li>
                                        </ItemTemplate>
                                    </asp:Repeater>
                                </ul>
                                <script type="text/javascript">
                                    $("#gallery").dragsort({ dragSelector: "li", dragEnd: saveOrder, placeHolderTemplate: "<li class='col-md-3 img' style='float:left; margin-bottom: 10px'><div></div></li>" });
                                    function saveOrder() {
                                        var data = $("#gallery li").map(function () { return $(this).data("itemid"); }).get();
                                        aspxCallback.PerformCallback('sort_' + data.join('_'));
                                    };
                                </script>
                            </dx:ContentControl>
                        </ContentCollection>
                    </dx:TabPage>
                </TabPages>
            </dx:ASPxPageControl>
        </div>
    </div>
    <dx:ASPxPopupControl ID="popup" ClientInstanceName="popupClient" runat="server" Width="700px"
        CloseAction="CloseButton" CloseOnEscape="true" Modal="True" AllowDragging="True" PopupAnimationType="None" EnableViewState="False" AutoUpdatePosition="true"
        PopupHorizontalAlign="WindowCenter" PopupVerticalAlign="WindowCenter" HeaderText="Add Slide">
        <ContentCollection>
            <dx:PopupControlContentControl ID="PopupControlContentControl3" runat="server">
                <dx:ASPxPageControl runat="server" ID="pageControl" Width="100%" EnableCallBacks="true">
                    <TabPages>
                        <dx:TabPage Text="Images" Visible="true">
                            <ContentCollection>
                                <dx:ContentControl runat="server">
                                    <dx:ASPxCallbackPanel ID="slideCallback" runat="server" Width="100%"
                                        Style="position: relative"
                                        ClientInstanceName="slideCallback">
                                        <ClientSideEvents EndCallback="OnEndCallback"></ClientSideEvents>
                                        <PanelCollection>
                                            <dx:PanelContent runat="server">
                                                <dx:ASPxFormLayout runat="server" ID="ASPxFormLayout3" CssClass="formLayout">
                                                    <SettingsAdaptivity AdaptivityMode="SingleColumnWindowLimit" SwitchToSingleColumnAtWindowInnerWidth="500" />
                                                    <Items>
                                                        <dx:LayoutItem ShowCaption="False" Width="100%">
                                                            <LayoutItemNestedControlCollection>
                                                                <dx:LayoutItemNestedControlContainer>
                                                                    <dx:ASPxUploadControl ID="upImages" runat="server" ClientInstanceName="upImages" Width="100%" UploadButton-ImagePosition="Bottom"
                                                                        NullText="Choose Images (.jpe, .jpeg, .jpg, .gif, .png)..." UploadMode="Advanced" ShowProgressPanel="True"
                                                                        OnFileUploadComplete="upImages_FileUploadComplete" FileUploadMode="OnPageLoad">
                                                                        <ValidationSettings AllowedFileExtensions=".jpe, .jpeg, .jpg, .gif, .png"></ValidationSettings>
                                                                        <AdvancedModeSettings EnableMultiSelect="True" EnableFileList="True" EnableDragAndDrop="false" />
                                                                        <ClientSideEvents FileUploadComplete="onFileUploadComplete" />
                                                                    </dx:ASPxUploadControl>
                                                                </dx:LayoutItemNestedControlContainer>
                                                            </LayoutItemNestedControlCollection>
                                                        </dx:LayoutItem>
                                                        <dx:LayoutItem ShowCaption="False" HorizontalAlign="Right" Width="100%">
                                                            <LayoutItemNestedControlCollection>
                                                                <dx:LayoutItemNestedControlContainer>
                                                                    <dx:ASPxButton ID="bSubmit2" runat="server" Text="Submit" CssClass="btn btn-purple" AutoPostBack="false">
                                                                        <ClientSideEvents Click="function(s,e){upImages.Upload();}" />
                                                                    </dx:ASPxButton>
                                                                </dx:LayoutItemNestedControlContainer>
                                                            </LayoutItemNestedControlCollection>
                                                        </dx:LayoutItem>
                                                    </Items>
                                                </dx:ASPxFormLayout>
                                            </dx:PanelContent>
                                        </PanelCollection>
                                    </dx:ASPxCallbackPanel>
                                </dx:ContentControl>
                            </ContentCollection>
                        </dx:TabPage>
                    </TabPages>
                </dx:ASPxPageControl>
            </dx:PopupControlContentControl>
        </ContentCollection>
    </dx:ASPxPopupControl>
</asp:Content>
