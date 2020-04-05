<%@ Page Title="Products" Language="C#" MasterPageFile="~/Layout.master" AutoEventWireup="true" CodeBehind="Changepassword.aspx.cs" Inherits="WebApplication.Pages.Changepassword" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Content" runat="server">
    <script type="text/javascript">
        var minPwdLength = 3;
        var strongPwdLength = 6;

        function UpdateIndicator() {
            var strength = GetPasswordStrength(tbPassword.GetText());

            var className;
            var message;
            if (strength == -1) {
                className = 'pwdBlankBar';
                message = "Empty";
            } else if (strength == 0) {
                className = 'pwdBlankBar';
                message = "Too short";
            } else if (strength <= 0.2) {
                className = 'pwdWeakBar';
                message = "Weak";
            } else if (strength <= 0.6) {
                className = 'pwdFairBar';
                message = "Fair";
            } else {
                className = 'pwdStrengthBar';
                message = "Strong";
            }

            // update css and message
            var bar = document.getElementById("PasswordStrengthBar");
            bar.className = className;
            lbMessagePassword.SetValue(message);
        }
        function GetPasswordStrength(password) {
            if (password.length == 0) return -1;
            if (password.length < minPwdLength) return 0;

            var rate = 0;
            if (password.length >= strongPwdLength) rate++;
            if (password.match(/[0-9]/)) rate++;
            if (password.match(/[a-z]/)) rate++;
            if (password.match(/[A-Z]/)) rate++;
            if (password.match(/[!,@,#,$,%,^,&,*,?,_,~,\-,(,),\s,\[,\],+,=,\,,<,>,:,;]/)) rate++;
            return rate / 5;
        }

        function ConfirmedPassword_OnValidation(s, e) {
            if (txtNewpassword.GetValue() != txtconfirmpassword.GetValue()) {
                e.isValid = false;
                e.errorText = "Passwords do not match";
            }
        }
    </script>
    <script type="text/javascript">
        $(document).ready(function () {
            $("#TopPanel_NavMenu ul li:eq(6)").addClass("dxm-selected");
        })
    </script>
    <div class="container">
        <div class="row marginTop20">
            <div class="col-md-12">
                <dx:ASPxFormLayout ID="changepasswordFormLayout" runat="server" UseDefaultPaddings="false">
                    <SettingsItems Width="100%" HorizontalAlign="Center" VerticalAlign="Middle" />
                    <SettingsItemCaptions Location="Top" />
                    <Items>
                        <dx:LayoutGroup Caption="Change password" ColCount="1">
                            <Items>
                                <dx:LayoutItem Caption="New password">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer>
                                            <dx:ASPxButtonEdit runat="server" ID="txtNewpassword" ClientInstanceName="txtNewpassword" Password="True">
                                                <ClearButton DisplayMode="OnHover"></ClearButton>                                                 
                                                <ValidationSettings SetFocusOnError="True" ErrorTextPosition="Bottom" ErrorDisplayMode="Text"
                                                    ValidateOnLeave="False" Display="Dynamic">
                                                    <RegularExpression ValidationExpression=".{3,}" ErrorText="Must have at least 3 characters" />
                                                    <RequiredField IsRequired="True" ErrorText="Required field cannot be left empty" />
                                                </ValidationSettings>
                                            </dx:ASPxButtonEdit>
                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>
                                </dx:LayoutItem>
                                <dx:LayoutItem Caption="Confirm new password">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer>
                                            <dx:ASPxButtonEdit runat="server" ID="txtconfirmpassword" ClientInstanceName="txtconfirmpassword" Password="True" OnValidation="txtconfirmpassword_Validation" >
                                                <ClearButton DisplayMode="OnHover"></ClearButton>
                                                <ClientSideEvents Validation="ConfirmedPassword_OnValidation" />
                                                <ValidationSettings SetFocusOnError="True" EnableCustomValidation="True" ErrorTextPosition="Bottom"
                                                    ErrorDisplayMode="Text" ValidateOnLeave="False" Display="Dynamic">
                                                    <RequiredField IsRequired="True" ErrorText="Required field cannot be left empty" />
                                                </ValidationSettings>
                                            </dx:ASPxButtonEdit>
                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>
                                </dx:LayoutItem>
                                <dx:LayoutItem ShowCaption="False" Caption="Confirm new password">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer>
                                            <dx:ASPxButton runat="server" ID="ASPxButtonEdit2" CssClass="btn btn-primary" OnClick="ASPxButtonEdit2_Click" Text="Change password">
                                            </dx:ASPxButton>
                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>
                                </dx:LayoutItem>
                            </Items>
                        </dx:LayoutGroup>
                    </Items>
                </dx:ASPxFormLayout>
            </div>
        </div>
    </div>
</asp:Content>