<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Silder.aspx.cs" Inherits="WebApplication.Pages.Silder" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <script src="/Scripts/jquery-1.12.2.min.js"></script> 
    <link href="/Content/pgwslideshow.css" rel="stylesheet" />
</head>
<body>
    <form id="form1" runat="server">
          <ul class="pgwSlideshow" id="sliders" runat="server">
        </ul>
        <script src="/Scripts/pgwslideshow.js"></script>
    </form>
</body>
</html>
