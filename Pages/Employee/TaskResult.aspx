<%@ Page Title="" Language="C#" MasterPageFile="~/Layout.master" AutoEventWireup="true" CodeBehind="TaskResult.aspx.cs" Inherits="WebApplication.Pages.Employee.TaskResult" %>
<asp:Content ID="Content1" ContentPlaceHolderID="Content" runat="server">
    <script src="/Pages/Employee/js/countdown.js"></script>
    <script src="/Pages/Employee/js/jquery.countdown.js"></script>
    <script>
        function finishtest() {
            aspxCallback.PerformCallback('finish');
        }
        function updateAns(TaskId, BankId, AnsId) {
            aspxCallback.PerformCallback('updateAns;' + TaskId + ';' + BankId + ';' + AnsId);
        }
        function OnEndCallback(s, e) {
            if (s.cpAlert != '') {
                if (s.cpAlert != "1") alert(s.cpAlert);
                if (s.cpAlert === "1") {
                    delete s.cpAlert;
                    pcAlert.Show();
                }
            }
        }
    </script>
    <div class="row text-center" style="background-image: url(../../Content/Images/bg-task-2.jpg); background-size: cover; height: 80vh;">
        <div class="col-xs-12" style="margin: 0px; margin-bottom: 5px; height: 70vh; overflow: auto">
            <div class="row">
                <h3 style="padding-left: 15px; line-height: 24px; font-size: 16px!important; color: #f56373">
                    <asp:Literal ID="ltrname" runat="server"></asp:Literal>
                </h3>
                <div class="col-xs-12 lst-q" style="padding: 0 30px 0 60px;">
                    <ul class="t-question">
                        <asp:Repeater ID="rpTask" runat="server">
                            <ItemTemplate>
                                <li id='<%#"question"+ Container.ItemIndex +1 %>'>
                                    <b class="main-color">Câu <%# Container.ItemIndex +1 %>:</b>
                                    <span><%#Eval("BankContent") %> <%#Convert.ToBoolean(Eval("Required"))?"<strong style='color: red'>(*)</strong>":"" %> </span>

                                    <dx:ASPxLabel ID="lblBankId" runat="server" Text='<%#Eval("BankId") %>' Visible="false"></dx:ASPxLabel>
                                    <dx:ASPxLabel ID="lbTaskId" runat="server" Text='<%#Eval("TaskId") %>' Visible="false"></dx:ASPxLabel>
                                    <dx:ASPxLabel ID="lblType" runat="server" Text='<%#Eval("ControllType") %>' Visible="false"></dx:ASPxLabel>
                                    <dx:ASPxLabel ID="lblRequired" runat="server" Text='<%#Convert.ToBoolean(Eval("Required"))?"1":"0" %>' Visible="false"></dx:ASPxLabel>
                                    <ul class="t-answer">
                                        <asp:Repeater ID="rptraloi" runat="server" DataSource='<%# getAnswer(Convert.ToInt32(Eval("BankId"))) %>'>
                                            <ItemTemplate>
                                                <div class="col-xs-12 col-md-12">
                                                    <div style='display: block; margin-top: 5px'>
                                                        <div class="form-check form-check-inline form-anwser">
                                                            <input style="width: 18px; height: 18px" class="form-check-input rd-answer" type='<%# Eval("ControllType") %>'
                                                                onchange="updateAns('<%# Eval("TaskId") %>','<%# Eval("BankId") %>','<%# Eval("AnsId") %>')" name='<%# "inlineRadio"+Eval("BankId") %>' id='<%# "inlineRadio"+Eval("BankId")%>' />
                                                            <label class="form-check-label" style="font-weight: normal" for='<%# "inlineRadio"+Eval("BankId")%>'><%# Eval("AnsContent") %></label>
                                                            <img style="width: 175px; display: block" <%# !string.IsNullOrEmpty(Convert.ToString(Eval("AnsPath"))) ? "" : "style='display:none'" %> src='<%# Eval("AnsPath") %>' alt="" />
                                                        </div>
                                                    </div>
                                                </div>
                                            </ItemTemplate>
                                        </asp:Repeater>
                                     <%-- <li>
                                            <dx:ASPxRadioButtonList ID="radioAnswer" Width="100%" Border-BorderStyle="None" DataSource='<%# getAnswer(Convert.ToInt32(Eval("BankId"))) %>' Enabled='<%# !string.IsNullOrEmpty(Convert.ToString(Eval("AnsId"))) || !string.IsNullOrEmpty(Convert.ToString(Eval("AnsContent"))) ? false: true %>' Value='<%#Eval("AnsId") %>' ValueField="AnsId" runat="server" ValueType="System.Int32" TextField="AnsContent" Visible='<%# Eval("cklist") %>'>
                                                
                                            </dx:ASPxRadioButtonList>
                                            <dx:ASPxCheckBoxList ID="cboxAnser" Width="100%" Border-BorderStyle="None" DataSource='<%# getAnswer(Convert.ToInt32(Eval("BankId"))) %>' Enabled='<%# !string.IsNullOrEmpty(Convert.ToString(Eval("AnsId"))) || !string.IsNullOrEmpty(Convert.ToString(Eval("AnsContent"))) ? false: true %>' ValueField="AnsId" runat="server" ValueType="System.Int32" TextField="AnsContent" Visible='<%# Eval("ckbox") %>'></dx:ASPxCheckBoxList>
                                              <dx:ASPxMemo ID="txtAnswer" ToolTip='<%#Eval("AnsId") %>' NullText="Nhập vào câu trả lời của bạn" Rows="4" Width="100%" runat="server" Text='<%# Eval("AnsContent") %>' Visible='<%# Eval("txbox") %>'></dx:ASPxMemo>
                                        </li>--%>
                                    </ul>
                                </li>
                            </ItemTemplate>
                        </asp:Repeater>
                    </ul>
                </div>
            </div>
        </div>
        <asp:Panel ID="Panel2" runat="server">
            <div class="col-xs-12" style="margin: 0px; padding: 0; height: 70px">
                <div class="row">
                    <div class="col-xs-7">
                        <a onclick="finishtest();" style="background: #ff8c95; height: 32px; border-radius: 5px; line-height: 32px; width: 100px; display: inline-block; text-align: center; color: #fff; margin-top: 20px; border: 1px solid #fcf5e3;">Hoàn thành</a>
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
        </asp:Panel>
    </div>
    <dx:ASPxCallbackPanel ID="aspxCallback" runat="server" Width="100%" SettingsLoadingPanel-Enabled="false" SettingsLoadingPanel-ShowImage="false" SettingsLoadingPanel-Text=""
        ClientInstanceName="aspxCallback" OnCallback="aspxCallback_Callback">
        <ClientSideEvents EndCallback="OnEndCallback" />
        <PanelCollection>
            <dx:PanelContent runat="server">
            </dx:PanelContent>
        </PanelCollection>
    </dx:ASPxCallbackPanel>
    <dx:ASPxPopupControl ID="pcAlert" runat="server" Width="320" CloseAction="CloseButton" CloseOnEscape="true" Modal="True"
        PopupHorizontalAlign="WindowCenter" PopupVerticalAlign="WindowCenter" ClientInstanceName="pcAlert" ShowCloseButton="false"
        HeaderText="Thông báo" AllowDragging="True" PopupAnimationType="None" EnableViewState="False" AutoUpdatePosition="true">
        <ContentCollection>
            <dx:PopupControlContentControl runat="server">
                <dx:ASPxPanel ID="Panel1" runat="server" DefaultButton="btOK">
                    <PanelCollection>
                        <dx:PanelContent runat="server">
                            <div class="row marginTop10">
                                <div class="col-xs-12 text-center">
                                    Bạn đã hoàn thành bài khảo sát
                                </div>
                            </div>
                            <div class="row marginTop20">
                                <div class="col-md-12 text-center">
                                    <dx:ASPxButton ID="btOK" runat="server" Text="Đồng ý" Width="80px" AutoPostBack="False" CssClass="btn btn-primary">
                                        <ClientSideEvents Click="function(s, e) { document.location.href='/Pages/Employee/Tasks.aspx';}" />
                                    </dx:ASPxButton>
                                </div>
                            </div>
                            <div class="row marginTop20"></div>
                        </dx:PanelContent>
                    </PanelCollection>
                </dx:ASPxPanel>
            </dx:PopupControlContentControl>
        </ContentCollection>
        <ContentStyle>
            <Paddings PaddingBottom="5px" />
        </ContentStyle>
    </dx:ASPxPopupControl>
    <style type="text/css">
        .t-question {
            padding: 0;
            margin: 0;
            float: left;
        }

        .content {
            margin-bottom: 0px !important;
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
        .dxEditors_edtRadioButtonUnchecked_Moderno,.dxWeb_edtCheckBoxUnchecked_Moderno {
            background-size: 40px !important
        }
        .dxEditors_edtRadioButtonChecked_Moderno,.dxWeb_edtCheckBoxChecked_Moderno {
            background-size: 40px !important;
            width: 19px;
            height: 19px;
        }
        .dxWeb_edtCheckBoxChecked_Moderno {
            background-position: -20px !important;
        }
        .dxEditors_edtRadioButtonUnchecked_Moderno {
            background-position: -20px -20px !important;
            width: 20px !important;
            height: 20px !important;
        }
        .dxWeb_edtCheckBoxUnchecked_Moderno {
            background-position: 0px 0px !important;
            width: 20px !important;
            height: 20px !important;
        }
        .memo table {
            height: 50px;
            width: 100%;
            overflow: hidden
        }

        .dxeImage_Moderno {
            height: 70px;
            border-radius: 10px;
            /*transform: rotate(90deg);*/
            width: auto;
            overflow: hidden;
        }

        .dxeFocused_Moderno, .dxeRadioButtonList_Moderno {
            border: none !important;
            box-shadow: none !important;
            -webkit-box-shadow: none !important
        }
    </style>
</asp:Content>