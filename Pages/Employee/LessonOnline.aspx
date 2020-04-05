<%@ Page Title="Online Training" Language="C#" MasterPageFile="~/Mobile.Master" AutoEventWireup="true" CodeBehind="LessonOnline.aspx.cs" Inherits="WebApplication.Pages.Employee.LessonOnline" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Content" runat="server">
    <script type="text/javascript">
        function OnEndCallback(s, e) {
            if (s.cpAlert != '') {
                alert(s.cpAlert);
            }
        }
    </script>
    <style type="text/css">
        .thumbnail > img {
            width: auto !important;
            max-height: 70vh !important;
        }
    </style>
    <dx:ASPxCallbackPanel ID="ASPxCallbackPanel1" runat="server" Width="100%"
        ClientInstanceName="cp" OnCallback="ASPxCallbackPanel1_Callback">
        <ClientSideEvents EndCallback="OnEndCallback" />
        <PanelCollection>
            <dx:PanelContent runat="server">
                <div class="row marginTop10">
                    <div class="col-xs-12 col-md-12">
                        <dx:ASPxLabel runat="server" ID="lbLessionName"></dx:ASPxLabel>
                    </div>
                </div>
                <div class="row marginTop10">
                    <div class="col-xs-12 col-md-12 text-center">
                        <asp:Literal ID="ltrDocs" runat="server"></asp:Literal>
                        <asp:Repeater runat="server" ID="rptLessions">
                            <ItemTemplate>
                                <asp:PlaceHolder ID="plhImage" Visible='<%# Convert.ToBoolean(Eval("IsImage")) %>' runat="server">
                                    <div class="thumbnail">
                                        <img src='<%#Eval("SlideContent") %>' class="img-responsive" alt="" />
                                    </div>
                                </asp:PlaceHolder>
                                <asp:PlaceHolder ID="plhVideo" runat="server" Visible="false">
                                    <div class="thumbnail">
                                        <a href='<%# "../.." + Eval("SlideContent") %>' id="hlVideo"></a>
                                    </div>
                                    <script type="text/javascript">
                                        flowplayer("hlVideo", "flowplayer/flowplayer-3.2.7.swf", {
                                            clip: {
                                                autoPlay: true,
                                                autoBuffering: true,
                                            }
                                        });
                                    </script>
                                </asp:PlaceHolder>
                                <asp:PlaceHolder ID="plhmp4" Visible='<%# Convert.ToBoolean(Eval("IsVideo")) %>' runat="server">
                                    <video controls='controls' style="width: 100%" autoplay="autoplay">
                                        <source src='<%# Eval("SlideContent") %>' type='video/mp4' />
                                    </video>
                                </asp:PlaceHolder>
                            </ItemTemplate>
                        </asp:Repeater>
                    </div>
                </div>
                <div class="row marginTop5" id="pages" runat="server">
                    <div class="col-xs-3 col-md-3 text-left">
                        <dx:ASPxButton runat="server" ID="btPrev" ClientInstanceName="btPrev" Text="<<" CssClass="btn btn-warning" AutoPostBack="false" ToolTip="Previous">
                            <ClientSideEvents Click="function(s,e){cp.PerformCallback('Prev');}" />
                        </dx:ASPxButton>
                    </div>
                    <div class="col-xs-6 col-md-6 text-center">
                        <dx:ASPxLabel runat="server" ID="lbTotalPage" ClientInstanceName="lbTotalPage"></dx:ASPxLabel>
                    </div>
                    <div class="col-xs-3 col-md-3 text-right">
                        <dx:ASPxButton runat="server" ID="btNext" ClientInstanceName="btNext" Text=">>" CssClass="btn btn-warning" AutoPostBack="false" ToolTip="Next">
                            <ClientSideEvents Click="function(s,e){cp.PerformCallback('Next');}" />
                        </dx:ASPxButton>
                    </div>
                </div>
                <asp:HiddenField ID="hfSelected" runat="server" />
                <asp:HiddenField ID="hfTotal" runat="server" />
            </dx:PanelContent>
        </PanelCollection>
    </dx:ASPxCallbackPanel>
</asp:Content>
