<%@ Page Title="Dealer Information" Language="C#" MasterPageFile="~/Layout.master" AutoEventWireup="true" CodeBehind="CustomerDealerInfo.aspx.cs" Inherits="WebApplication.Pages.CustomerDealerInfo" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Content" runat="server">
    <style>
        fieldset.scheduler-border {
            background-color: rgba(227, 229, 229, 0.09);
            border: 1px groove #ddd !important;
            padding: 0 1em 1em 1em !important;
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

        .dxeRadioButtonList_Moderno {
            border: none !important
        }

        .dxeCaption_Moderno {
            font-weight: 600;
        }

        .highcharts-exporting-group, .highcharts-credits {
            display: none
        }

        .dxEditors_edtRadioButtonUnchecked_Moderno {
            background-position: -18px -18px !important;
            width: 18px !important;
            height: 18px !important;
        }

        .dxEditors_edtRadioButtonUnchecked_Moderno, .dxEditors_edtRadioButtonChecked_Moderno {
            background-size: 36px !important;
        }

        .dxEditors_edtRadioButtonChecked_Moderno {
            background-position: 0 0 !important;
            width: 18px !important;
            height: 18px !important;
        }

        .dxeRoot_Moderno td:first-child {
            width: 85px
        }

        .dxeRoot_Moderno td:last-child {
            width: calc(100% - 85px)
        }

        .dxeRadioButtonList_Moderno td {
            width: auto !important
        }
    </style>
    <script>
        function OnEndCallback(s, e) {
            if (s.cpAlert != null && s.cpAlert != '') {
                alert(s.cpAlert);
            }
        }
        function monthChanged(s, e) {
            aspCallbackPanel.PerformCallback('month|' + s.GetValue())
        }

    </script>
    <dx:ASPxHiddenField ID="hdfKey" ClientInstanceName="hdfKey" runat="server"></dx:ASPxHiddenField>
    <div class="row filter">
        <div class="col-md-5">
            <fieldset class="scheduler-border">
                <legend class="scheduler-border">Search</legend>
                <div class="row">
                    <div class="col-md-7">
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
                    <div style="display: none">
                        <dx:ASPxComboBox Caption="Term *" runat="server" ID="cbTerm" Width="100%" DataSourceID="odsTerm" ValueField="Id" ValueType="System.Int32" NullText="--ALL--"
                            ClientInstanceName="cbTerm" DropDownStyle="DropDownList">
                            <ClearButton DisplayMode="OnHover"></ClearButton>
                            <ClientSideEvents ValueChanged="function(s,e){cbWeek.PerformCallback()}" />
                            <Columns>
                                <dx:ListBoxColumn FieldName="TermCycle" Caption="Term" />
                            </Columns>
                        </dx:ASPxComboBox>
                        <asp:ObjectDataSource ID="odsTerm" runat="server" SelectMethod="getList" TypeName="LogicTier.Controllers.TermController"></asp:ObjectDataSource>
                    </div>
                    <div class="col-md-5">
                        <dx:ASPxButton ID="FilterButton" AutoPostBack="false" runat="server" Text="Search">
                            <ClientSideEvents Click="function(s, e) {  aspCallbackPanel.PerformCallback('filter'); }"></ClientSideEvents>
                        </dx:ASPxButton>
                        <%-- <dx:ASPxButton ID="ASPxButton1" AutoPostBack="false" runat="server" Text="Download">
                                        <ClientSideEvents Click="function(s, e) {  ImageExcelCallbackPanel.PerformCallback(); }"></ClientSideEvents>
                                    </dx:ASPxButton>
                                    <dx:ASPxCallbackPanel runat="server" ID="ImageExcelCallbackPanel" Style="float: left; margin-right: 10px; margin-top: 5px;" ClientInstanceName="ImageExcelCallbackPanel"
                                        OnCallback="ImageExcelCallbackPanel_Callback" SettingsLoadingPanel-Text="Exporting Data, please wait.">
                                        <ClientSideEvents EndCallback="OnEndCallback" />
                                        <PanelCollection>
                                            <dx:PanelContent ID="PanelContent3" runat="server">
                                                <asp:HyperLink ID="hplexcel" runat="server"></asp:HyperLink>
                                            </dx:PanelContent>
                                        </PanelCollection>
                                    </dx:ASPxCallbackPanel>--%>
                    </div>
                </div>
            </fieldset>
        </div>
    </div>
    <div class="row">
        <div class="col-md-12">
            <dx:ASPxCallbackPanel ID="aspCallbackPanel" runat="server" Width="100%" ClientSideEvents-EndCallback="OnEndCallback"
                ClientInstanceName="aspCallbackPanel" OnCallback="aspCallbackPanel_Callback">
                <PanelCollection>
                    <dx:PanelContent runat="server">
                        <div class="row">
                            <div class="col-md-6">
                                <asp:Label ID="lblMonth" runat="server" Text="Month" Font-Bold="true"></asp:Label>
                                <br />
                                <dx:ASPxGridView ID="gvMonth" runat="server" AutoGenerateColumns="true" Theme="Material" Width="100%" OnHtmlDataCellPrepared="gvMonth_HtmlDataCellPrepared">
                                    <Columns>
                                    </Columns>
                                    <Settings HorizontalScrollBarMode="Hidden" VerticalScrollBarStyle="Standard" VerticalScrollableHeight="310" VerticalScrollBarMode="Auto" />
                                    <SettingsBehavior AllowSort="false" ColumnResizeMode="Control" />
                                    <Styles>
                                        <Header HorizontalAlign="Center" Wrap="True" Paddings-Padding="3px"></Header>
                                        <Cell Wrap="True" VerticalAlign="Middle" Paddings-Padding="5px"></Cell>
                                    </Styles>
                                    <SettingsPager PageSize="200000"></SettingsPager>
                                </dx:ASPxGridView>
                            </div>
                            <div class="col-md-6">
                                <asp:Label ID="lblLastMonth" runat="server" Text="Month" Font-Bold="true"></asp:Label>
                                <br />
                                <dx:ASPxGridView ID="gvLastMonth" runat="server"
                                    AutoGenerateColumns="true" Theme="Material" Width="100%" 
                                    OnHtmlDataCellPrepared="gvMonth_HtmlDataCellPrepared">
                                    <Columns>
                                    </Columns>
                                    <Settings HorizontalScrollBarMode="Hidden" VerticalScrollBarStyle="Standard" VerticalScrollableHeight="310" VerticalScrollBarMode="Auto" />
                                    <SettingsBehavior AllowSort="false" ColumnResizeMode="Control" />
                                    <Styles>
                                        <Header HorizontalAlign="Center" Wrap="True" Paddings-Padding="3px"></Header>
                                        <Cell Wrap="True" VerticalAlign="Middle" Paddings-Padding="5px"></Cell>
                                    </Styles>
                                    <SettingsPager PageSize="200000"></SettingsPager>
                                </dx:ASPxGridView>
                            </div>
                        </div>
                        <div class="row" style="margin-top: 16px">
                            <div class="col-md-6">
                                <asp:Label ID="lblGap" runat="server" Text="Gap Against " Font-Bold="true"></asp:Label>
                                <br />
                                <dx:ASPxGridView ID="gvGap" runat="server" AutoGenerateColumns="true" Theme="Material" Width="100%" OnHtmlDataCellPrepared="gvMonth_HtmlDataCellPrepared">
                                    <Columns>
                                    </Columns>
                                    <Settings HorizontalScrollBarMode="Hidden" VerticalScrollBarStyle="Standard" VerticalScrollableHeight="310" VerticalScrollBarMode="Auto" />
                                    <SettingsBehavior AllowSort="false" ColumnResizeMode="Control" />
                                    <Styles>
                                        <Header HorizontalAlign="Center" Wrap="True" Paddings-Padding="3px"></Header>
                                        <Cell Wrap="True" VerticalAlign="Middle" Paddings-Padding="5px"></Cell>
                                    </Styles>
                                    <SettingsPager PageSize="200000"></SettingsPager>
                                </dx:ASPxGridView>
                            </div>
                            <div class="col-md-6">
                                <asp:Label ID="lblPer" runat="server" Text="ALM %" Font-Bold="true"></asp:Label>
                                <br />
                                <dx:ASPxGridView ID="gvALM" runat="server" AutoGenerateColumns="true" Theme="Material" Width="100%" OnHtmlDataCellPrepared="gvALM_HtmlDataCellPrepared">
                                    <Columns>
                                    </Columns>
                                    <Settings HorizontalScrollBarMode="Hidden" VerticalScrollBarStyle="Standard" VerticalScrollableHeight="310" VerticalScrollBarMode="Auto" />
                                    <SettingsBehavior AllowSort="false" ColumnResizeMode="Control" />
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
        </div>
    </div>
</asp:Content>
