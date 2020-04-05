<%@ Page Title="Task Bank" Language="C#" MasterPageFile="~/Layout.master" AutoEventWireup="true" CodeBehind="TaskDetail.aspx.cs" Inherits="WebApplication.Pages.TaskDetail" %>

<%@ Register TagPrefix="dx" Namespace="DevExpress.Web" Assembly="DevExpress.Web.v17.1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="Content" runat="server">
    <script>
        function OnEndCallback(s, e) {
            if (s.cpAlert != null && s.cpAlert != "") {
                alert(s.cpAlert);
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
        function deleteTask(id) {
            if (confirm("Bạn có muốn xóa không?")) {
                cp.PerformCallback('delTask_' + id);
            }
        }
        function editTask(id) {
            cpedit.PerformCallback('editTask_' + id);
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

        .dxflGroup_Moderno {
            padding: 0
        }
        #Content_pcEdit_ASPxCallbackPanel2_ASPxFormLayout2_gvTaskAnswer_DXMainTable{
            border: none !important 
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
                                                    <dx:ASPxGridView runat="server" Width="100%" ID="gvTaskBank" ClientInstanceName="gvTaskBank"
                                                        AutoGenerateColumns="False">
                                                        <Settings VerticalScrollBarMode="Visible" VerticalScrollableHeight="400" />
                                                        <Columns>
                                                            <dx:GridViewDataTextColumn Caption="#" Width="50" VisibleIndex="0">
                                                                <DataItemTemplate>
                                                                    <%# Container.ItemIndex + 1%>
                                                                </DataItemTemplate>
                                                            </dx:GridViewDataTextColumn>
                                                            <dx:GridViewDataColumn FieldName="BankContent" Caption="Nội dung" VisibleIndex="1" />
                                                            <dx:GridViewDataTextColumn Caption="Loại" Width="120" VisibleIndex="2">
                                                                <DataItemTemplate>
                                                                    <%# Convert.ToString(Eval("ControllType")) == "ckbox" ? "Chọn nhiều" : "Chọn 1" %>
                                                                </DataItemTemplate>
                                                            </dx:GridViewDataTextColumn>
                                                            <dx:GridViewDataTextColumn Caption="Yêu cầu" Width="120" VisibleIndex="3">
                                                                <DataItemTemplate>
                                                                    <%# Convert.ToInt32(Eval("Required")) == 1 ? "Bắt buộc" : "K.bắt buộc" %>
                                                                </DataItemTemplate>
                                                            </dx:GridViewDataTextColumn>
                                                            <dx:GridViewDataTextColumn Caption="#" Width="150" VisibleIndex="4">
                                                                <DataItemTemplate>
                                                                    <a onclick='<%# "editTask(" +Eval("Id") +")" %>' style="cursor: pointer">Edit</a>
                                                                    &nbsp;&nbsp;&nbsp;<a onclick='<%# "deleteTask(" +Eval("Id") +")" %>' style="cursor: pointer">Delete</a>
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
            <dx:PopupControlContentControl ID="PopupControlContentControl2" Height="500px" runat="server">
                <dx:ASPxCallbackPanel ID="ASPxCallbackPanel2" runat="server" Width="100%"
                    ClientInstanceName="cpedit" OnCallback="cpedit_Callback">
                    <ClientSideEvents EndCallback="EditEndCallback" />
                    <PanelCollection>
                        <dx:PanelContent runat="server">
                            <dx:ASPxFormLayout runat="server" ID="ASPxFormLayout2" CssClass="formLayout">
                                <SettingsAdaptivity AdaptivityMode="SingleColumnWindowLimit" SwitchToSingleColumnAtWindowInnerWidth="500" />
                                <Items>
                                    <dx:LayoutItem Caption="Hình ảnh" Width="100%">
                                        <LayoutItemNestedControlCollection>
                                            <dx:LayoutItemNestedControlContainer>
                                                <dx:ASPxBinaryImage ID="ImageControl" runat="server"
                                                    Width="30%" Height="100px"
                                                    ShowLoadingImage="true">
                                                    <EditingSettings Enabled="true">
                                                        <UploadSettings>
                                                            <UploadValidationSettings MaxFileSize="4194304"
                                                                AllowedFileExtensions=".jpe, .jpeg, .jpg, .gif, .png">
                                                            </UploadValidationSettings>
                                                        </UploadSettings>
                                                    </EditingSettings>
                                                </dx:ASPxBinaryImage>
                                            </dx:LayoutItemNestedControlContainer>
                                        </LayoutItemNestedControlCollection>
                                    </dx:LayoutItem>
                                    <dx:LayoutItem Caption="Nội dung" Width="100%">
                                        <LayoutItemNestedControlCollection>
                                            <dx:LayoutItemNestedControlContainer>
                                                <dx:ASPxButtonEdit runat="server" Width="100%" ID="txtname">
                                                    <ClearButton DisplayMode="OnHover"></ClearButton>
                                                </dx:ASPxButtonEdit>
                                            </dx:LayoutItemNestedControlContainer>
                                        </LayoutItemNestedControlCollection>
                                    </dx:LayoutItem>
                                    <dx:LayoutItem Caption="Loại" Width="100%">
                                        <LayoutItemNestedControlCollection>
                                            <dx:LayoutItemNestedControlContainer>
                                                <dx:ASPxRadioButtonList runat="server" ID="rdck" RepeatDirection="Horizontal">
                                                    <Items>
                                                        <dx:ListEditItem Text="Chọn 1" Selected="true" Value="radio" />
                                                        <dx:ListEditItem Text="Chọn nhiều" Value="ckbox" />
                                                    </Items>
                                                </dx:ASPxRadioButtonList>
                                            </dx:LayoutItemNestedControlContainer>
                                        </LayoutItemNestedControlCollection>
                                    </dx:LayoutItem>
                                    <dx:LayoutItem Caption="Bắt buộc" Width="100%">
                                        <LayoutItemNestedControlCollection>
                                            <dx:LayoutItemNestedControlContainer>
                                                <dx:ASPxRadioButtonList runat="server" ID="rdforce" RepeatDirection="Horizontal">
                                                    <Items>
                                                        <dx:ListEditItem Text="Có" Selected="true" Value="1" />
                                                        <dx:ListEditItem Text="Không" Value="0" />
                                                    </Items>
                                                </dx:ASPxRadioButtonList>
                                            </dx:LayoutItemNestedControlContainer>
                                        </LayoutItemNestedControlCollection>
                                    </dx:LayoutItem>
                                    <dx:LayoutItem Caption="Đáp án" Width="100%">
                                        <LayoutItemNestedControlCollection>
                                            <dx:LayoutItemNestedControlContainer>
                                                <div style="height: 250px; width: 100%; overflow-y: scroll; float: left; border: 1px solid #d7d7d7">
                                                    <dx:ASPxGridView runat="server" Width="100%" ID="gvTaskAnswer" Border-BorderWidth="0"
                                                        AutoGenerateColumns="False">
                                                        <Columns>
                                                            <dx:GridViewDataTextColumn Caption="Content" Width="100%" VisibleIndex="0">
                                                                <DataItemTemplate>
                                                                    <div class="row">
                                                                        <div class="col-md-6">
                                                                            <asp:HiddenField runat="server" ID="hdfID" Value='<%#Eval("Id") %>' />
                                                                            <dx:ASPxButtonEdit runat="server" Height="50px" Width="100%"
                                                                                Text='<%# Eval("AnsContent") %>' ID="txans">
                                                                                <ClearButton DisplayMode="OnHover"></ClearButton>
                                                                            </dx:ASPxButtonEdit>
                                                                        </div>
                                                                        <div class="col-md-6">
                                                                            <iframe style="border: none; width: 100%; height: 74px;"
                                                                                src='<%# "/Pages/ImageAnswerUpload.aspx?Id="+Eval("Id") %>'
                                                                                onscroll="false"></iframe>
                                                                        </div>
                                                                    </div>
                                                                </DataItemTemplate>
                                                            </dx:GridViewDataTextColumn>
                                                        </Columns>
                                                        <Settings ShowFilterRow="false" ShowFooter="false" ShowTitlePanel="false" ShowColumnHeaders="false" />
                                                    </dx:ASPxGridView>
                                                </div>
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
</asp:Content>
