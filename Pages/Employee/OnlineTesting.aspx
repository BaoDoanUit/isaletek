<%@ Page Title="" Language="C#" MasterPageFile="~/Layout.master" AutoEventWireup="true" CodeBehind="OnlineTesting.aspx.cs" Inherits="WebApplication.Pages.Employee.OnlineTesting" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Content" runat="server">
    <script src="/Pages/Employee/js/countdown.js"></script>
    <script src="/Pages/Employee/js/jquery.countdown.js"></script>
    <script type="text/javascript">
        function OnEndCallback(s, e) {
            if (s.cpAlert != '') {
                var tmp = s.cpAlert;
                if (tmp.includes('finished')) {
                    var val = tmp.split(';');

                    lbNumTN.SetText(val[0]);
                    lbNumTL.SetText(val[1]);
                    
                    delete s.cpAlert;
                    pcAlert.Show();
                }
                else
                    alert(s.cpAlert);
            }
        }
        function finishtest() {
            cp.PerformCallback('finishtest;');
        }
        function updateAns(qId, aKey, index) {
            var pages = document.getElementById("aPage" + index);
            if (pages) {
                var _pa = $(pages);
                _pa.addClass("active");
            }
            cp.PerformCallback('updateAns;' + qId + ';' + aKey);
        }
        window.addEventListener("orientationchange", function () {
            rotate();
        }, false);
        function rotate() {
            if (window.matchMedia("(orientation: portrait)").matches) {
                //add ngang
            }
            if (window.matchMedia("(orientation: landscape)").matches) {
                //add dung
            }
        }
    </script>
    <script type="text/javascript">
        $(document).ready(function () {
            $("a.aPage").click(function () {
                var aq = $(this).attr("qid");
                $.each($('.lst-q').find('div.num'), function (i, o) {
                    var dq = $(o).attr("id")
                    if (dq == aq) {
                        window.location.href = window.location.pathname + "#" + dq;
                    }
                });
            });
        });
    </script>
    <div class="row text-center">
        <div class="col-xs-12" style="margin: 0px; padding: 0; height: 70px">
            <div class="row">
                <div class="col-xs-7 text-left">
                    <h3 style="padding-left: 15px; line-height: 24px; font-size:16px!important; color:#f56373">
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
                <div class="col-xs-10 lst-q" style="border: 1px solid #d7d7d7; border-left: 0; height: 66vh; padding-bottom: 20px; overflow: auto">
                    <asp:Repeater runat="server" ID="rptQuestion">
                        <ItemTemplate>
                            <div class='<%# "num num" + Eval("numHeight") %>' id='<%#"question"+ Eval("QuestionId") %>'>
                                <div class="col-xs-12" style="border: 1px solid #d7d7d7; margin-top: 15px; border-radius: 5px; box-shadow: 2px 2px 0px rgba(220, 220, 220, 0.5);">
                                    <p style="margin-top: 10px; text-align: left"><b style="text-decoration: underline"><%#"Câu hỏi "+ (Container.ItemIndex + 1) +":&nbsp;"%></b><%# Eval("QuestionName") %></p>
                                    <b style="text-decoration: underline; display: block; text-align: left">Chọn câu trả lời:</b>
                                    <ul class="t-answer">
                                        <asp:Repeater ID="rptraloi" runat="server" DataSource='<%# LoadTraLoi(Eval("QuestionId").ToString()) %>'>
                                            <ItemTemplate>
                                                <li class="form-check form-check-inline form-anwser">
                                                    <a style="font-size: 16px"><%# Container.ItemIndex == 0 ? "A" : (Container.ItemIndex == 1 ? "B" : (Container.ItemIndex == 2 ? "C" : (Container.ItemIndex == 3 ? "D" : (Container.ItemIndex == 4 ? "E" : "F")))) %></a>
                                                    <input class="form-check-input rd-answer" type='radio'
                                                        onchange="updateAns('<%# Eval("LogId") %>','<%# Eval("ansKey") %>','<%# Eval("QuestionId") %>')"
                                                         name='<%# "inlineRadio"+Eval("QuestionId") %>' id='<%# "inlineRadio"+Eval("QuestionId")+Eval("ansKey") %>' />
                                                    <label class="form-check-label" style="font-weight: normal" for='<%# "inlineRadio"+Eval("QuestionId")  +Eval("ansKey")%>'><%# Eval("ansName") %></label>
                                                </li>
                                            </ItemTemplate>
                                        </asp:Repeater>
                                    </ul>
                                </div>
                            </div>
                        </ItemTemplate>
                    </asp:Repeater>
                </div>
                <div class="col-xs-2" style="height: 66vh; overflow: auto">
                    <ul class="t-number">
                        <asp:Repeater ID="rpNumber" runat="server">
                            <ItemTemplate>
                                <li><a qid='<%#"question"+ Eval("QuestionId") %>' class="aPage" id='aPage<%# Eval("QuestionId") %>'><%# Container.ItemIndex +1 %></a></li>
                            </ItemTemplate>
                        </asp:Repeater>
                    </ul>
                </div>
            </div>
        </div>
        <div class="col-xs-7 text-left" style="display: none">
            <a style="background: #639ff5; margin-right: 10px; height: 26px; border-radius: 13px; line-height: 26px; width: 80px; display: inline-block; text-align: center; color: #fff">Back</a>
            <a style="background: #639ff5; height: 26px; border-radius: 13px; line-height: 26px; width: 80px; display: inline-block; text-align: center; color: #fff">Next</a>
        </div>
        <div class="col-xs-12 text-center">
            <a onclick="finishtest();" style="background: #08bf17; height: 32px; border-radius: 16px; line-height: 32px;width: 100px; display: inline-block; text-align: center; color: #fff">Hoàn thành</a>
        </div>
    </div>
    <dx:ASPxPopupControl ID="pcAlert" runat="server" Width="420" CloseAction="CloseButton" CloseOnEscape="true" Modal="True"
        PopupHorizontalAlign="WindowCenter" PopupVerticalAlign="WindowCenter" ClientInstanceName="pcAlert" ShowCloseButton="false"
        HeaderText="Thông báo" AllowDragging="True" PopupAnimationType="None" EnableViewState="False" AutoUpdatePosition="true">
        <ContentCollection>
            <dx:PopupControlContentControl runat="server">
                <dx:ASPxPanel ID="Panel1" runat="server" DefaultButton="btOK">
                    <PanelCollection>
                        <dx:PanelContent runat="server">
                            <div class="row marginTop10">
                                <div class="col-xs-6 col-md-6 text-right">
                                    Tổng số câu:&nbsp;<dx:ASPxLabel runat="server" ID="lbNumTN" ClientInstanceName="lbNumTN"></dx:ASPxLabel>
                                </div>
                                <div class="col-xs-6 col-md-6 text-right">
                                    Số câu đúng:&nbsp;<dx:ASPxLabel runat="server" ID="lbNumTL" ClientInstanceName="lbNumTL"></dx:ASPxLabel>
                                </div>
                            </div>
                            <div class="row marginTop10 d-none">
                                <div class="col-xs-12 col-md-12 text-center">
                                    <dx:ASPxLabel runat="server" ID="lbtestfail" ClientInstanceName="lbtestfail" CssClass="text-danger"></dx:ASPxLabel>
                                </div>
                            </div>
                            <div class="row marginTop20">
                                <div class="col-md-12 text-center">
                                    <dx:ASPxButton ID="btOK" runat="server" Text="OK" Width="80px" AutoPostBack="False" CssClass="btn btn-success">
                                        <ClientSideEvents Click="function(s, e) { document.location.href='/Pages/Employee/TestingList.aspx?f=1';}" />
                                    </dx:ASPxButton>
                                    &nbsp;
                                    <dx:ASPxButton ID="btCancel" runat="server" Text="Cancel" Width="80px" ClientVisible="false" AutoPostBack="False">
                                        <ClientSideEvents Click="function(s, e) { pcAlert.Hide(); }" />
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
    <dx:ASPxCallback ID="ASPxCallbackPanel1" runat="server" ClientInstanceName="cp"
        OnCallback="ASPxCallbackPanel1_Callback">
        <ClientSideEvents EndCallback="OnEndCallback" />
    </dx:ASPxCallback>
    <dx:ASPxLabel runat="server" ID="lbtotal" ClientInstanceName="lbtotal" Text="10" ClientVisible="false"></dx:ASPxLabel>
    <dx:ASPxLabel runat="server" ID="lbpercent" ClientInstanceName="lbpercent" Text="10" ClientVisible="false"></dx:ASPxLabel>
    <dx:ASPxLabel runat="server" ID="lbtest" ClientInstanceName="lbtest" Text="0" ClientVisible="false"></dx:ASPxLabel>
    <dx:ASPxLabel runat="server" ID="lbtrue" ClientInstanceName="lbtrue" Text="0" ClientVisible="false"></dx:ASPxLabel>
    <dx:ASPxLabel runat="server" ID="lbfinish" ClientInstanceName="lbfinish" ClientVisible="false"></dx:ASPxLabel>
    <style type="text/css">
        .num380 {
            height: 380px
        }

        .t-number {
            margin: 0;
            padding: 0;
        }

            .t-number li {
                width: 100%;
                margin-bottom: 8px;
                float: left;
                list-style: none
            }

                .t-number li a {
                    width: 85%;
                    float: left;
                    border-radius: 5px;
                    height: 26px;
                    line-height: 26px;
                    color: #000;
                    margin-left: 5%;
                    border: 1px solid #94d259;
                }

                    .t-number li a.active {
                        width: 85%;
                        background-color: #94d259;
                        color: #fff;
                    }

        .t-answer {
            margin: 0;
            padding: 20px 0px;
        }

            .t-answer li {
                list-style: none;
                width: 100%;
                border-bottom: 1px dashed #d7d7d7;
                text-align: left;
                line-height: 22px;
                padding: 8px 0;
                float: left;
            }

                .t-answer li:first-child {
                    padding-top: 0;
                }

        .content {
            margin-bottom: 0
        }

        .t-answer li:last-child {
            border-bottom: none
        }

        .lst-q p, .lst-q label {
            font-size: 14px !important
        }

        .lst-q label {
            font-weight: 400 !important
        }

        .t-answer li label, .t-answer li input {
            display: inline
        }

        .t-answer li input {
            margin-right: 5px;
            height: 15px;
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
    </style>
</asp:Content>