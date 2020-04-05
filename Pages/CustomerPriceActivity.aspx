<%@ Page Title="Market Information" Language="C#" MasterPageFile="~/Layout.master" AutoEventWireup="true" CodeBehind="CustomerPriceActivity.aspx.cs" Inherits="WebApplication.Pages.CustomerPriceActivity" %>
<asp:Content ID="Content1" ContentPlaceHolderID="Content" runat="server">
    <style>
        fieldset.scheduler-border {
            background-color: rgba(227, 229, 229, 0.09);
            border: 1px groove #ddd !important;
            padding: 0 1.4em 1.4em 1.4em !important;
            margin: 0 0 1.5em 0 !important;
            -webkit-box-shadow: 0px 0px 0px 0px #000;
            box-shadow: 0px 0px 0px 0px #000;
        }

        legend.scheduler-border {
            font-size: 1.2em !important;
            font-weight: bold !important;
            text-align: left !important;
            width: auto;
            padding: 35px 10px 0 10px;
            border-bottom: none;
        }

        #map {
            height: 300px;
            width: 100%;
        }

        .gm-style-iw gm-style-iw-c {
            max-height: 155px !important
        }

        .gm-style-iw-d {
            max-height: 145px !important
        }
        .dxEditors_edtRadioButtonUnchecked_Moderno {
            background-position: -18px -18px !important;
            width: 18px !important;
            height: 18px !important;
        }
        .dxEditors_edtRadioButtonUnchecked_Moderno,.dxEditors_edtRadioButtonChecked_Moderno {
            background-size: 36px !important;
        }
        .dxEditors_edtRadioButtonChecked_Moderno {
            background-position: 0 0 !important;
            width: 18px !important;
            height: 18px !important;
        }
        .dxeRoot_Moderno td:first-child{
            width: 85px
        }
        .dxeRoot_Moderno td:last-child{
            width: calc(100% - 85px)
        }
        .dxeRadioButtonList_Moderno td{
            width: auto!important
        }
        .dxeRadioButtonList_Moderno {
            border: none !important
        }

        .dxeCaption_Moderno {
            font-weight: 600;
        }
        .dxeFocused_Moderno{
            box-shadow: none!important; 
            webkit-box-shadow: none!important;
        }
        .dxeRadioButtonList_Moderno td.dxe, .dxeCheckBoxList_Moderno td.dxe {
            padding: 2px 6px 8px 12px!important;
        }.dxWebKitFamily .dxeCaptionCell_Moderno.dxeCaptionVATSys.dxeRadioButtonListCTypeSys {
            padding-top: 7px!important;
        }
    </style>
    <script type="text/javascript">
        $(document).ready(function () {
            
        });
        function monthChanged(s, e) {
            aspCallbackPanel.PerformCallback('month|' + s.GetValue())
        }

        function OnEndCallback(s, e) {
            
        }
    </script>
    <dx:ASPxCallbackPanel ID="aspCallbackPanel" runat="server" Width="100%" ClientSideEvents-EndCallback="OnEndCallback"
        ClientInstanceName="aspCallbackPanel" OnCallback="aspCallbackPanel_Callback">
        <ClientSideEvents EndCallback="OnEndCallback"></ClientSideEvents>
        <PanelCollection>
            <dx:PanelContent runat="server">
                <div class="row">
                    <div class="col-md-12">
                        <div class="filter">
                            <fieldset class="scheduler-border">
                                <legend class="scheduler-border">Search</legend>
                                <div class="row">
                                    <div class="col-md-6" style="display: none">
                                        <dx:ASPxComboBox Caption="Term *" runat="server" ID="cbTerm" Width="100%" DataSourceID="odsTerm" ValueField="Id" ValueType="System.Int32" NullText="--All--"
                                            ClientInstanceName="cbTerm" DropDownStyle="DropDownList">
                                            <ClearButton DisplayMode="OnHover"></ClearButton>
                                            <Columns>
                                                <dx:ListBoxColumn FieldName="TermCycle" Caption="Term" />
                                            </Columns>
                                        </dx:ASPxComboBox>
                                        <asp:ObjectDataSource ID="odsTerm" runat="server" SelectMethod="getList" TypeName="LogicTier.Controllers.TermController"></asp:ObjectDataSource>
                                    </div>
                                    <div class="col-md-12" style="display: none">
                                        <dx:ASPxComboBox Caption="Area" runat="server" Width="100%" ID="cbArea" DataSourceID="odsArea" ValueField="Area" ValueType="System.String" NullText="--All--"
                                            ClientInstanceName="cbArea" EnableCallbackMode="true" DropDownStyle="DropDownList">
                                            <ClearButton DisplayMode="OnHover"></ClearButton>
                                            <ClientSideEvents ValueChanged="function(s,e){cbRegion.PerformCallback()}" />
                                            <Columns>
                                                <dx:ListBoxColumn FieldName="Area" Caption="Area" />
                                            </Columns>
                                        </dx:ASPxComboBox>
                                        <asp:ObjectDataSource ID="odsArea" runat="server" SelectMethod="getDivision" TypeName="LogicTier.Controllers.OutletBL">
                                            <SelectParameters>
                                                <asp:Parameter DefaultValue="Area" Name="fieldName" Type="String" />
                                                <asp:Parameter Name="fieldValue" Type="String" />
                                                <asp:Parameter DefaultValue="Area" Name="fieldDisplay" Type="String" />
                                            </SelectParameters>
                                        </asp:ObjectDataSource>
                                    </div>
                                    <div class="col-md-6" style="display: none">
                                        <dx:ASPxComboBox runat="server" ID="cbProduct" Caption="Product *" ValueField="Product" Width="100%"
                                            ValueType="System.String" NullText="--All--" ClientInstanceName="cbProduct" DataSourceID="odsProduct">
                                            <ClearButton DisplayMode="OnHover"></ClearButton>
                                            <Columns>
                                                <dx:ListBoxColumn FieldName="Product" />
                                            </Columns>
                                        </dx:ASPxComboBox>
                                        <asp:ObjectDataSource ID="odsProduct" runat="server" SelectMethod="getDivision" TypeName="LogicTier.Controllers.ProductsBL">
                                            <SelectParameters>
                                                <asp:Parameter DefaultValue="Product" Name="fieldName" Type="String" />
                                                <asp:Parameter Name="fieldValue" Type="String" />
                                                <asp:Parameter DefaultValue="Product" Name="fieldDisplay" Type="String" />
                                            </SelectParameters>
                                        </asp:ObjectDataSource>
                                    </div>
                                </div>
                                <div class="row marginTop10">
                                    <div class="col-md-4">
                                        <dx:ASPxRadioButtonList runat="server" Caption="Brand/Dealer/ALT" ID="rdType" RepeatColumns="3" RepeatDirection="Vertical">
                                            <RadioButtonStyle Font-Size="10px"></RadioButtonStyle>
                                            <Items>
                                                <dx:ListEditItem Text="Dealer" Selected="true" Value="Dealer" />
                                                <dx:ListEditItem Text="Brand" Value="Brand" />
                                                <dx:ListEditItem Text="ALT" Value="Hitachi" />
                                            </Items>
                                        </dx:ASPxRadioButtonList>
                                    </div>
                                    <div class="col-md-3">
                                        <dx:ASPxComboBox Caption="Month *" runat="server" ID="cbMonth" DataSourceID="odsMonth" ValueField="MonthCycle" ValueType="System.String" NullText="--All--"
                                            ClientInstanceName="cbMonth" EnableCallbackMode="true" DropDownStyle="DropDownList">
                                            <ClientSideEvents ValueChanged="monthChanged" />
                                            <ClearButton DisplayMode="OnHover"></ClearButton>
                                            <Columns>
                                                <dx:ListBoxColumn FieldName="MonthCycle" Caption="Month" />
                                            </Columns>
                                        </dx:ASPxComboBox>
                                        <asp:ObjectDataSource ID="odsMonth" runat="server" SelectMethod="getMonth" TypeName="LogicTier.Controllers.TermController">
                                            <SelectParameters>
                                                <asp:ControlParameter ControlID="cbTerm" DbType="Int32" Name="Id" PropertyName="Value" />
                                            </SelectParameters>
                                        </asp:ObjectDataSource>
                                    </div>
                                    <div class="col-md-4">
                                        <dx:ASPxButton ID="FilterButton" AutoPostBack="false" runat="server" Text="Search" Style="float: left; margin-right: 10px;">
                                            <ClientSideEvents Click="function(s, e) {  aspCallbackPanel.PerformCallback('filter'); initMap();}"></ClientSideEvents>
                                        </dx:ASPxButton>
                                        <asp:Literal ID="ltratl" runat="server"></asp:Literal>
                                    </div>
                                </div>
                            </fieldset>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-12">
                        <dx:ASPxGridView ID="grDataBrand" Visible="false" runat="server" AutoGenerateColumns="false" Theme="Material" Width="100%">
                            <Columns>
                                <dx:GridViewDataColumn Width="72px" VisibleIndex="0" Caption="No.">
                                    <CellStyle HorizontalAlign="Center"></CellStyle>
                                    <DataItemTemplate>
                                        <%# Container.ItemIndex + 1 %>
                                    </DataItemTemplate>
                                </dx:GridViewDataColumn>
                                <dx:GridViewDataColumn FieldName="BrandName" VisibleIndex="1" Caption="Brand"></dx:GridViewDataColumn>
                                <dx:GridViewDataColumn FieldName="ActivityName" VisibleIndex="2" Caption="Activity Name"></dx:GridViewDataColumn>
                                <dx:GridViewDataTextColumn FieldName="ActivityDate" VisibleIndex="3">
                                    <PropertiesTextEdit DisplayFormatString="yyyy-MM-dd"></PropertiesTextEdit>
                                </dx:GridViewDataTextColumn>
                                <dx:GridViewDataColumn Width="110px" Caption="View" VisibleIndex="4">
                                    <CellStyle HorizontalAlign="Center"></CellStyle>
                                    <DataItemTemplate>
                                        <a href='<%# "/Pages/DocumentView.aspx?Id=" + Eval("Id") %>' target="_blank" style="color:green!important">Click</a>
                                    </DataItemTemplate>
                                </dx:GridViewDataColumn>
                            </Columns>
                            <Settings VerticalScrollBarStyle="Standard" VerticalScrollableHeight="370" VerticalScrollBarMode="Visible" />
                            <SettingsBehavior AllowSort="true" ColumnResizeMode="Control" />
                            <Styles>
                                <Header HorizontalAlign="Center" Wrap="True" Paddings-Padding="3px"></Header>
                                <Cell Wrap="True" VerticalAlign="Middle" Paddings-Padding="5px"></Cell>
                            </Styles>
                            <SettingsPager PageSize="200000"></SettingsPager>
                        </dx:ASPxGridView>
                        <dx:ASPxGridView ID="grData" runat="server" AutoGenerateColumns="false" Theme="Material" Width="100%">
                            <Columns>
                                <dx:GridViewDataColumn Width="72px" VisibleIndex="0" Caption="No.">
                                    <CellStyle HorizontalAlign="Center"></CellStyle>
                                    <DataItemTemplate>
                                        <%# Container.ItemIndex + 1 %>
                                    </DataItemTemplate>
                                </dx:GridViewDataColumn>
                                <dx:GridViewDataColumn FieldName="DealerName" VisibleIndex="1" Caption="Dealer"></dx:GridViewDataColumn>
                                <dx:GridViewDataColumn FieldName="ActivityName" VisibleIndex="2" Caption="Activity Name"></dx:GridViewDataColumn>
                                <dx:GridViewDataTextColumn FieldName="ActivityDate" VisibleIndex="3">
                                    <PropertiesTextEdit DisplayFormatString="yyyy-MM-dd"></PropertiesTextEdit>
                                </dx:GridViewDataTextColumn>
                                <dx:GridViewDataColumn Width="110px" Caption="View" VisibleIndex="4">
                                    <CellStyle HorizontalAlign="Center"></CellStyle>
                                    <DataItemTemplate>
                                        <a href='<%# "/Pages/DocumentView.aspx?Id=" + Eval("Id") %>' target="_blank" style="color:green!important">Click</a>
                                    </DataItemTemplate>
                                </dx:GridViewDataColumn>
                            </Columns>
                            <Settings VerticalScrollBarStyle="Standard" VerticalScrollableHeight="370" VerticalScrollBarMode="Visible" />
                            <SettingsBehavior AllowSort="true" ColumnResizeMode="Control" />
                            <Styles>
                                <Header HorizontalAlign="Center" Wrap="True" Paddings-Padding="3px"></Header>
                                <Cell Wrap="True" VerticalAlign="Middle" Paddings-Padding="5px"></Cell>
                            </Styles>
                            <SettingsPager PageSize="200000"></SettingsPager>
                        </dx:ASPxGridView>
                        <dx:ASPxGridView ID="grALT" Visible="false" runat="server" AutoGenerateColumns="false" Theme="Material" Width="100%">
                            <Columns>
                                <dx:GridViewDataColumn Width="72px" VisibleIndex="0" Caption="No.">
                                    <CellStyle HorizontalAlign="Center"></CellStyle>
                                    <DataItemTemplate>
                                        <%# Container.ItemIndex + 1 %>
                                    </DataItemTemplate>
                                </dx:GridViewDataColumn>
                                <dx:GridViewDataColumn FieldName="ActivityName" VisibleIndex="2" Caption="Activity Name"></dx:GridViewDataColumn>
                                <dx:GridViewDataTextColumn FieldName="ActivityDate" VisibleIndex="3">
                                    <PropertiesTextEdit DisplayFormatString="yyyy-MM-dd"></PropertiesTextEdit>
                                </dx:GridViewDataTextColumn>
                                <dx:GridViewDataColumn Width="110px" Caption="View" VisibleIndex="4">
                                    <CellStyle HorizontalAlign="Center"></CellStyle>
                                    <DataItemTemplate>
                                        <a href='<%# "/Pages/DocumentView.aspx?Id=" + Eval("Id") %>' target="_blank" style="color:green!important">Click</a>
                                    </DataItemTemplate>
                                </dx:GridViewDataColumn>
                            </Columns>
                            <Settings VerticalScrollBarStyle="Standard" VerticalScrollableHeight="370" VerticalScrollBarMode="Visible" />
                            <SettingsBehavior AllowSort="true" ColumnResizeMode="Control" />
                            <Styles>
                                <Header HorizontalAlign="Center" Wrap="True" Paddings-Padding="3px"></Header>
                                <Cell Wrap="True" VerticalAlign="Middle" Paddings-Padding="5px"></Cell>
                            </Styles>
                            <SettingsPager PageSize="200000"></SettingsPager>
                        </dx:ASPxGridView>
                    </div>
                </div>
            </dx:PanelContent>
        </PanelCollection>
    </dx:ASPxCallbackPanel>
    <dx:ASPxHiddenField ID="hdfKey" ClientInstanceName="hdfKey" runat="server"></dx:ASPxHiddenField>
</asp:Content>