<%@ Page Title="" Language="C#" MasterPageFile="~/Layout.master" AutoEventWireup="true" CodeBehind="PGAssesment.aspx.cs" Inherits="WebApplication.Pages.Suppervisor.PGAssesment" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Content" runat="server">
    <script type="text/javascript">
        function assessPg(id) {
            var div = document.getElementById("PC" + id);
            if (div) {
                var _pg = $(div);
                _pg.animate({
                    opacity: '1',
                    height: '100%'
                });
            }
            _pg.addClass("pointer-events")
        }
        function assessClose(id) {
            var div = document.getElementById("PC" + id);
            if (div) {
                var _pg = $(div);
                _pg.animate({
                    opacity: '0',
                    height: '0'
                });
                _pg.removeClass("pointer-events")
            }
        }
        function assessSave(obj) {
            cp.PerformCallback('assessSave;' + obj);
        }
        function OnEndCallback(s, e) {
            if (s.cpAlert != '') {
                alert(s.cpAlert);
            }
        }
    </script>
    <style type="text/css">
        .dxeRadioButtonList_Moderno td{
            float: left!important
        }
    </style>
    <div class="row text-center">
        <h3>PG Assesment</h3>
        <div class="col-xs-12" style="margin: 10px 0px">
            <asp:Repeater ID="RpAssessment" runat="server">
                <ItemTemplate>
                    <div style="float: left; position: relative; z-index: 1; background: #fff; margin-top: 35px; width: 100%; border-radius: 5px; box-shadow: 5px 5px 0px rgba(220, 220, 220, 0.1); border: 1px solid #f54e03">
                        <div style="position: absolute; top: -30px; left: calc(50% - 45px);">
                            <dx:ASPxBinaryImage ID="BinaryImg" runat="server" ClientInstanceName="BinaryImg"
                                Value='<%# Eval("BinaryImg") %>' ImageAlign="AbsMiddle">
                            </dx:ASPxBinaryImage>
                        </div>
                        <div class="col-xs-12 text-center" style="padding-top: 40px">
                            <h5><%# Eval("EmployeeName") %></h5>
                        </div>
                        <div class="col-xs-6 text-left" style="padding-top: 10px">
                            <a>Product Knowledge: <%# Convert.ToString(Eval("ProductKnowledge")).Split('_')[0] %></a>
                        </div>
                        <div class="col-xs-6 text-left" style="padding-top: 10px">
                            <a>Uniform: <%# Convert.ToString(Eval("Uniform")).Split('_')[0] %></a>
                        </div>
                        <div class="col-xs-12 text-right" style="padding: 10px 0; padding-right: 15px">
                            <%# (Convert.ToInt32(Convert.ToString(Eval("ProductKnowledge")).Split('_')[2])+Convert.ToInt32(Convert.ToString(Eval("Uniform")).Split('_')[2])) > 0 ? "<a style='color: #000; background: #fbd789; padding: 7px 25px; border-radius: 16px; line-height: 32px;' onclick='assessPg("+Container.ItemIndex+");'>Điểm đánh giá: "+(Convert.ToInt32(Convert.ToString(Eval("ProductKnowledge")).Split('_')[2]) + Convert.ToInt32(Convert.ToString(Eval("Uniform")).Split('_')[2]))+"</a>" : "<a style='color: #000; background: #fbd789; padding: 7px 25px; border-radius: 16px; line-height: 32px;' onclick='assessPg("+Container.ItemIndex+");'>Đánh giá</a>" %>
                        </div>
                    </div>
                    <div id='<%# "PC" + Container.ItemIndex %>' style="float: left; pointer-events: none; opacity: 0; height: 0; position: relative; z-index: 0; width: 96%; margin: 0 2%; margin-bottom: 20px; margin-top: -15px; border-radius: 5px; box-shadow: 5px 5px 0px rgba(220, 220, 220, 0.1); border: 1px solid #71aef7; border-top: none">
                        <div class="col-xs-12" style="margin-top: 30px">
                            <p style="text-align: left; margin-bottom: 0; font-weight: 600">Product Knowledge:</p>
                            <dx:ASPxRadioButtonList ID="rb1" ValueType="System.Int32" ClientInstanceName="rb1" Border-BorderWidth="0" RepeatDirection="Horizontal" runat="server">
                                <ClientSideEvents SelectedIndexChanged="function(s,e){cp.PerformCallback('radio1;'+s.GetValue());}" />
                                <Items>
                                    <dx:ListEditItem Value="1" Text="1"></dx:ListEditItem>
                                    <dx:ListEditItem Value="2" Text="2"></dx:ListEditItem>
                                    <dx:ListEditItem Value="3" Text="3"></dx:ListEditItem>
                                    <dx:ListEditItem Value="4" Text="4"></dx:ListEditItem>
                                    <dx:ListEditItem Value="5" Text="5"></dx:ListEditItem>
                                    <dx:ListEditItem Value="6" Text="6"></dx:ListEditItem>
                                    <dx:ListEditItem Value="7" Text="7"></dx:ListEditItem>
                                    <dx:ListEditItem Value="8" Text="8"></dx:ListEditItem>
                                    <dx:ListEditItem Value="9" Text="9"></dx:ListEditItem>
                                    <dx:ListEditItem Value="10" Text="10"></dx:ListEditItem>
                                </Items>
                            </dx:ASPxRadioButtonList>
                        </div>
                        <div class="col-xs-12" style="display: none">
                            <p style="text-align: left; margin-bottom: 0; font-weight: 600">Sales Skill:</p>
                            <dx:ASPxRadioButtonList ID="rb2" ClientInstanceName="rb2" ValueType="System.Int32" Border-BorderWidth="0" RepeatDirection="Horizontal" runat="server">
                                <ClientSideEvents SelectedIndexChanged="function(s,e){cp.PerformCallback('radio2;'+s.GetValue());}" />
                                <Items>
                                    <dx:ListEditItem Value="1" Text="1"></dx:ListEditItem>
                                    <dx:ListEditItem Value="2" Text="2"></dx:ListEditItem>
                                    <dx:ListEditItem Value="3" Text="3"></dx:ListEditItem>
                                    <dx:ListEditItem Value="4" Text="4"></dx:ListEditItem>
                                </Items>
                            </dx:ASPxRadioButtonList>
                        </div>
                        <div class="col-xs-12" style="margin-bottom: 10px">
                            <p style="text-align: left; margin-bottom: 0; font-weight: 600">Uniform:</p>
                            <dx:ASPxRadioButtonList ID="rb3" ClientInstanceName="rb3" ValueType="System.Int32" Border-BorderWidth="0" RepeatDirection="Horizontal" runat="server">
                                <ClientSideEvents SelectedIndexChanged="function(s,e){cp.PerformCallback('radio3;'+s.GetValue());}" />
                                <Items>
                                    <dx:ListEditItem Value="5" Text="Yes"></dx:ListEditItem>
                                    <dx:ListEditItem Value="0" Text="No"></dx:ListEditItem>
                                </Items>
                            </dx:ASPxRadioButtonList>
                        </div>
                        <div class="col-xs-12 memo" style="margin-bottom: 15px; display: none">
                            <p style="text-align: left; margin-bottom: 0; font-weight: 600">Ghi chú:</p>
                            <dx:ASPxMemo runat="server" ID="txnote" ClientInstanceName="txnote"></dx:ASPxMemo>
                        </div>
                        <div class="col-xs-12" style="height: 22px">
                            <ul style="margin: 0; padding: 0; text-align: center; width: 100%">
                                <li style="list-style: none; display: inline-block; margin: 0 5px;">
                                    <a onclick="assessClose('<%# Container.ItemIndex %>')" style="padding: 5px 15px; border: 1px solid #d7d7d7">Hủy</a>
                                </li>
                                <li style="list-style: none; display: inline-block; margin: 0 5px;">
                                    <a onclick="assessSave('<%# Eval("AssessObject") %>')" style="padding: 5px 15px; border: 1px solid #d7d7d7">Lưu</a>
                                </li>
                            </ul>
                        </div>
                    </div>
                </ItemTemplate>
            </asp:Repeater>
        </div>
        <dx:ASPxHiddenField ID="hdfKey" ClientInstanceName="hdfKey" runat="server"></dx:ASPxHiddenField>
    </div>
    <dx:ASPxCallback ID="ASPxCallbackPanel1" runat="server" ClientInstanceName="cp"
        OnCallback="ASPxCallbackPanel1_Callback">
        <ClientSideEvents EndCallback="OnEndCallback" />
    </dx:ASPxCallback>
    <dx:ASPxPopupControl ID="pcAlert" runat="server" Width="420" CloseAction="CloseButton" CloseOnEscape="true" Modal="True"
        PopupHorizontalAlign="WindowCenter" PopupVerticalAlign="WindowCenter" ClientInstanceName="pcAlert" ShowCloseButton="false"
        HeaderText="Thông báo" AllowDragging="True" PopupAnimationType="None" EnableViewState="False" AutoUpdatePosition="true">
        <ContentCollection>
            <dx:PopupControlContentControl runat="server">
                <dx:ASPxPanel ID="Panel1" runat="server" DefaultButton="btOK">
                    <PanelCollection>
                        <dx:PanelContent runat="server">
                            <div class="row marginTop20">
                                <div class="col-md-12 text-center">
                                    <dx:ASPxButton ID="btOK" runat="server" Text="OK" Width="80px" ClientVisible="false" AutoPostBack="False">
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
    <style type="text/css">
        .dxEditors_edtRadioButtonUnchecked_Moderno {
            background-size: 40px !important
        }

        .dxEditors_edtRadioButtonUnchecked_Moderno {
            background-position: -20px -20px !important;
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

        .pointer-events {
            pointer-events: inherit !important
        }
    </style>
</asp:Content>