<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="TaskSurvey.aspx.cs" Inherits="WebApplication.Pages.Employee.TaskSurvey" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" />
    <title></title>

    <link href="Content/bootstrap.min.css" rel="stylesheet" />
    <link href="Content/font-awesome/css/font-awesome.css" rel="stylesheet" />
    <link href="Content/site.css" rel="stylesheet" />
    <!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!--[if lt IE 9]>
        <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
        <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->

    <script src="<%# ResolveUrl("~/Scripts/jquery-1.12.2.min.js")%>" type="text/javascript"></script>

    <script src="<%# ResolveUrl("~/Scripts/site.js")%>" type="text/javascript"></script>
    <script src="/Pages/Employee/js/countdown.js"></script>
    <script src="/Pages/Employee/js/jquery.countdown.js"></script>
    <script>
        function finishtest() {

            aspxCallback.PerformCallback('finish');
        }
        function onEndCallback(s, e) {
            if (s.cpAlert != null && s.cpAlert != "") {
                if (s.cpAlert != "1") alert(s.cpAlert);
                if (s.cpAlert === "1")
                    pcAlert.Show();
            }
        }
    </script>
    <style>
        *, .dxeBase, .dxeEditAreaSys, .dxeListBoxItem {
            font-size: small;
            line-height: inherit;
        }

        /*.filter .dxeCaption_Moderno {
            width: 64px !important
        }*/
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="wrapper">
            <header style="border-top: 5px solid #e60027; background-image:url(../../Content/Images/header.png);background-size: cover;min-height: 115px;max-height: 200px;">
                <div class="container">
                    <dx:ASPxPanel ID="TopPanel" runat="server" ClientInstanceName="TopPanel" Width="100%" Collapsible="true">
                        <SettingsAdaptivity CollapseAtWindowInnerWidth="768" />
                        <SettingsCollapsing>
                            <ExpandButton GlyphType="Strips" />
                        </SettingsCollapsing>
                        <Styles>
                            <ExpandBar CssClass="expandBar" />
                            <ExpandedPanel CssClass="expandedPanel" />
                        </Styles>
                        <ExpandBarTemplate>
                        </ExpandBarTemplate>
                        <PanelCollection>
                            <dx:PanelContent>
                                <div class="panelContent">
                                    <div class="pull-right">
                                        <div class="panelItem">
                                            <dx:ASPxMenu ID="NavMenu" runat="server" ClientInstanceName="NavMenu" EnableAnimation="true" CssClass="navMenu">
                                            </dx:ASPxMenu>
                                        </div>
                                        <div class="panelItem" style="padding: 5px 28px 6px 26px;">
                                            <div class="dxmLite_Moderno dxm-ltr">
                                                <div class="dxm-main dxm-horizontal navMenu">
                                                    Welcome <b><%= ((LogicTier.Models.Employee)Session["UserInfo"]).UserName %></b>
                                                    [<asp:LinkButton runat="server" ID="btLogOut" OnClick="btLogOut_Click" Text="Log Out"></asp:LinkButton>]
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="clearfix"></div>
                                </div>
                            </dx:PanelContent>
                        </PanelCollection>
                    </dx:ASPxPanel>
                </div>
            </header>
            <div class="content">
                <div class="container">
                    <div class="row text-center">
                        <div class="col-xs-12" style="margin: 0px; padding: 0; height: 70px">
                            <div class="row">
                                <div class="col-xs-7 text-left">
                                    <h3 style="padding-left: 15px; line-height: 24px; font-size: 16px!important; color: #f56373">
                                        <asp:Literal ID="ltrname" runat="server"></asp:Literal>
                                    </h3>
                                </div>
                                <div class="col-xs-5">
                                    <div class="countdown" id="dvTimer">
                                        <script type="application/javascript">
                                            new Countdown({
                                                time: '<%=timeInterval%>',
                                                width: 95,
                                                height: 36,
                                                rangeHi: "minute",
                                                onComplete: finishtest
                                            });
                                        </script>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-xs-12" style="margin: 0px; margin-bottom: 5px; height: 67vh;">
                            <div class="row">
                                <div class="col-xs-12 lst-q" style="padding: 0 30px 0 60px;">
                                    <ul class="t-question">
                                        <asp:Repeater ID="rpTask" runat="server" DataSourceID="odsTask">
                                            <ItemTemplate>
                                                <li id='<%#"question"+ Container.ItemIndex +1 %>'>
                                                    <b class="main-color">Câu <%# Container.ItemIndex +1 %>:</b>
                                                    <span><%#Eval("BankContent") %> <%#Convert.ToBoolean(Eval("Required"))?"<strong style='color: red'>(*)</strong>":"" %> </span>

                                                    <dx:ASPxLabel ID="lblBankId" runat="server" Text='<%#Eval("BankId") %>' Visible="false"></dx:ASPxLabel>
                                                    <dx:ASPxLabel ID="lbTaskId" runat="server" Text='<%#Eval("TaskId") %>' Visible="false"></dx:ASPxLabel>
                                                    <dx:ASPxLabel ID="lblType" runat="server" Text='<%#Eval("BankType") %>' Visible="false"></dx:ASPxLabel>
                                                    <dx:ASPxLabel ID="lblRequired" runat="server" Text='<%#Convert.ToBoolean(Eval("Required"))?"1":"0" %>' Visible="false"></dx:ASPxLabel>
                                                    <ul class="t-answer">
                                                        <li>
                                                            <dx:ASPxRadioButtonList ID="radioAnswer" Width="100%" Border-BorderStyle="None" DataSource='<%# getAnswer(Convert.ToInt32(Eval("BankId"))) %>' Enabled='<%# !string.IsNullOrEmpty(Convert.ToString(Eval("AnsId"))) || !string.IsNullOrEmpty(Convert.ToString(Eval("AnsContent"))) ? false: true %>' Value='<%#Eval("AnsId") %>' ValueField="AnsId" runat="server" ValueType="System.Int32" TextField="AnsContent" Visible='<%# Eval("cklist") %>'></dx:ASPxRadioButtonList>
                                                            <dx:ASPxCheckBoxList ID="cboxAnser" Width="100%" Border-BorderStyle="None" DataSource='<%# getAnswer(Convert.ToInt32(Eval("BankId"))) %>' Enabled='<%# !string.IsNullOrEmpty(Convert.ToString(Eval("AnsId"))) || !string.IsNullOrEmpty(Convert.ToString(Eval("AnsContent"))) ? false: true %>' ValueField="AnsId" runat="server" ValueType="System.Int32" TextField="AnsContent" Visible='<%# Eval("ckbox") %>'></dx:ASPxCheckBoxList>
                                                            <dx:ASPxMemo ID="txtAnswer" ToolTip='<%#Eval("AnsId") %>' NullText="Nhập vào câu trả lời của bạn" Rows="4" Width="100%" runat="server" Text='<%# Eval("AnsContent") %>' Visible='<%# Eval("txbox") %>'></dx:ASPxMemo>
                                                        </li>
                                                    </ul>
                                                </li>
                                            </ItemTemplate>
                                        </asp:Repeater>
                                    </ul>
                                </div>
                            </div>
                        </div>
                        <div class="col-xs-12 text-center">
                            <a onclick="finishtest();" style="background: #08bf17; height: 32px; border-radius: 16px; line-height: 32px; width: 100px; display: inline-block; text-align: center; color: #fff">Hoàn thành</a>
                        </div>
                    </div>
                    <dx:ASPxCallbackPanel ID="aspxCallback" runat="server" Width="100%" SettingsLoadingPanel-Enabled="false" SettingsLoadingPanel-ShowImage="false" SettingsLoadingPanel-Text=""
                        ClientInstanceName="aspxCallback" OnCallback="aspxCallback_Callback">
                        <PanelCollection>
                            <dx:PanelContent runat="server">
                            </dx:PanelContent>
                        </PanelCollection>
                    </dx:ASPxCallbackPanel>
                    <asp:ObjectDataSource ID="odsTask" runat="server" SelectMethod="getByEmployee" TypeName="LogicTier.Controllers.TaskBL">
                        <SelectParameters>
                            <asp:ControlParameter ControlID="hdfKey" Name="EmployeeId" PropertyName="['EmployeeId']" Type="Int32" />
                            <asp:ControlParameter ControlID="hdfKey" Name="TaskId" PropertyName="['TaskId']" Type="Int32" />
                        </SelectParameters>
                    </asp:ObjectDataSource>
                    <dx:ASPxHiddenField ID="hdfKey" ClientInstanceName="hdfKey" runat="server"></dx:ASPxHiddenField>
                    <style type="text/css">
                        .t-question {
                            padding: 0;
                            margin: 0;
                            float: left;
                        }

                        .t-answer {
                            padding: 0;
                            margin: 0;
                            float: left;
                            width: 100%
                        }

                        .dxeIRBFocused_Moderno {
                            outline: none !important
                        }

                        .t-question li {
                            list-style: none;
                            float: left;
                            width: 100%;
                            text-align: left
                        }

                        .countdown {
                            background: #9e9deb;
                            border-radius: 5px;
                            box-shadow: 0px 0px 4px #9291e6;
                            padding: 5px;
                            float: right;
                            margin-right: 15px;
                            margin-top: 7px
                        }

                        .title-countdown {
                            display: none
                        }

                        .countdown #TextBox_jbeeb_7 span, .countdown #TextBox_jbeeb_11 span {
                            font-size: 16px;
                            cursor: inherit;
                            white-space: nowrap;
                            line-height: 1.25em;
                            color: rgb(255, 255, 255);
                            font-family: Arial, _sans;
                        }

                        #Container_jbeeb_6, #Container_jbeeb_10 {
                            background-image: -webkit-linear-gradient(top, rgb(63, 62, 150) 0%, rgb(89, 88, 171) 50%, rgb(63, 62, 150) 50%, rgb(89, 88, 171) 100%) !important
                        }

                        #Container_jbeeb_6, #TextBox_jbeeb_7, #Container_jbeeb_10, #TextBox_jbeeb_11 {
                            height: 20px !important;
                            font-size: 16px !important;
                        }

                        #Box_jbeeb_8 {
                            display: none !important
                        }

                        #Box_jbeeb_12 {
                            display: none !important
                        }

                        .timered {
                            background: #ff6a00 !important;
                        }

                        #TextBox_jbeeb_9, #TextBox_jbeeb_13 {
                            top: 25.5px !important;
                            width: 46px !important
                        }

                            #TextBox_jbeeb_9 span, #TextBox_jbeeb_13 span {
                                font-size: 10px !important
                            }

                        #Stage_jbeeb_3 {
                            margin-top: 5px;
                        }

                        .dxeFocused_Moderno {
                            border: none !important;
                            box-shadow: none !important;
                            -webkit-box-shadow: none !important
                        }
                    </style>
                </div>
            </div>
            <div id="btnBackToTop" class="btnBackToTop hidden">
                <i class="glyphicon glyphicon-circle-arrow-up"></i>
            </div>
            <footer class="stickyFooter">
                <div class="footerDown">
                    <div class="container">
                        <p><%:DateTime.Today.Year.ToString()%> &copy; <a href="http://http://congnghenguon.com.vn">Source Technology Company.</a> | All Rights Reserved.</p>
                    </div>
                </div>
            </footer>
        </div>
        <dx:ASPxGlobalEvents runat="server" ClientSideEvents-ControlsInitialized="adjustNavMenu" />
    </form>
</body>
</html>
