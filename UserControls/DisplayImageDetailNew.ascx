<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="DisplayImageDetailNew.ascx.cs" Inherits="WebApplication.UserControls.DisplayImageDetailNew" %>
<dx:ASPxCallbackPanel ID="aspxCallbackLoadImage" runat="server" Width="100%"
    ClientInstanceName="aspxCallbackLoadImage" OnCallback="aspxCallbackLoadImage_Callback">
    <PanelCollection>
        <dx:PanelContent runat="server">
            <div class="col-md-6">
                <%= (userInfo.EmployeeId==6203 || userInfo.EmployeeId==7603) ? "":"<a id='lnkDelete' style='color: red; font-weight: bold; float: right; cursor: pointer' onclick='IsDelete()'>[XÓA HÌNH]</a>" %>
                <asp:LinkButton ID="LinkButton1" Style="color: black; font-weight: bold; float: right" runat="server">|</asp:LinkButton>
                <%= (userInfo.EmployeeId==6203 || userInfo.EmployeeId==7603) ? "":"<a id='lnkChoose' style='color: blue; font-weight: bold; float: right; cursor: pointer' onclick='IsExport()'>[CHỌN HÌNH]</a>" %>
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
                                                    <%--<dx:ASPxBinaryImage ID="BinaryImg" runat="server" ClientInstanceName="BinaryImg"
                                                        Value='<%# Eval("BinaryImg") %>' ImageAlign="AbsMiddle" CssClass="img-responsive">
                                                    </dx:ASPxBinaryImage>--%>
                                                    <img src='<%# Eval("PhotoUrl") %>' alt="" width="300" />
                                                    <div style="margin-top: 4px;">
                                                        <dx:ASPxLabel runat="server" ID="lbComment" Text='<%# Eval("Comment") %>'></dx:ASPxLabel>
                                                    </div>
                                                    <div class="row" style="margin: 0;">
                                                        <dx:ASPxCheckBox ID="ckchoose" runat="server" Checked="true" Visible="false"></dx:ASPxCheckBox>
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
                                                    <%--<dx:ASPxBinaryImage ID="BinaryImg" runat="server" ClientInstanceName="BinaryImg"
                                                        Value='<%# Eval("BinaryImg") %>' ImageAlign="AbsMiddle" CssClass="img-responsive">
                                                    </dx:ASPxBinaryImage>--%>
                                                    <img src='<%# Eval("PhotoUrl") %>' alt="" width="300" />
                                                    <div style="margin-top: 4px;">
                                                        <dx:ASPxLabel runat="server" ID="lbComment" Text='<%# Eval("Comment") %>'></dx:ASPxLabel>
                                                    </div>
                                                    <div class="row" style="margin: 0;">
                                                        <dx:ASPxCheckBox ID="ckchoose" Visible="false" runat="server" Checked='<%#Convert.ToBoolean(Eval("isExport")) %>'></dx:ASPxCheckBox>
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
                                                    <%--<dx:ASPxBinaryImage ID="BinaryImg" runat="server" ClientInstanceName="BinaryImg"
                                                        Value='<%# Eval("BinaryImg") %>' ImageAlign="AbsMiddle" CssClass="img-responsive">
                                                    </dx:ASPxBinaryImage>--%>
                                                    <img src='<%# Eval("PhotoUrl") %>' alt="" width="300" />
                                                    <div style="margin-top: 4px;">
                                                        <dx:ASPxLabel runat="server" ID="lbComment" Text='<%# Eval("Comment") %>'></dx:ASPxLabel>
                                                    </div>
                                                    <div class="row" style="margin: 0;">
                                                        <dx:ASPxCheckBox ID="ckchoose" Visible="false" runat="server" Checked='<%#Convert.ToBoolean(Eval("isExport")) %>'></dx:ASPxCheckBox>

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
                                                    <%--<dx:ASPxBinaryImage ID="BinaryImg" runat="server" ClientInstanceName="BinaryImg"
                                                        Value='<%# Eval("BinaryImg") %>' ImageAlign="AbsMiddle" CssClass="img-responsive">
                                                    </dx:ASPxBinaryImage>--%>
                                                    <img src='<%# Eval("PhotoUrl") %>' alt="" width="300" />
                                                    <div style="margin-top: 4px;">
                                                        <dx:ASPxLabel runat="server" ID="lbComment" Text='<%# Eval("Comment") %>'></dx:ASPxLabel>
                                                    </div>
                                                    <div class="row" style="margin: 0;">
                                                        <dx:ASPxCheckBox ID="ckchoose" Visible="false" runat="server" Checked='<%#Convert.ToBoolean(Eval("isExport")) %>'></dx:ASPxCheckBox>
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
                                                    <%--<dx:ASPxBinaryImage ID="BinaryImg" runat="server" ClientInstanceName="BinaryImg"
                                                        Value='<%# Eval("BinaryImg") %>' ImageAlign="AbsMiddle" CssClass="img-responsive">
                                                    </dx:ASPxBinaryImage>--%>
                                                    <img src='<%# Eval("PhotoUrl") %>' alt="" width="300" />
                                                    <div style="margin-top: 4px;">
                                                        <dx:ASPxLabel runat="server" ID="lbComment" Text='<%# Eval("Comment") %>'></dx:ASPxLabel>
                                                    </div>
                                                    <div class="row" style="margin: 0;">
                                                        <dx:ASPxCheckBox ID="ckchoose" Visible="false" runat="server" Checked='<%#Convert.ToBoolean(Eval("isExport")) %>'></dx:ASPxCheckBox>
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
                                                    <%--<dx:ASPxBinaryImage ID="BinaryImg" runat="server" ClientInstanceName="BinaryImg"
                                                        Value='<%# Eval("BinaryImg") %>' ImageAlign="AbsMiddle" CssClass="img-responsive">
                                                    </dx:ASPxBinaryImage>--%>
                                                    <img src='<%# Eval("PhotoUrl") %>' alt="" width="300" />
                                                    <div style="margin-top: 4px;">
                                                        <dx:ASPxLabel runat="server" ID="lbComment" Text='<%# Eval("Comment") %>'></dx:ASPxLabel>
                                                    </div>
                                                    <div class="row" style="margin: 0; display: none">
                                                        <dx:ASPxCheckBox ID="ckchoose" Visible="false" runat="server" Checked="true"></dx:ASPxCheckBox>
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
        </dx:PanelContent>
    </PanelCollection>
</dx:ASPxCallbackPanel>