
<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ImageAnswerUpload.aspx.cs" 
    Inherits="WebApplication.Pages.ImageAnswerUpload" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Hình ảnh</title>
    <link href="/Content/Css/bootstrap.min.css" rel="stylesheet" />
    <style type="text/css">
        body
        {
            margin:0;
            padding:0
        }
        #upFile
        {
            width: 82px!important;
        }
    </style>
    <script src="../Scripts/jquery-1.12.2.min.js"></script>
    <script type="text/javascript">
        function photo() {
            $('#btnAdd').click();
        }
    </script>
</head>
<body>
    <form id="form1" runat="server">
        <div class="fileatt" style="width: 100%">
            <div style="float: left; width: 100%;">
                <asp:Image ID="Image1" Height="50px" runat="server" />
            </div>
            <div style="float: left; width: 20%">
                <asp:FileUpload ID="upFile" AllowMultiple="true" runat="server" 
                    ClientIDMode="Static" onchange="photo();" />
            </div>
        </div>
        <div style="display: none">
            <asp:Button ID="btnAdd" OnClick="btnAdd_Click" runat="server" Text="Button" />
        </div>
    </form>
</body>
</html>