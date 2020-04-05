<%@ Page Title="" Language="C#" MasterPageFile="~/Layout.master" 
    AutoEventWireup="true" CodeBehind="TestingDetail.aspx.cs" 
    Inherits="WebApplication.Pages.TestingDetail" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Content" runat="server">
    <script>
        function OnEndCallback(s, e) {
            if (s.cpAlert != null && s.cpAlert != "") {
                alert('Success');
                cp.PerformCallback("filter");
                pcQuestion.Hide();
            }
        }

        function EditEndCallback(s, e) {
            if (s.cpAlert != null && s.cpAlert != "") {
                cp.PerformCallback("filter");
                pcEdit.Hide();
            }
        }

        function onFileUploadComplete(s, e) {
            if (e.callbackData) {
                if (e.callbackData != null && e.callbackData != "") {
                    cp.PerformCallback("filter");
                    pcQuestion.Hide();
                }
                if (e.callbackData === "Lưu thành công!") {
                    alert(e.callbackData);
                }
            }
        }

        function deleteBank(id) {
            if (confirm("Bạn có muốn xóa không?")) {
                cp.PerformCallback('delQuestion_' + id);
            }
        }

        function editBank(id) {
            cpedit.PerformCallback('editQuestion_' + id);
            pcEdit.Show();
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

        .tab-custom {
            text-align: center;
        }

            .tab-custom a {
                margin: 0 10px;
                border: 1px solid #ddd;
                padding: 5px 10px;
                border-radius: 5px;
            }

        .tab-custom-active {
            background-color: orange;
            color: #fff
        }

        .tab-custom a:hover {
            text-decoration: underline;
            color: #FFF;
            cursor: pointer;
            background-color: orange;
        }

        #Content_ASPxCallbackPanel1_lbname {
            font-size: 16px;
            padding-left: 30px;
            margin-top: 10px;
            display: block;
            margin-bottom: 0;
            padding-bottom: 0;
            font-weight: 600;
        }
        .dxflGroup_Moderno{
            padding:0
        }
    </style>
    <dx:ASPxCallbackPanel ID="ASPxCallbackPanel1" runat="server" Width="100%"
        ClientInstanceName="cp" OnCallback="ASPxCallbackPanel1_Callback">
        <ClientSideEvents EndCallback="OnEndCallback" />
        <PanelCollection>
            <dx:PanelContent runat="server">
                <div class="">
                    <asp:Label ID="lbname" runat="server" Text="Label"></asp:Label>
                    <dx:ASPxFormLayout runat="server" ID="formLayout" CssClass="formLayout">
                        <SettingsAdaptivity AdaptivityMode="SingleColumnWindowLimit" SwitchToSingleColumnAtWindowInnerWidth="384" />
                        <Items>
                            <dx:LayoutGroup ShowCaption="False" UseDefaultPaddings="false">
                                <Items>
                                    <dx:LayoutItem Caption="" ShowCaption="False" Width="100%">
                                        <LayoutItemNestedControlCollection>
                                            <dx:LayoutItemNestedControlContainer>
                                                <div class="col-md-12" style="padding: 0px;">
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
                                                            <dx:GridViewDataColumn FieldName="ansTrue" Caption="Câu trả lời đúng" VisibleIndex="2" Width="80px">
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
                                                                    <a onclick='<%# "editBank(" +Eval("QuestionId") +")" %>' style="cursor: pointer">Edit</a>
                                                                    <br /><br /><a onclick='<%# "deleteBank(" +Eval("QuestionId") +")" %>' style="cursor: pointer">Delete</a>
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
    <dx:ASPxPopupControl ID="pcEdit" runat="server" Width="800" CloseAction="CloseButton" CloseOnEscape="true" Modal="True"
        PopupHorizontalAlign="WindowCenter" PopupVerticalAlign="WindowCenter" ClientInstanceName="pcEdit"
        HeaderText="Edit" AllowDragging="True" PopupAnimationType="None" EnableViewState="False" AutoUpdatePosition="true">
        <ContentCollection>
            <dx:PopupControlContentControl ID="PopupControlContentControl2" runat="server">
                <dx:ASPxCallbackPanel ID="ASPxCallbackPanel2" runat="server" Width="100%"
                    ClientInstanceName="cpedit" OnCallback="cpedit_Callback">
                    <ClientSideEvents EndCallback="EditEndCallback" />
                    <PanelCollection>
                        <dx:PanelContent runat="server">
                            <dx:ASPxFormLayout runat="server" ID="ASPxFormLayout2" CssClass="formLayout">
                                <SettingsAdaptivity AdaptivityMode="SingleColumnWindowLimit" SwitchToSingleColumnAtWindowInnerWidth="500" />
                                <Items>
                                    <dx:LayoutItem Caption="Câu hỏi" Width="100%">
                                        <LayoutItemNestedControlCollection>
                                            <dx:LayoutItemNestedControlContainer>
                                                <dx:ASPxButtonEdit runat="server" Width="100%" ID="txtname">
                                                    <ClearButton DisplayMode="OnHover"></ClearButton>
                                                </dx:ASPxButtonEdit>
                                            </dx:LayoutItemNestedControlContainer>
                                        </LayoutItemNestedControlCollection>
                                    </dx:LayoutItem>
                                    <dx:LayoutItem Caption="Đáp án dúng" Width="100%">
                                        <LayoutItemNestedControlCollection>
                                            <dx:LayoutItemNestedControlContainer>
                                                <dx:ASPxComboBox runat="server" ID="cbcorrect" EnableCallbackMode="true" DropDownStyle="DropDownList">
                                                    <ClearButton DisplayMode="OnHover"></ClearButton>
                                                    <Items>
                                                        <dx:ListEditItem Text="A" Value="A" />
                                                        <dx:ListEditItem Text="B" Value="B" />
                                                        <dx:ListEditItem Text="C" Value="C" />
                                                        <dx:ListEditItem Text="D" Value="D" />
                                                        <dx:ListEditItem Text="E" Value="E" />
                                                        <dx:ListEditItem Text="F" Value="F" />
                                                    </Items>
                                                </dx:ASPxComboBox>
                                            </dx:LayoutItemNestedControlContainer>
                                        </LayoutItemNestedControlCollection>
                                    </dx:LayoutItem>
                                    <dx:LayoutItem Caption="Đáp án A" Width="100%">
                                        <LayoutItemNestedControlCollection>
                                            <dx:LayoutItemNestedControlContainer>
                                                <dx:ASPxButtonEdit runat="server" Width="100%" ID="txta">
                                                    <ClearButton DisplayMode="OnHover"></ClearButton>
                                                </dx:ASPxButtonEdit>
                                            </dx:LayoutItemNestedControlContainer>
                                        </LayoutItemNestedControlCollection>
                                    </dx:LayoutItem>
                                    <dx:LayoutItem Caption="Đáp án B" Width="100%">
                                        <LayoutItemNestedControlCollection>
                                            <dx:LayoutItemNestedControlContainer>
                                                <dx:ASPxButtonEdit runat="server" Width="100%" ID="txtb">
                                                    <ClearButton DisplayMode="OnHover"></ClearButton>
                                                </dx:ASPxButtonEdit>
                                            </dx:LayoutItemNestedControlContainer>
                                        </LayoutItemNestedControlCollection>
                                    </dx:LayoutItem>
                                    <dx:LayoutItem Caption="Đáp án C" Width="100%">
                                        <LayoutItemNestedControlCollection>
                                            <dx:LayoutItemNestedControlContainer>
                                                <dx:ASPxButtonEdit runat="server" Width="100%" ID="txtc">
                                                    <ClearButton DisplayMode="OnHover"></ClearButton>
                                                </dx:ASPxButtonEdit>
                                            </dx:LayoutItemNestedControlContainer>
                                        </LayoutItemNestedControlCollection>
                                    </dx:LayoutItem>
                                    <dx:LayoutItem Caption="Đáp án D" Width="100%">
                                        <LayoutItemNestedControlCollection>
                                            <dx:LayoutItemNestedControlContainer>
                                                <dx:ASPxButtonEdit runat="server" Width="100%" ID="txtd">
                                                    <ClearButton DisplayMode="OnHover"></ClearButton>
                                                </dx:ASPxButtonEdit>
                                            </dx:LayoutItemNestedControlContainer>
                                        </LayoutItemNestedControlCollection>
                                    </dx:LayoutItem>
                                    <dx:LayoutItem Caption="Đáp án E" Width="100%">
                                        <LayoutItemNestedControlCollection>
                                            <dx:LayoutItemNestedControlContainer>
                                                <dx:ASPxButtonEdit runat="server" Width="100%" ID="txte">
                                                    <ClearButton DisplayMode="OnHover"></ClearButton>
                                                </dx:ASPxButtonEdit>
                                            </dx:LayoutItemNestedControlContainer>
                                        </LayoutItemNestedControlCollection>
                                    </dx:LayoutItem>
                                    <dx:LayoutItem Caption="Đáp án F" Width="100%">
                                        <LayoutItemNestedControlCollection>
                                            <dx:LayoutItemNestedControlContainer>
                                                <dx:ASPxButtonEdit runat="server" Width="100%" ID="txtf">
                                                    <ClearButton DisplayMode="OnHover"></ClearButton>
                                                </dx:ASPxButtonEdit>
                                            </dx:LayoutItemNestedControlContainer>
                                        </LayoutItemNestedControlCollection>
                                    </dx:LayoutItem>
                                    <dx:LayoutItem ShowCaption="False" HorizontalAlign="Right" Width="100%">
                                        <LayoutItemNestedControlCollection>
                                            <dx:LayoutItemNestedControlContainer>
                                                <div class="row marginTop20">
                                                    <div class="col-md-12 text-center">
                                                        <asp:Literal ID="ltrbSave" runat="server"></asp:Literal>
                                                        &nbsp;
                                                        <dx:ASPxButton ID="ASPxButton2" runat="server" Text="Cancel" Width="80px" AutoPostBack="False">
                                                            <ClientSideEvents Click="function(s, e) { pcEdit.Hide(); }" />
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
                </dx:ASPxCallbackPanel>
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
                        <dx:LayoutItem Caption="Câu hỏi" ShowCaption="False" Width="100%">
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
</asp:Content>