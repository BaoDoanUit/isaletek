<%@ Page Title="Lesson Detail" Language="C#" 
    MasterPageFile="~/Layout.master" 
    AutoEventWireup="true" CodeBehind="LessonDetail.aspx.cs" 
    Inherits="WebApplication.Pages.LessonDetail" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Content" runat="server">
 
    <script src="../Scripts/jquery.dragsort-0.5.2.js"></script>
    <script>
        function OnEndCallback(s, e) {
            if (s.cpAlert != null && s.cpAlert != "") {
                if (s.cpAlert != null && s.cpAlert != "") {
                    cp.PerformCallback("filter");
                    pcImport.Hide();
                    pcQuestion.Hide();
                }
                if (s.cpAlert === "Lưu thành công!") {
                    alert(s.cpAlert);
                }
            }
            $("#gallery").dragsort({ dragSelector: "li", dragEnd: saveOrder, placeHolderTemplate: "<li class='col-md-2 img'  style='float:left; margin-bottom: 10px'><div></div></li>" });
        }
        function onFileUploadComplete(s, e) {
            if (e.callbackData) {
                if (e.callbackData != null && e.callbackData != "")
                {
                    cp.PerformCallback("filter");
                    pcImport.Hide();
                    pcQuestion.Hide();
                }
                if (e.callbackData === "Lưu thành công!") {
                    alert(e.callbackData);
                }
            }
            $("#gallery").dragsort({ dragSelector: "li", dragEnd: saveOrder, placeHolderTemplate: "<li class='col-md-2 img'  style='float:left; margin-bottom: 10px'><div></div></li>" });

        }
        function deleteBank(id) {
            if (confirm("Bạn có muốn xóa không?")) {
                cp.PerformCallback('delQuestion_' + id);
            }
        }
        function deleteSlide(slideID) {
            if (confirm('Bạn có muốn xóa không?')) {
                cp.PerformCallback('delSlide_' + slideID);
                $('#gallery').find('li[data-itemid="' + slideID + '"]').remove();
            }
        }
        function openpopup() {
            pcImport.Show();
        }
        function openpopup2() {
            popupClient2.Show();
        }
        function openquestion() {
            pcQuestion.Show();
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
        .tab-custom{
            text-align: center;
        }
        .tab-custom a{
            margin: 0 10px;
    border: 1px solid #ddd;
    padding: 5px 10px;
    border-radius: 5px;
        }
        .tab-custom-active{
            background-color: orange;
            color:#fff
        }
        .tab-custom a:hover{
            text-decoration: underline;
            color:#FFF;
            cursor:pointer;
            background-color: orange;
        }
        #Content_ASPxCallbackPanel1_lbname{
            font-size: 16px;
    padding-left: 30px;
    margin-top: 10px;
    display: block;
    margin-bottom: 0;
    padding-bottom: 0;
    font-weight: 600;
        }
    </style>
    <script>
        function openInfo() {
            $('#info').show();
            $('#sort').hide();
            $('#question').hide();
            $('#tabInfo').addClass('tab-custom-active');
            $('#tabCondition').removeClass('tab-custom-active');
            $('#tabSort').removeClass('tab-custom-active');
        }
        function openQuestion() {
            $('#info').hide();
            $('#sort').hide();
            $('#question').show();
            $('#tabInfo').removeClass('tab-custom-active');
            $('#tabSort').removeClass('tab-custom-active');
            $('#tabCondition').addClass('tab-custom-active');
        }
        function openSort() {
            $('#info').hide();
            $('#sort').show();
            $('#question').hide();
            $('#tabInfo').removeClass('tab-custom-active');
            $('#tabSort').addClass('tab-custom-active');
            $('#tabCondition').removeClass('tab-custom-active');
        }
    </script>
    <dx:ASPxCallbackPanel ID="ASPxCallbackPanel1" runat="server" Width="100%"
        ClientInstanceName="cp" OnCallback="ASPxCallbackPanel1_Callback">
        <ClientSideEvents EndCallback="OnEndCallback" />
        <PanelCollection>
            <dx:PanelContent runat="server">
                <div class="container">
                    <asp:Label ID="lbname" runat="server" Text="Label"></asp:Label>
                    <dx:ASPxFormLayout runat="server" ID="formLayout" CssClass="formLayout">
                        <SettingsAdaptivity AdaptivityMode="SingleColumnWindowLimit" SwitchToSingleColumnAtWindowInnerWidth="384" />
                        <Items>
                            <dx:LayoutGroup ShowCaption="False" UseDefaultPaddings="false">
                                <Items>
                                    <dx:LayoutItem Caption="" ShowCaption="False" Width="100%">
                                        <LayoutItemNestedControlCollection>
                                            <dx:LayoutItemNestedControlContainer>
                                                <div class="col-md-12 tab-custom">
                                                    <a onclick="javascript: openSort();" class="tab-custom tab-custom-active" id="tabSort">Sắp xếp</a>
                                                    <a onclick="javascript: openInfo();" class="tab-custom" id="tabInfo">Slide/Video</a>
                                                    <a onclick="javascript: openQuestion();" class="tab-custom" id="tabCondition">Câu hỏi</a>
                                                </div>
                                                <div class="col-md-12" id="info" style="padding: 0px; display:none">
                                                    <a onclick="openpopup()" class="btn btn-blue"><i class="fa fa-plus-circle"></i>&nbsp; Thêm&nbsp;  </a>
                                                    <div style="clear: both; height: 20px"></div>
                                                    <ul id="galleryDel" style="padding: 0;">
                                                        <asp:Repeater ID="rptGalleryDel" runat="server" OnItemDataBound="rptGalleryDel_ItemDataBound">
                                                            <ItemTemplate>
                                                                <li data-itemid='<%# Eval("slide_Id") %>' class="col-md-2" style="position: relative">
                                                                    <a style="position: absolute; font-weight: bold; color: red; right: 20px; height: 12px; margin: -3px 1px 0 0; width: 12px;" href="javascript:void(0)" onclick="deleteSlide('<%# Eval("slide_Id") %>');" title="Xóa">[X]</a>
                                                                    <div class="thumbnail">
                                                                        <asp:Literal runat="server" ID="ltrSlide" Text='<%#Eval("IsVideo") +";"+Eval("SlideContent") %>'></asp:Literal>
                                                                    </div>
                                                                </li>
                                                            </ItemTemplate>
                                                        </asp:Repeater>
                                                    </ul>
                                                </div>
                                                <div class="col-md-12" id="sort" style="padding: 0px; padding-top: 25px">
                                                    <ul id="gallery" style="padding: 0;">
                                                        <asp:Repeater ID="rptGallery" runat="server" OnItemDataBound="rptGallery_ItemDataBound">
                                                            <ItemTemplate>
                                                                <li data-itemid='<%# Eval("slide_Id") %>' class="col-md-2" style="position: relative">
                                                                    <div class="thumbnail">
                                                                        <asp:Literal runat="server" ID="ltrSlide" Text='<%#Eval("IsVideo") +";"+Eval("SlideContent") %>'></asp:Literal>
                                                                    </div>
                                                                </li>
                                                            </ItemTemplate>
                                                        </asp:Repeater>
                                                    </ul>
                                                    <script type="text/javascript">
                                                        $("#gallery").dragsort({ dragSelector: "li", dragEnd: saveOrder, placeHolderTemplate: "<li class='col-md-2 img' style='float:left; margin-bottom: 10px'><div></div></li>" });

                                                        function saveOrder() {
                                                            var data = $("#gallery li").map(function () { return $(this).data("itemid"); }).get();
                                                            cp.PerformCallback('sort_' + data.join('_'));
                                                        };
                                                    </script>
                                                </div>
                                                <div class="col-md-12" id="question" style="padding: 0px; display: none">
                                                    <a onclick="openquestion()" class="btn btn-blue"><i class="fa fa-plus-circle"></i>&nbsp; Thêm&nbsp;  </a>
                                                    <a class="btn btn-blue" href="/Content/template/template_questions.xlsx" target="_blank">&nbsp; Template&nbsp; </a>
                                                    <dx:ASPxGridView runat="server" Width="100%" ID="gvQuestion" ClientInstanceName="gvQuestion"
                                                        AutoGenerateColumns="False">
                                                        <Settings VerticalScrollBarMode="Visible" VerticalScrollableHeight="400" />
                                                        <Columns>
                                                            <dx:GridViewDataTextColumn Caption="#" Width="50" VisibleIndex="0">
                                                                <DataItemTemplate>
                                                                    <%# Container.ItemIndex + 1%>
                                                                </DataItemTemplate>
                                                            </dx:GridViewDataTextColumn>
                                                            <dx:GridViewDataColumn FieldName="QuestionName" Caption="Nội dung câu hỏi" VisibleIndex="1" />
                                                            <dx:GridViewDataColumn FieldName="ansTrue" Caption="Câu trả lời đúng" VisibleIndex="2" Width="100px">
                                                                <CellStyle HorizontalAlign="Center"></CellStyle>
                                                            </dx:GridViewDataColumn>
                                                            <dx:GridViewDataColumn FieldName="ansA" Caption="Câu trả lời A" VisibleIndex="3" />
                                                            <dx:GridViewDataColumn FieldName="ansB" Caption="Câu trả lời B" VisibleIndex="4" />
                                                            <dx:GridViewDataColumn FieldName="ansC" Caption="Câu trả lời C" VisibleIndex="5" />
                                                            <dx:GridViewDataColumn FieldName="ansD" Caption="Câu trả lời D" VisibleIndex="6" />
                                                            <dx:GridViewDataColumn FieldName="ansE" Caption="Câu trả lời E" VisibleIndex="7" />
                                                            <dx:GridViewDataColumn FieldName="ansF" Caption="Câu trả lời F" VisibleIndex="8" />
                                                            <dx:GridViewDataTextColumn Caption="#" Width="50" VisibleIndex="9">
                                                                <DataItemTemplate>
                                                                    <a onclick='<%# "deleteBank(" +Eval("QuestionId") +")" %>' style="cursor: pointer">Delete</a>
                                                                </DataItemTemplate>
                                                            </dx:GridViewDataTextColumn>
                                                        </Columns>
                                                        <Styles>
                                                            <Header Wrap="True" VerticalAlign="Middle" HorizontalAlign="Center"></Header>
                                                            <AlternatingRow Enabled="true" />
                                                        </Styles>
                                                        <Settings ShowFilterRow="false" />
                                                        <SettingsBehavior AllowFocusedRow="false" AllowHeaderFilter="true" FilterRowMode="Auto" />
                                                        <SettingsPager PageSize="40" NumericButtonCount="6" />
                                                    </dx:ASPxGridView>
                                                </div>
                                            </dx:LayoutItemNestedControlContainer>
                                        </LayoutItemNestedControlCollection>
                                    </dx:LayoutItem>
                                </Items>
                            </dx:LayoutGroup>
                        </Items>
                    </dx:ASPxFormLayout>
                </div>
            </dx:PanelContent>
        </PanelCollection>
    </dx:ASPxCallbackPanel>
    <dx:ASPxPopupControl ID="pcImport" runat="server" Width="600" CloseAction="CloseButton" CloseOnEscape="true" Modal="True"
        PopupHorizontalAlign="WindowCenter" PopupVerticalAlign="WindowCenter" ClientInstanceName="pcImport"
        HeaderText="Chọn file để Import" AllowDragging="True" PopupAnimationType="None" EnableViewState="False" AutoUpdatePosition="true">
        <ContentCollection>
            <dx:PopupControlContentControl ID="PopupControlContentControl3" runat="server">
                <dx:ASPxFormLayout runat="server" ID="ASPxFormLayout2" CssClass="formLayout">
                    <SettingsAdaptivity AdaptivityMode="SingleColumnWindowLimit" SwitchToSingleColumnAtWindowInnerWidth="500" />
                    <Items>
                        <dx:LayoutItem Caption="Slide/Video bài học" ShowCaption="False" Width="100%">
                            <LayoutItemNestedControlCollection>
                                <dx:LayoutItemNestedControlContainer>
                                    <dx:ASPxUploadControl ID="upImages" runat="server" ClientInstanceName="upImages" Width="100%" UploadButton-ImagePosition="Bottom"
                                        NullText="Chọn hình/video (.jpe, .jpeg, .jpg, .gif, .png, .mp4)..." UploadMode="Advanced" ShowProgressPanel="True"
                                        OnFileUploadComplete="upImages_FileUploadComplete" FileUploadMode="OnPageLoad">
                                        <ValidationSettings AllowedFileExtensions=".jpe, .jpeg, .jpg, .gif, .png, .mp4"></ValidationSettings>
                                        <AdvancedModeSettings EnableMultiSelect="True" EnableFileList="True" EnableDragAndDrop="false" />
                                        <ClientSideEvents FileUploadComplete="onFileUploadComplete" />
                                    </dx:ASPxUploadControl>
                                </dx:LayoutItemNestedControlContainer>
                            </LayoutItemNestedControlCollection>
                        </dx:LayoutItem>
                        <dx:LayoutItem ShowCaption="False" HorizontalAlign="Right" Width="100%">
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
            </dx:PopupControlContentControl>
        </ContentCollection>
    </dx:ASPxPopupControl>
    <dx:ASPxPopupControl ID="pcQuestion" runat="server" Width="600" CloseAction="CloseButton" CloseOnEscape="true" Modal="True"
        PopupHorizontalAlign="WindowCenter" PopupVerticalAlign="WindowCenter" ClientInstanceName="pcQuestion"
        HeaderText="Chọn file để Import" AllowDragging="True" PopupAnimationType="None" EnableViewState="False" AutoUpdatePosition="true">
        <ContentCollection>
            <dx:PopupControlContentControl ID="PopupControlContentControl1" runat="server">
                <dx:ASPxFormLayout runat="server" ID="ASPxFormLayout1" CssClass="formLayout">
                    <SettingsAdaptivity AdaptivityMode="SingleColumnWindowLimit" SwitchToSingleColumnAtWindowInnerWidth="500" />
                    <Items>
                        <dx:LayoutItem Caption="Slide/Video bài học" ShowCaption="False" Width="100%">
                            <LayoutItemNestedControlCollection>
                                <dx:LayoutItemNestedControlContainer>
                                    <dx:ASPxUploadControl ID="upQuestion" runat="server" ClientInstanceName="upQuestion" Width="100%" UploadButton-ImagePosition="Bottom"
                                        NullText="Chọn file (xlsx)..." UploadMode="Advanced" ShowProgressPanel="True"
                                        OnFileUploadComplete="upQuestion_FileUploadComplete" FileUploadMode="OnPageLoad">
                                        <ValidationSettings AllowedFileExtensions=".xlsx"></ValidationSettings>
                                        <AdvancedModeSettings EnableMultiSelect="True" EnableFileList="True" EnableDragAndDrop="false" />
                                        <ClientSideEvents FileUploadComplete="onFileUploadComplete" />
                                    </dx:ASPxUploadControl>
                                </dx:LayoutItemNestedControlContainer>
                            </LayoutItemNestedControlCollection>
                        </dx:LayoutItem>
                        <dx:LayoutItem ShowCaption="False" HorizontalAlign="Right" Width="100%">
                            <LayoutItemNestedControlCollection>
                                <dx:LayoutItemNestedControlContainer>
                                    <div class="row marginTop20">
                                        <div class="col-md-12 text-center">
                                            <dx:ASPxButton ID="btOKQ" runat="server" Text="Import" Width="80px" AutoPostBack="False" CssClass="btn btn-success">
                                                <ClientSideEvents Click="function(s, e) { upQuestion.Upload(); }" />
                                            </dx:ASPxButton>
                                            &nbsp;
                                            <dx:ASPxButton ID="btCancelQ" runat="server" Text="Cancel" Width="80px" AutoPostBack="False">
                                                <ClientSideEvents Click="function(s, e) { pcQuestion.Hide(); }" />
                                            </dx:ASPxButton>
                                        </div>
                                    </div>
                                </dx:LayoutItemNestedControlContainer>
                            </LayoutItemNestedControlCollection>
                        </dx:LayoutItem>
                    </Items>
                </dx:ASPxFormLayout>
            </dx:PopupControlContentControl>
        </ContentCollection>
    </dx:ASPxPopupControl>
    <dx:ASPxHiddenField ID="hdfKey" ClientInstanceName="hdfKey" runat="server"></dx:ASPxHiddenField>
</asp:Content>