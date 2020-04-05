<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="WebApplication.Pages.Account.Login" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>Let us help you grow your business | Log in</title>

    <link href="~/Content/bootstrap.min.css" rel="stylesheet" />
    <link href="~/Content/login.css" rel="stylesheet" />
    <!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!--[if lt IE 9]>
        <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
        <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->

    <script src="<%# ResolveUrl("~/Scripts/jquery-1.12.2.min.js")%>" type="text/javascript"></script>
    <script src="<%# ResolveUrl("~/Scripts/site.js")%>" type="text/javascript"></script>

    <style>
        #login_signup .login_signup_header {
            height: 95px;
        }

            #login_signup .login_signup_header .logo {
                height: 75px;
            }
    </style>
</head>
<body id="login_signup" class="">

    <div class="login_signup_header">
        <div class="account_logo">
            <%--<a href="http://congnghenguon.com.vn" class="logo" style="background-image: url(/Content/Images/Logo/logo.png); background-size: 180px 60px;" tabindex="-1"></a>--%>
        </div>
    </div>
    <div class="page_content">
        <div class="content">
            <div class="login_wrapper">
                <div class="main_box">
                    <form id="form1" runat="server" accept-charset="UTF-8" class="login-form">
                        <div class="account_name">
                            <h1>
                                <b>Log</b>&nbsp;In
                            </h1>
                        </div>
                        <div class="form_inner tight_form">
                            <div class="email_password_wrapper">
                                <div class="form-group flat">
                                    <asp:TextBox ID="UserName" runat="server" CssClass="form-control with_pop_label with_value parsley-validated" placeholder="Tên đăng nhập"></asp:TextBox>
                                    <span class="pop_label" style="right: 311px;">Tên đăng nhập</span>
                                </div>
                                <div class="form-group flat">
                                    <asp:TextBox ID="Password" runat="server" CssClass="form-control with_pop_label with_value parsley-validated" placeholder="Mật khẩu" TextMode="Password"></asp:TextBox>
                                    <span class="pop_label" style="right: 280px;">Mật khẩu</span>
                                </div>
                            </div>
                            <div class="otp_wrapper">
                                <div class="otp_title">
                                    <asp:Literal runat="server" ID="StatusText" />
                                    <span id="forgot_password_user_masked_phone"></span>
                                </div>
                            </div>
                            <div class="help_wrapper forgot_password_wrapper">
                                <a href="#" class="help">Quên mật khẩu?</a>
                            </div>
                            <div class="login_button-wrapper">
                                <asp:Button runat="server" Text="Log In" class="ladda-button submit_button btn btn-primary ladda-label" TabIndex="2" OnClick="SignIn" />
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>

</body>
</html>
