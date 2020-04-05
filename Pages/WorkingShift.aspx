<%@ Page Title="Working Shift" Language="C#" MasterPageFile="~/Layout.master" AutoEventWireup="true" CodeBehind="WorkingShift.aspx.cs" Inherits="WebApplication.Pages.WorkingShift" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Content" runat="server">
    <script type="text/javascript">
        function OnEndCallback(s, e) {
            if (s.cpAlert == 'Thành công') {
                alert(s.cpAlert);
                pcShift.Hide();
            }
        }
        function ShowShift() {
            pcShift.Show();
        }

        function edit(Id) {
            pcShift.Show();
            cp.PerformCallback('edit,' + Id);
        }

        function del(Id) {
            cp.PerformCallback('delete,' + Id);
        }
    </script>
    <script type="text/javascript">
        $(document).ready(function () {
            $("#TopPanel_NavMenu ul li:eq(6)").addClass("dxm-selected");
        })
    </script>
    <dx:ASPxCallbackPanel ID="ASPxCallbackPanel1" runat="server" Width="100%"
        ClientInstanceName="cp" OnCallback="ASPxCallbackPanel1_Callback">
        <ClientSideEvents EndCallback="OnEndCallback" />
        <PanelCollection>
            <dx:PanelContent runat="server">
                <div class="row container marginTop20">
                    <div class="col-md-12 box-content">
                        <div class="row">
                            <div class="col-md-12 marginTop20 marginBot20">
                                <dx:ASPxButton ID="btImport" AutoPostBack="false" runat="server" CssClass="btn btn-primary" Text="Add New">
                                    <ClientSideEvents Click="function(s, e) { ShowShift(); }" />
                                </dx:ASPxButton>
                                <br />
                                <br />
                                <dx:ASPxGridView runat="server" AutoGenerateColumns="False" ID="gvTimeShift" ClientInstanceName="gvTimeShift" Width="100%"
                                    KeyFieldName="Id">
                                    <Styles>
                                        <Header Wrap="True" VerticalAlign="Middle" HorizontalAlign="Center"></Header>
                                        <Cell Wrap="True" VerticalAlign="Middle"></Cell>
                                        <AlternatingRow Enabled="true" />
                                    </Styles>
                                    <Columns>
                                        <dx:GridViewDataColumn VisibleIndex="0" Caption="No.">
                                            <CellStyle HorizontalAlign="Center"></CellStyle>
                                            <DataItemTemplate>
                                                <%# Container.ItemIndex+1 %>
                                            </DataItemTemplate>
                                            <EditFormSettings Visible="False" />
                                        </dx:GridViewDataColumn>
                                        <dx:GridViewDataColumn VisibleIndex="1" Caption="Shift Name">
                                            <CellStyle HorizontalAlign="Center"></CellStyle>
                                            <DataItemTemplate>
                                                <a style="cursor: pointer" onclick='<%# "edit("+Eval("Id")+")" %>'><%# Eval("ShiftName") %></a>
                                            </DataItemTemplate>
                                            <EditFormSettings Visible="False" />
                                        </dx:GridViewDataColumn>
                                        <dx:GridViewDataTextColumn FieldName="FromTime" Caption="From Time" VisibleIndex="2">
                                        </dx:GridViewDataTextColumn>
                                        <dx:GridViewDataTextColumn FieldName="ToTime" Caption="To Time" VisibleIndex="3">
                                        </dx:GridViewDataTextColumn>
                                        <dx:GridViewDataColumn VisibleIndex="4" Caption=" ">
                                            <CellStyle HorizontalAlign="Center"></CellStyle>
                                            <DataItemTemplate>
                                                <a style="cursor: pointer" onclick='<%# "del("+Eval("Id")+")" %>'>Xóa</a>
                                            </DataItemTemplate>
                                            <EditFormSettings Visible="False" />
                                        </dx:GridViewDataColumn>
                                    </Columns>
                                </dx:ASPxGridView>
                            </div>
                        </div>
                    </div>
                </div>
                <dx:ASPxPopupControl ID="pcShift" runat="server" Width="600" CloseAction="CloseButton" CloseOnEscape="true" Modal="True"
                    PopupHorizontalAlign="WindowCenter" PopupVerticalAlign="WindowCenter" ClientInstanceName="pcShift"
                    HeaderText="Shift" AllowDragging="True" PopupAnimationType="None" EnableViewState="False" AutoUpdatePosition="true">
                    <ContentCollection>
                        <dx:PopupControlContentControl runat="server">
                            <dx:ASPxPanel ID="ASPxPanel1" runat="server" DefaultButton="btOK">
                                <PanelCollection>
                                    <dx:PanelContent runat="server">
                                        <dx:ASPxFormLayout runat="server" ID="ASPxFormLayout2" Width="100%" Height="100%">
                                            <Items>
                                                <dx:LayoutItem Caption="Shift Name">
                                                    <LayoutItemNestedControlCollection>
                                                        <dx:LayoutItemNestedControlContainer>
                                                            <dx:ASPxButtonEdit runat="server" ID="txShift">
                                                                <ClearButton DisplayMode="OnHover"></ClearButton>
                                                            </dx:ASPxButtonEdit>
                                                        </dx:LayoutItemNestedControlContainer>
                                                    </LayoutItemNestedControlCollection>
                                                </dx:LayoutItem>
                                                <dx:LayoutItem Caption="Shift From">
                                                    <LayoutItemNestedControlCollection>
                                                        <dx:LayoutItemNestedControlContainer>
                                                            <div class="row">
                                                                <div class="col-md-6">
                                                                    <dx:ASPxComboBox runat="server" ID="cbfrom1" NullText="Hour" ClientInstanceName="cbfrom1" EnableCallbackMode="true" CallbackPageSize="10"
                                                                        DropDownStyle="DropDownList">
                                                                        <ClearButton DisplayMode="OnHover"></ClearButton>
                                                                        <Items>
                                                                            <dx:ListEditItem Text="01" Value="01" />
                                                                            <dx:ListEditItem Text="02" Value="02" />
                                                                            <dx:ListEditItem Text="03" Value="03" />
                                                                            <dx:ListEditItem Text="04" Value="04" />
                                                                            <dx:ListEditItem Text="05" Value="05" />
                                                                            <dx:ListEditItem Text="06" Value="06" />
                                                                            <dx:ListEditItem Text="07" Value="07" />
                                                                            <dx:ListEditItem Text="08" Value="08" />
                                                                            <dx:ListEditItem Text="09" Value="09" />
                                                                            <dx:ListEditItem Text="10" Value="10" />
                                                                            <dx:ListEditItem Text="11" Value="11" />
                                                                            <dx:ListEditItem Text="12" Value="12" />
                                                                            <dx:ListEditItem Text="13" Value="13" />
                                                                            <dx:ListEditItem Text="14" Value="14" />
                                                                            <dx:ListEditItem Text="15" Value="15" />
                                                                            <dx:ListEditItem Text="16" Value="16" />
                                                                            <dx:ListEditItem Text="17" Value="17" />
                                                                            <dx:ListEditItem Text="18" Value="18" />
                                                                            <dx:ListEditItem Text="19" Value="19" />
                                                                            <dx:ListEditItem Text="20" Value="20" />
                                                                            <dx:ListEditItem Text="21" Value="21" />
                                                                            <dx:ListEditItem Text="22" Value="22" />
                                                                            <dx:ListEditItem Text="23" Value="23" />
                                                                            <dx:ListEditItem Text="24" Value="24" />
                                                                        </Items>
                                                                    </dx:ASPxComboBox>
                                                                </div>
                                                                <div class="col-md-6">
                                                                    <dx:ASPxComboBox runat="server" ID="cbfrom2" NullText="Minute" ClientInstanceName="cbfrom2" EnableCallbackMode="true" CallbackPageSize="10"
                                                                        DropDownStyle="DropDownList">
                                                                        <ClearButton DisplayMode="OnHover"></ClearButton>
                                                                        <Items>
                                                                            <dx:ListEditItem Text="00" Value="00" />
                                                                            <dx:ListEditItem Text="01" Value="01" />
                                                                            <dx:ListEditItem Text="02" Value="02" />
                                                                            <dx:ListEditItem Text="03" Value="03" />
                                                                            <dx:ListEditItem Text="04" Value="04" />
                                                                            <dx:ListEditItem Text="05" Value="05" />
                                                                            <dx:ListEditItem Text="06" Value="06" />
                                                                            <dx:ListEditItem Text="07" Value="07" />
                                                                            <dx:ListEditItem Text="08" Value="08" />
                                                                            <dx:ListEditItem Text="09" Value="09" />
                                                                            <dx:ListEditItem Text="10" Value="10" />
                                                                            <dx:ListEditItem Text="11" Value="11" />
                                                                            <dx:ListEditItem Text="12" Value="12" />
                                                                            <dx:ListEditItem Text="13" Value="13" />
                                                                            <dx:ListEditItem Text="14" Value="14" />
                                                                            <dx:ListEditItem Text="15" Value="15" />
                                                                            <dx:ListEditItem Text="16" Value="16" />
                                                                            <dx:ListEditItem Text="17" Value="17" />
                                                                            <dx:ListEditItem Text="18" Value="18" />
                                                                            <dx:ListEditItem Text="19" Value="19" />
                                                                            <dx:ListEditItem Text="20" Value="20" />
                                                                            <dx:ListEditItem Text="21" Value="21" />
                                                                            <dx:ListEditItem Text="22" Value="22" />
                                                                            <dx:ListEditItem Text="23" Value="23" />
                                                                            <dx:ListEditItem Text="24" Value="24" />
                                                                            <dx:ListEditItem Text="25" Value="25" />
                                                                            <dx:ListEditItem Text="26" Value="26" />
                                                                            <dx:ListEditItem Text="27" Value="27" />
                                                                            <dx:ListEditItem Text="28" Value="28" />
                                                                            <dx:ListEditItem Text="29" Value="29" />
                                                                            <dx:ListEditItem Text="30" Value="30" />
                                                                            <dx:ListEditItem Text="31" Value="31" />
                                                                            <dx:ListEditItem Text="32" Value="32" />
                                                                            <dx:ListEditItem Text="33" Value="33" />
                                                                            <dx:ListEditItem Text="34" Value="34" />
                                                                            <dx:ListEditItem Text="35" Value="35" />
                                                                            <dx:ListEditItem Text="36" Value="36" />
                                                                            <dx:ListEditItem Text="37" Value="37" />
                                                                            <dx:ListEditItem Text="38" Value="38" />
                                                                            <dx:ListEditItem Text="39" Value="39" />
                                                                            <dx:ListEditItem Text="40" Value="40" />
                                                                            <dx:ListEditItem Text="41" Value="41" />
                                                                            <dx:ListEditItem Text="42" Value="42" />
                                                                            <dx:ListEditItem Text="43" Value="43" />
                                                                            <dx:ListEditItem Text="44" Value="44" />
                                                                            <dx:ListEditItem Text="45" Value="45" />
                                                                            <dx:ListEditItem Text="46" Value="46" />
                                                                            <dx:ListEditItem Text="47" Value="47" />
                                                                            <dx:ListEditItem Text="48" Value="48" />
                                                                            <dx:ListEditItem Text="49" Value="49" />
                                                                            <dx:ListEditItem Text="50" Value="50" />
                                                                            <dx:ListEditItem Text="51" Value="51" />
                                                                            <dx:ListEditItem Text="52" Value="52" />
                                                                            <dx:ListEditItem Text="53" Value="53" />
                                                                            <dx:ListEditItem Text="54" Value="54" />
                                                                            <dx:ListEditItem Text="55" Value="55" />
                                                                            <dx:ListEditItem Text="56" Value="56" />
                                                                            <dx:ListEditItem Text="57" Value="57" />
                                                                            <dx:ListEditItem Text="58" Value="58" />
                                                                            <dx:ListEditItem Text="59" Value="59" />
                                                                            <dx:ListEditItem Text="60" Value="60" />
                                                                        </Items>
                                                                    </dx:ASPxComboBox>
                                                                </div>
                                                            </div>
                                                        </dx:LayoutItemNestedControlContainer>
                                                    </LayoutItemNestedControlCollection>
                                                </dx:LayoutItem>
                                                <dx:LayoutItem Caption="Shift To">
                                                    <LayoutItemNestedControlCollection>
                                                        <dx:LayoutItemNestedControlContainer>
                                                            <div class="row">
                                                                <div class="col-md-6">
                                                                    <dx:ASPxComboBox runat="server" ID="cbto1" NullText="Hour" ClientInstanceName="cbto1" EnableCallbackMode="true" CallbackPageSize="10"
                                                                        DropDownStyle="DropDownList">
                                                                        <ClearButton DisplayMode="OnHover"></ClearButton>
                                                                        <Items>
                                                                            <dx:ListEditItem Text="01" Value="01" />
                                                                            <dx:ListEditItem Text="02" Value="02" />
                                                                            <dx:ListEditItem Text="03" Value="03" />
                                                                            <dx:ListEditItem Text="04" Value="04" />
                                                                            <dx:ListEditItem Text="05" Value="05" />
                                                                            <dx:ListEditItem Text="06" Value="06" />
                                                                            <dx:ListEditItem Text="07" Value="07" />
                                                                            <dx:ListEditItem Text="08" Value="08" />
                                                                            <dx:ListEditItem Text="09" Value="09" />
                                                                            <dx:ListEditItem Text="10" Value="10" />
                                                                            <dx:ListEditItem Text="11" Value="11" />
                                                                            <dx:ListEditItem Text="12" Value="12" />
                                                                            <dx:ListEditItem Text="13" Value="13" />
                                                                            <dx:ListEditItem Text="14" Value="14" />
                                                                            <dx:ListEditItem Text="15" Value="15" />
                                                                            <dx:ListEditItem Text="16" Value="16" />
                                                                            <dx:ListEditItem Text="17" Value="17" />
                                                                            <dx:ListEditItem Text="18" Value="18" />
                                                                            <dx:ListEditItem Text="19" Value="19" />
                                                                            <dx:ListEditItem Text="20" Value="20" />
                                                                            <dx:ListEditItem Text="21" Value="21" />
                                                                            <dx:ListEditItem Text="22" Value="22" />
                                                                            <dx:ListEditItem Text="23" Value="23" />
                                                                            <dx:ListEditItem Text="24" Value="24" />
                                                                        </Items>
                                                                    </dx:ASPxComboBox>
                                                                </div>
                                                                <div class="col-md-6">
                                                                    <dx:ASPxComboBox runat="server" ID="cbto2" NullText="Minute" ClientInstanceName="cbto2" EnableCallbackMode="true" CallbackPageSize="10"
                                                                        DropDownStyle="DropDownList">
                                                                        <ClearButton DisplayMode="OnHover"></ClearButton>
                                                                        <Items>
                                                                            <dx:ListEditItem Text="00" Value="00" />
                                                                            <dx:ListEditItem Text="01" Value="01" />
                                                                            <dx:ListEditItem Text="02" Value="02" />
                                                                            <dx:ListEditItem Text="03" Value="03" />
                                                                            <dx:ListEditItem Text="04" Value="04" />
                                                                            <dx:ListEditItem Text="05" Value="05" />
                                                                            <dx:ListEditItem Text="06" Value="06" />
                                                                            <dx:ListEditItem Text="07" Value="07" />
                                                                            <dx:ListEditItem Text="08" Value="08" />
                                                                            <dx:ListEditItem Text="09" Value="09" />
                                                                            <dx:ListEditItem Text="10" Value="10" />
                                                                            <dx:ListEditItem Text="11" Value="11" />
                                                                            <dx:ListEditItem Text="12" Value="12" />
                                                                            <dx:ListEditItem Text="13" Value="13" />
                                                                            <dx:ListEditItem Text="14" Value="14" />
                                                                            <dx:ListEditItem Text="15" Value="15" />
                                                                            <dx:ListEditItem Text="16" Value="16" />
                                                                            <dx:ListEditItem Text="17" Value="17" />
                                                                            <dx:ListEditItem Text="18" Value="18" />
                                                                            <dx:ListEditItem Text="19" Value="19" />
                                                                            <dx:ListEditItem Text="20" Value="20" />
                                                                            <dx:ListEditItem Text="21" Value="21" />
                                                                            <dx:ListEditItem Text="22" Value="22" />
                                                                            <dx:ListEditItem Text="23" Value="23" />
                                                                            <dx:ListEditItem Text="24" Value="24" />
                                                                            <dx:ListEditItem Text="25" Value="25" />
                                                                            <dx:ListEditItem Text="26" Value="26" />
                                                                            <dx:ListEditItem Text="27" Value="27" />
                                                                            <dx:ListEditItem Text="28" Value="28" />
                                                                            <dx:ListEditItem Text="29" Value="29" />
                                                                            <dx:ListEditItem Text="30" Value="30" />
                                                                            <dx:ListEditItem Text="31" Value="31" />
                                                                            <dx:ListEditItem Text="32" Value="32" />
                                                                            <dx:ListEditItem Text="33" Value="33" />
                                                                            <dx:ListEditItem Text="34" Value="34" />
                                                                            <dx:ListEditItem Text="35" Value="35" />
                                                                            <dx:ListEditItem Text="36" Value="36" />
                                                                            <dx:ListEditItem Text="37" Value="37" />
                                                                            <dx:ListEditItem Text="38" Value="38" />
                                                                            <dx:ListEditItem Text="39" Value="39" />
                                                                            <dx:ListEditItem Text="40" Value="40" />
                                                                            <dx:ListEditItem Text="41" Value="41" />
                                                                            <dx:ListEditItem Text="42" Value="42" />
                                                                            <dx:ListEditItem Text="43" Value="43" />
                                                                            <dx:ListEditItem Text="44" Value="44" />
                                                                            <dx:ListEditItem Text="45" Value="45" />
                                                                            <dx:ListEditItem Text="46" Value="46" />
                                                                            <dx:ListEditItem Text="47" Value="47" />
                                                                            <dx:ListEditItem Text="48" Value="48" />
                                                                            <dx:ListEditItem Text="49" Value="49" />
                                                                            <dx:ListEditItem Text="50" Value="50" />
                                                                            <dx:ListEditItem Text="51" Value="51" />
                                                                            <dx:ListEditItem Text="52" Value="52" />
                                                                            <dx:ListEditItem Text="53" Value="53" />
                                                                            <dx:ListEditItem Text="54" Value="54" />
                                                                            <dx:ListEditItem Text="55" Value="55" />
                                                                            <dx:ListEditItem Text="56" Value="56" />
                                                                            <dx:ListEditItem Text="57" Value="57" />
                                                                            <dx:ListEditItem Text="58" Value="58" />
                                                                            <dx:ListEditItem Text="59" Value="59" />
                                                                            <dx:ListEditItem Text="60" Value="60" />
                                                                        </Items>
                                                                    </dx:ASPxComboBox>
                                                                </div>
                                                            </div>
                                                        </dx:LayoutItemNestedControlContainer>
                                                    </LayoutItemNestedControlCollection>
                                                </dx:LayoutItem>
                                                <dx:LayoutItem ShowCaption="False">
                                                    <LayoutItemNestedControlCollection>
                                                        <dx:LayoutItemNestedControlContainer>
                                                            <div class="row marginTop20">
                                                                <div class="col-md-12 text-center">
                                                                    <dx:ASPxButton ID="ASPxButton2" runat="server" Text="Submit" Width="80px" AutoPostBack="False" CssClass="btn btn-success">
                                                                        <ClientSideEvents Click="function(s, e) { cp.PerformCallback('save');pcShift.Hide();}" />
                                                                    </dx:ASPxButton>
                                                                    <asp:HiddenField ID="hfedit" runat="server" />
                                                                    &nbsp;
                                                                    <dx:ASPxButton ID="ASPxButton3" runat="server" Text="Cancel" Width="80px" AutoPostBack="False">
                                                                        <ClientSideEvents Click="function(s, e) { pcShift.Hide(); }" />
                                                                    </dx:ASPxButton>
                                                                </div>
                                                            </div>
                                                        </dx:LayoutItemNestedControlContainer>
                                                    </LayoutItemNestedControlCollection>
                                                </dx:LayoutItem>
                                            </Items>
                                        </dx:ASPxFormLayout>
                                    </dx:PanelContent>
                                </PanelCollection>
                            </dx:ASPxPanel>
                        </dx:PopupControlContentControl>
                    </ContentCollection>
                    <ContentStyle>
                        <Paddings PaddingBottom="5px" />
                    </ContentStyle>
                </dx:ASPxPopupControl>
            </dx:PanelContent>
        </PanelCollection>
    </dx:ASPxCallbackPanel>
</asp:Content>