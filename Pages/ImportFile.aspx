<%@ Page Title="Events" Language="C#" MasterPageFile="~/Layout.master"
    AutoEventWireup="true"
    CodeBehind="ImportFile.aspx.cs" Inherits="WebApplication.Pages.ImportFile" %>

<asp:Content ID="Content2" ContentPlaceHolderID="Content" runat="server">
    <script>
        function onFileUploadComplete(s, e) {
            if (e.callbackData) {
                if (e.callbackData != null && e.callbackData != "")
                    alert(e.callbackData);
            }
        }
    </script>
    <dx:ASPxFormLayout runat="server" ID="ASPxFormLayout2" CssClass="formLayout">
        <SettingsAdaptivity AdaptivityMode="SingleColumnWindowLimit" SwitchToSingleColumnAtWindowInnerWidth="384" />
        <Paddings Padding="5" />
        <Items>
            <dx:LayoutGroup Caption="" ShowCaption="False" ColCount="2" GroupBoxDecoration="None" UseDefaultPaddings="false" Paddings-PaddingTop="10">
                <Paddings PaddingTop="10px"></Paddings>
                <GroupBoxStyle>
                    <Caption Font-Bold="true" Font-Size="16" BackColor="Transparent" />
                </GroupBoxStyle>
                <Items>
                    <dx:LayoutItem Caption="Excel File" Width="100%">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer>
                                <dx:ASPxUploadControl ID="upFile" runat="server" ClientInstanceName="upFile" Width="100%" UploadButton-ImagePosition="Bottom"
                                    NullText="(*.xlsx)..." UploadMode="Auto" ShowProgressPanel="True"
                                    OnFileUploadComplete="upFile_FileUploadComplete" FileUploadMode="OnPageLoad">
                                    <ClientSideEvents FileUploadComplete="onFileUploadComplete" />
                                </dx:ASPxUploadControl>
                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                    </dx:LayoutItem>
                    <dx:LayoutItem ShowCaption="False" HorizontalAlign="Right" Width="100%">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer>
                                <table>
                                    <tr>
                                        <td style="padding-right: 10px">
                                            <dx:ASPxButton ID="ASPxButton2" runat="server" Text="Import" Width="100" AutoPostBack="false">
                                                <ClientSideEvents Click="function(s,e){upFile.Upload();}" />
                                            </dx:ASPxButton>
                                        </td>
                                    </tr>
                                </table>
                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                    </dx:LayoutItem>
                </Items>
            </dx:LayoutGroup>
        </Items>
    </dx:ASPxFormLayout>
</asp:Content>