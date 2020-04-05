<%@ Page Title="" Language="C#" MasterPageFile="~/Layout.master" AutoEventWireup="true" CodeBehind="WebForm1.aspx.cs" Inherits="WebApplication.Pages.WebForm1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Content" runat="server">
    <script>
        function OnFileUploadComplete(s, e) {
            if (e.callbackData) {
                if (e.callbackData != null && e.callbackData != "")
                    window.location.href = (e.callbackData);
            }
        }
    </script>
    <dx:ASPxUploadControl ID="upFile" runat="server" ClientInstanceName="upFile" Width="100%" UploadButton-ImagePosition="Bottom"
        NullText="Chọn file..." OnFileUploadComplete="upFile_FileUploadComplete" UploadMode="Auto" ShowProgressPanel="True" FileUploadMode="OnPageLoad">
        <UploadButton ImagePosition="Bottom"></UploadButton>
        <ClientSideEvents FileUploadComplete="OnFileUploadComplete" />
    </dx:ASPxUploadControl>
    <br />
    <dx:ASPxButton ID="bSubmit" ClientInstanceName="bSubmit" runat="server" Text="Lưu" Width="100" AutoPostBack="false">
        <ClientSideEvents Click="function(){upFile.Upload()}" />
    </dx:ASPxButton>
</asp:Content>
