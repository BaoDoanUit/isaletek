<%@ Page Title="Events" Language="C#" MasterPageFile="~/Layout.master"
    AutoEventWireup="true"
    CodeBehind="EventsCreate.aspx.cs" Inherits="WebApplication.Pages.EventsCreate" %>

<%@ Register TagPrefix="dx" Namespace="DevExpress.Web" Assembly="DevExpress.Web.v17.1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="Content" runat="server">
    <script type="text/javascript" src="../Scripts/jquery.dragsort-0.5.2.min.js"></script>

    <script type="text/javascript">
        $(document).ready(function () {
            $("#TopPanel_NavMenu ul li:eq(6)").addClass("dxm-selected");
        })

        function Save() {
            FormCallback.PerformCallback('save;0');
            upload.Upload();
        }

        function FormEndCallback(s, e) {
            var str = s.cpAlert.split('_')
            if (str[0] === 'UploadFile') {
                console.log("End");
                var isValid = upload.GetText() != "";
                if (isValid) {
                    upload.Upload();
                } else {
                    alert('Success');
                    window.location = "/Pages/EventsCreate.aspx?Id=" + str[1];
                }

            } else if (str[0] === 'LoadData') {
                window.location = "/Pages/EventsCreate.aspx?Id=" + str[1];
            }
            else
                alert(s.cpAlert);
        }

        function EndFileUploadComplete(s, e) {
            var str = e.callbackData.split('_');
            if (str[0] === 'No Upload' || str[0] === 'Fail') {
                alert(e.callbackData);
            }
            else {
                alert("Success");
                window.location = "/Pages/EventsCreate.aspx?Id=" + str[1];
            }
        }

        function NavigateSlide(Id) {
            console.log("go");
            window.location = "/Pages/EventsSlide.aspx?Id=" + Id;
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
            <dx:ASPxFormLayout runat="server" ID="ASPxFormLayout1" Width="100%" Height="100%">
                <Items>
                    <dx:LayoutItem Caption="Image">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer>
                                <dx:ASPxBinaryImage ID="ImageControl" runat="server"
                                    Width="100%" Height="150px"
                                    ShowLoadingImage="true">
                                    <EditingSettings Enabled="true">
                                        <UploadSettings>
                                            <UploadValidationSettings MaxFileSize="4194304"
                                                AllowedFileExtensions=".jpe, .jpeg, .jpg, .gif, .png">
                                            </UploadValidationSettings>
                                        </UploadSettings>
                                    </EditingSettings>
                                </dx:ASPxBinaryImage>
                                 <asp:Literal ID="ltrAddSlide" runat="server"></asp:Literal>
                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                    </dx:LayoutItem>
                    <dx:LayoutItem Caption="Events Name">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer>
                                <dx:ASPxButtonEdit runat="server" Width="100%"
                                    ID="txtEventsName" ClientInstanceName="txtEventsName">
                                    <ClearButton DisplayMode="OnHover"></ClearButton>
                                </dx:ASPxButtonEdit>
                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                    </dx:LayoutItem>
                    <dx:LayoutItem Caption="Content">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer>
                                <dx:ASPxHtmlEditor ID="editorContent" ClientInstanceName="editorContent" runat="server" Height="270px" Width="100%">
                                    <SettingsDialogs>
                                        <InsertImageDialog>
                                            <SettingsImageUpload UploadFolder="~/UploadFiles/Events/Images/">
                                            </SettingsImageUpload>
                                        </InsertImageDialog>
                                    </SettingsDialogs>
                                </dx:ASPxHtmlEditor>
                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                    </dx:LayoutItem>
                    <dx:LayoutItem Caption="Date Post">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer>
                                <asp:HiddenField ID="hfId" runat="server" />
                                <dx:ASPxDateEdit runat="server" Width="100%" ID="deDatePost" OnInit="deDatePost_Init"
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
                                    runat="server" RepeatDirection="Horizontal" RepeatColumn="1">
                                    <Items>
                                        <dx:ListEditItem Value="1" Text="Level 1" />
                                        <dx:ListEditItem Value="2" Text="Level 2" />
                                        <dx:ListEditItem Value="3" Text="Level 3" />
                                    </Items>
                                </dx:ASPxRadioButtonList>
                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                    </dx:LayoutItem>
                    <dx:LayoutItem Caption="File Path">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer>
                                <dx:ASPxUploadControl ID="UploadControl"
                                    runat="server"
                                    ClientInstanceName="upload" Width="100%"
                                    OnFileUploadComplete="UploadControl_FileUploadComplete"
                                    NullText="Bấm để chọn file png, jpg, bmp, pdf...">
                                    <AdvancedModeSettings EnableMultiSelect="false" EnableDragAndDrop="false" />
                                    <ValidationSettings MaxFileSize="4194304"
                                        AllowedFileExtensions=".png, .jpg, .bmp, .pdf"
                                        ShowErrors="true">
                                    </ValidationSettings>
                                    <ClientSideEvents FileUploadComplete="EndFileUploadComplete" />
                                </dx:ASPxUploadControl>
                                <div style="width: 100%;">
                                    <div style="float: left; padding-top: 2px; padding-right: 5px;">
                                        <asp:HyperLink ID="hpAttach" Visible="false" runat="server">Download</asp:HyperLink>
                                    </div>
                                    <div style="float: left; border-left: 1px solid #aaa;">
                                        <dx:ASPxCheckBox Visible="false" runat="server" ID="ckDelete" Text="Xóa"></dx:ASPxCheckBox>
                                    </div>
                                </div>
                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                    </dx:LayoutItem>
                 
                    <dx:LayoutItem ShowCaption="False">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer>
                                <asp:Literal ID="ltrbSave" runat="server"></asp:Literal>
                               <%--  <div style="width: 100%;">
                                    <div style="float: left; border-left: 1px solid #aaa;">
                                        <dx:ASPxButton Visible="false" runat="server" 
                                            ID="btnSlide" Text="Add Slide"  AutoPostBack="false" >
                                        </dx:ASPxButton>
                                    </div>
                                </div>--%>
                                
                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                    </dx:LayoutItem>
                </Items>
            </dx:ASPxFormLayout>
            <dx:ASPxCallbackPanel ID="FormCallback" runat="server" Width="100%"
                ClientInstanceName="FormCallback" OnCallback="FormCallback_Callback">
                <ClientSideEvents EndCallback="FormEndCallback" />
                <PanelCollection>
                    <dx:PanelContent runat="server">
                    </dx:PanelContent>
                </PanelCollection>
            </dx:ASPxCallbackPanel>
        </div>
    </div>
</asp:Content>
