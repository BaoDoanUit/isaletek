<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="DisplayImageDetail.ascx.cs" Inherits="WebApplication.UserControls.DisplayImageDetail" %>

<dx:ASPxCallbackPanel ID="aspxCallbackLoadImage" runat="server" Width="100%"
    ClientInstanceName="aspxCallbackLoadImage" OnCallback="aspxCallbackLoadImage_Callback">
    <PanelCollection>
        <dx:PanelContent runat="server">
            <div class="col-md-6">
                <%= userInfo.EmployeeId==6203 ? "":"<a id='lnkDelete' style='color: red; font-weight: bold; float: right; cursor: pointer' onclick='IsDelete()'>[XÓA HÌNH]</a>" %>
                <asp:LinkButton ID="LinkButton1" Style="color: black; font-weight: bold; float: right" runat="server">|</asp:LinkButton>
                <%= userInfo.EmployeeId==6203 ? "":"<a id='lnkChoose' style='color: blue; font-weight: bold; float: right; cursor: pointer' onclick='IsExport()'>[CHỌN HÌNH]</a>" %>
                <dx:ASPxPageControl ID="ASPxPageControl1" runat="server" ActiveTabIndex="0" Width="100%">
                    <TabPages>
                        <dx:TabPage Text="REF">
                            <ContentCollection>
                                <dx:ContentControl runat="server">
                                    <asp:Repeater runat="server" ID="rptREF">
                                        <HeaderTemplate>
                                            <div class="row">
                                        </HeaderTemplate>
                                        <ItemTemplate>
                                            <div class="col-md-3">
                                                <div class="thumbnail" ondblclick="OpenPopup('REF','<%#Eval("ShopId") %>','<%#Eval("ReportDate","{0:yyyy-MM-dd}") %>')">
                                                    <dx:ASPxBinaryImage ID="BinaryImg" runat="server" ClientInstanceName="BinaryImg"
                                                        Value='<%# Eval("BinaryImg") %>' ImageAlign="AbsMiddle" CssClass="img-responsive">
                                                    </dx:ASPxBinaryImage>
                                                    <div style="margin-top: 4px;">
                                                        <dx:ASPxLabel runat="server" ID="lbComment" Text='<%# Eval("Comment") %>'></dx:ASPxLabel>
                                                    </div>
                                                    <div class="row" style="margin: 0;">
                                                        <dx:ASPxCheckBox ID="ckchoose" runat="server" Checked='<%#Convert.ToBoolean(Eval("isExport")) %>'></dx:ASPxCheckBox>
                                                        <asp:Label ID="lblId" runat="server" Text='<%#Eval("Id") %>' Visible="false"></asp:Label>
                                                    </div>
                                                </div>
                                            </div>
                                        </ItemTemplate>
                                        <FooterTemplate>
                                            </div>
                                                               
                                        </FooterTemplate>
                                    </asp:Repeater>
                                </dx:ContentControl>
                            </ContentCollection>
                        </dx:TabPage>
                        <dx:TabPage Text="WM">
                            <ContentCollection>
                                <dx:ContentControl runat="server">
                                    <asp:Repeater runat="server" ID="rptWM">
                                        <HeaderTemplate>
                                            <div class="row">
                                        </HeaderTemplate>
                                        <ItemTemplate>
                                            <div class="col-md-3">
                                                <div class="thumbnail" ondblclick="OpenPopup('WM','<%#Eval("ShopId") %>','<%#Eval("ReportDate","{0:yyyy-MM-dd}") %>')">
                                                    <dx:ASPxBinaryImage ID="BinaryImg" runat="server" ClientInstanceName="BinaryImg"
                                                        Value='<%# Eval("BinaryImg") %>' ImageAlign="AbsMiddle" CssClass="img-responsive">
                                                    </dx:ASPxBinaryImage>
                                                    <div style="margin-top: 4px;">
                                                        <dx:ASPxLabel runat="server" ID="lbComment" Text='<%# Eval("Comment") %>'></dx:ASPxLabel>
                                                    </div>
                                                    <div class="row" style="margin: 0;">
                                                        <dx:ASPxCheckBox ID="ckchoose" runat="server" Checked='<%#Convert.ToBoolean(Eval("isExport")) %>'></dx:ASPxCheckBox>
                                                        <asp:Label ID="lblId" runat="server" Text='<%#Eval("Id") %>' Visible="false"></asp:Label>
                                                    </div>
                                                </div>
                                            </div>
                                        </ItemTemplate>
                                        <FooterTemplate>
                                            </div>
                                                                
                                        </FooterTemplate>
                                    </asp:Repeater>
                                </dx:ContentControl>
                            </ContentCollection>
                        </dx:TabPage>
                        <dx:TabPage Text="RAC">
                            <ContentCollection>
                                <dx:ContentControl runat="server">
                                    <asp:Repeater runat="server" ID="rptRAC">
                                        <HeaderTemplate>
                                            <div class="row">
                                        </HeaderTemplate>
                                        <ItemTemplate>
                                            <div class="col-md-3">
                                                <div class="thumbnail" ondblclick="OpenPopup('RAC','<%#Eval("ShopId") %>','<%#Eval("ReportDate","{0:yyyy-MM-dd}") %>')">
                                                    <dx:ASPxBinaryImage ID="BinaryImg" runat="server" ClientInstanceName="BinaryImg"
                                                        Value='<%# Eval("BinaryImg") %>' ImageAlign="AbsMiddle" CssClass="img-responsive">
                                                    </dx:ASPxBinaryImage>
                                                    <div style="margin-top: 4px;">
                                                        <dx:ASPxLabel runat="server" ID="lbComment" Text='<%# Eval("Comment") %>'></dx:ASPxLabel>
                                                    </div>
                                                    <div class="row" style="margin: 0;">
                                                        <dx:ASPxCheckBox ID="ckchoose" runat="server" Checked='<%#Convert.ToBoolean(Eval("isExport")) %>'></dx:ASPxCheckBox>

                                                        <asp:Label ID="lblId" runat="server" Text='<%#Eval("Id") %>' Visible="false"></asp:Label>
                                                    </div>
                                                </div>
                                            </div>
                                        </ItemTemplate>
                                        <FooterTemplate>
                                            </div>
                                                               
                                        </FooterTemplate>
                                    </asp:Repeater>
                                </dx:ContentControl>
                            </ContentCollection>
                        </dx:TabPage>
                        <dx:TabPage Text="VC">
                            <ContentCollection>
                                <dx:ContentControl runat="server">
                                    <asp:Repeater runat="server" ID="rptVC">
                                        <HeaderTemplate>
                                            <div class="row">
                                        </HeaderTemplate>
                                        <ItemTemplate>
                                            <div class="col-md-3">
                                                <div class="thumbnail" ondblclick="OpenPopup('VC','<%#Eval("ShopId") %>','<%#Eval("ReportDate","{0:yyyy-MM-dd}") %>')">
                                                    <dx:ASPxBinaryImage ID="BinaryImg" runat="server" ClientInstanceName="BinaryImg"
                                                        Value='<%# Eval("BinaryImg") %>' ImageAlign="AbsMiddle" CssClass="img-responsive">
                                                    </dx:ASPxBinaryImage>
                                                    <div style="margin-top: 4px;">
                                                        <dx:ASPxLabel runat="server" ID="lbComment" Text='<%# Eval("Comment") %>'></dx:ASPxLabel>
                                                    </div>
                                                    <div class="row" style="margin: 0;">
                                                        <dx:ASPxCheckBox ID="ckchoose" runat="server" Checked='<%#Convert.ToBoolean(Eval("isExport")) %>'></dx:ASPxCheckBox>
                                                        <asp:Label ID="lblId" runat="server" Text='<%#Eval("Id") %>' Visible="false"></asp:Label>
                                                    </div>
                                                </div>
                                            </div>
                                        </ItemTemplate>
                                        <FooterTemplate>
                                            </div>
                                                                
                                        </FooterTemplate>
                                    </asp:Repeater>
                                </dx:ContentControl>
                            </ContentCollection>
                        </dx:TabPage>
                        <dx:TabPage Text="RC">
                            <ContentCollection>
                                <dx:ContentControl runat="server">
                                    <asp:Repeater runat="server" ID="rptRC">
                                        <HeaderTemplate>
                                            <div class="row">
                                        </HeaderTemplate>
                                        <ItemTemplate>
                                            <div class="col-md-3">
                                                <div class="thumbnail" ondblclick="OpenPopup('RC','<%#Eval("ShopId") %>','<%#Eval("ReportDate","{0:yyyy-MM-dd}") %>')">
                                                    <dx:ASPxBinaryImage ID="BinaryImg" runat="server" ClientInstanceName="BinaryImg"
                                                        Value='<%# Eval("BinaryImg") %>' ImageAlign="AbsMiddle" CssClass="img-responsive">
                                                    </dx:ASPxBinaryImage>
                                                    <div style="margin-top: 4px;">
                                                        <dx:ASPxLabel runat="server" ID="lbComment" Text='<%# Eval("Comment") %>'></dx:ASPxLabel>
                                                    </div>
                                                    <div class="row" style="margin: 0;">
                                                        <dx:ASPxCheckBox ID="ckchoose" runat="server" Checked='<%#Convert.ToBoolean(Eval("isExport")) %>'></dx:ASPxCheckBox>
                                                        <asp:Label ID="lblId" runat="server" Text='<%#Eval("Id") %>' Visible="false"></asp:Label>
                                                    </div>
                                                </div>
                                            </div>
                                        </ItemTemplate>
                                        <FooterTemplate>
                                            </div>
                                        </FooterTemplate>
                                    </asp:Repeater>
                                </dx:ContentControl>
                            </ContentCollection>
                        </dx:TabPage>
                        <dx:TabPage Text="AP">
                            <ContentCollection>
                                <dx:ContentControl runat="server">
                                    <asp:Repeater runat="server" ID="rptAP">
                                        <HeaderTemplate>
                                            <div class="row">
                                        </HeaderTemplate>
                                        <ItemTemplate>
                                            <div class="col-md-3">
                                                <div class="thumbnail" ondblclick="OpenPopup('AP','<%#Eval("ShopId") %>','<%#Eval("ReportDate","{0:yyyy-MM-dd}") %>')">
                                                    <dx:ASPxBinaryImage ID="BinaryImg" runat="server" ClientInstanceName="BinaryImg"
                                                        Value='<%# Eval("BinaryImg") %>' ImageAlign="AbsMiddle" CssClass="img-responsive">
                                                    </dx:ASPxBinaryImage>
                                                    <div style="margin-top: 4px;">
                                                        <dx:ASPxLabel runat="server" ID="lbComment" Text='<%# Eval("Comment") %>'></dx:ASPxLabel>
                                                    </div>
                                                    <div class="row" style="margin: 0;">
                                                        <dx:ASPxCheckBox ID="ckchoose" runat="server" Checked='<%#Convert.ToBoolean(Eval("isExport")) %>'></dx:ASPxCheckBox>
                                                        <asp:Label ID="lblId" runat="server" Text='<%#Eval("Id") %>' Visible="false"></asp:Label>
                                                    </div>
                                                </div>
                                            </div>
                                        </ItemTemplate>
                                        <FooterTemplate>
                                            </div> 
                                        </FooterTemplate>
                                    </asp:Repeater>
                                </dx:ContentControl>
                            </ContentCollection>
                        </dx:TabPage>
                    </TabPages>
                </dx:ASPxPageControl>
            </div>
            <div class="col-md-6" style="overflow: hidden; overflow-y: auto; max-height: 400px">
                <asp:Repeater runat="server" ID="rpppsilde">
                    <ItemTemplate>
                        <div style="width: 100%; padding: 5px; border: 1px solid #aaa; margin-bottom: 20px">
                            <h3><%#ShopName %></h3>
                            <div style="width: 100%; background-size: 100%; background-image: url(/Content/Images/line.png); float: left; height: 5px; margin-bottom: 10px;">
                            </div>
                            <table style="width: 100%">
                                <tr>
                                    <td style="text-align: center"><%# Convert.ToDateTime(rpDate).AddMonths(-1).ToString("Y",System.Globalization.CultureInfo.CreateSpecificCulture("en")) %> </td>
                                    <td style="text-align: center"><%# Convert.ToDateTime(rpDate).ToString("Y",System.Globalization.CultureInfo.CreateSpecificCulture("en")) %>  </td>
                                </tr>
                                <tr>
                                    <td style="text-align: center; padding: 5px; border: 1px solid #aaa">
                                        <dx:ASPxBinaryImage ID="BinaryImg1" Style="width: 150px; height: 120px;" runat="server" ClientInstanceName="BinaryImg"
                                            Value='<%# Eval("img1") %>' ImageAlign="AbsMiddle" CssClass="img-responsive">
                                        </dx:ASPxBinaryImage>
                                    </td>
                                    <td style="text-align: center; padding: 5px; border: 1px solid #aaa">
                                        <dx:ASPxBinaryImage ID="ASPxBinaryImage2" Style="width: 150px; height: 120px;" runat="server" ClientInstanceName="BinaryImg"
                                            Value='<%# Eval("img2") %>' ImageAlign="AbsMiddle" CssClass="img-responsive">
                                        </dx:ASPxBinaryImage>
                                    </td>
                                </tr>
                                <tr>
                                    <td style="text-align: center; padding: 5px; border: 1px solid #aaa">
                                        <dx:ASPxBinaryImage ID="ASPxBinaryImage3" Style="width: 150px; height: 120px;" runat="server" ClientInstanceName="BinaryImg"
                                            Value='<%# Eval("img3") %>' ImageAlign="AbsMiddle" CssClass="img-responsive">
                                        </dx:ASPxBinaryImage>
                                    </td>
                                    <td style="text-align: center; padding: 5px; border: 1px solid #aaa">
                                        <dx:ASPxBinaryImage ID="ASPxBinaryImage4" Style="width: 150px; height: 120px;" runat="server" ClientInstanceName="BinaryImg"
                                            Value='<%# Eval("img4") %>' ImageAlign="AbsMiddle" CssClass="img-responsive">
                                        </dx:ASPxBinaryImage>
                                    </td>
                                </tr>
                            </table>
                        </div>
                    </ItemTemplate>
                </asp:Repeater>
            </div>
        </dx:PanelContent>
    </PanelCollection>
</dx:ASPxCallbackPanel>
