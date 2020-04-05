<%@ Page Title="Evaluation" Language="C#" MasterPageFile="~/Layout.master" AutoEventWireup="true" CodeBehind="PC_Evaluation.aspx.cs" Inherits="WebApplication.Pages.PC_Evaluation" %>

<%@ Register Assembly="DevExpress.Web.ASPxPivotGrid.v17.1, Version=17.1.6.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.ASPxPivotGrid" TagPrefix="dx" %>

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

        .modal-blue {
            /*background: #007bff !important;
            color: #ffffff*/
        }

        .dxgvCSD {
            width: 1140px !important
        }

        .filter .dxeCaption_Moderno {
            width: 64px !important
        }
        .w100{
            width:100%
        }
        .u-evalua{
            margin:0; padding: 0
        }
        .u-evalua li{
            float: left;
            width: 31%;
            list-style: none;
            padding: 10px;
            border-radius: 5px;
            height: 130px;
            margin-left: 2%;
            text-align: center
        }
        .u-evalua li h3{
            display: inline;
            color:#FFF;
            background:#d71e2b;
                margin: 0 10px;
        }
        .u-evalua li h5{
            margin-bottom: 0
        }
        .u-evalua li a{
            color:#337ab7;
            font-weight:600
        }
        .u-evalua li:nth-child(1){
            background:#f39e87
        }
        .u-evalua li:nth-child(2){
            background:#bfce92
        }
        .u-evalua li:nth-child(3){
            background:#a6cdbd
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
        var textSeparator = ";";
        var valueSelect = ';';
        function updateText() {
            var selectedItems = checkListBox.GetSelectedItems();
            checkComboBox.SetText(getSelectedItemsText(selectedItems));
        }
        function synchronizeListBoxValues(dropDown, args) {
            checkListBox.UnselectAll();
            var texts = dropDown.GetText().split(textSeparator);
            var values = getValuesByTexts(texts);
            checkListBox.SelectValues(values);
            updateText(); // for remove non-existing texts
        }
        function getSelectedItemsText(items) {
            var texts = [];
            for (var i = 0; i < items.length; i++)
                texts.push(items[i].text);
            return texts.join(textSeparator);
        }
        function getValuesByTexts(texts) {
            valueSelect = '';
            var actualValues = [];
            var item;
            for (var i = 0; i < texts.length; i++) {
                item = checkListBox.FindItemByText(texts[i]);
                if (item != null)
                    actualValues.push(item.value);
            }
            return actualValues;
        }
        function GetValues() {
            var selectedItems = checkListBox.GetSelectedItems();
            var valuesText = getSelectedItemsText(selectedItems);
            valueSelect = getValuesByTexts(valuesText.split(textSeparator));
            hdfKey.Set('gfk', valueSelect.join());
        }
    </script>

    <dx:ASPxCallbackPanel ID="aspCallbackPanel" runat="server" Width="100%" ClientSideEvents-EndCallback="OnEndCallback"
        ClientInstanceName="aspCallbackPanel" OnCallback="aspCallbackPanel_Callback">
        <PanelCollection>
            <dx:PanelContent runat="server">
                <div class="row filter">
                    <div class="col-md-7">
                        <fieldset class="scheduler-border ">
                            <legend class="scheduler-border">Search</legend>
                            <div class="row">
                                <div class="col-md-6" style="display: none">
                                    <dx:ASPxComboBox Caption="Term *" runat="server" ID="cbTerm" Width="100%" DataSourceID="odsTerm" ValueField="Id" ValueType="System.Int32" NullText="--All--"
                                        ClientInstanceName="cbTerm" DropDownStyle="DropDownList">
                                        <ClearButton DisplayMode="OnHover"></ClearButton>
                                        <ClientSideEvents ValueChanged="function(s,e){ cbWeek.PerformCallback()}" />
                                        <Columns>
                                            <dx:ListBoxColumn FieldName="TermCycle" Caption="Term" />
                                        </Columns>
                                    </dx:ASPxComboBox>
                                    <asp:ObjectDataSource ID="odsTerm" runat="server" SelectMethod="getList" TypeName="LogicTier.Controllers.TermController"></asp:ObjectDataSource>
                                </div>
                                <div class="col-md-6">
                                    <dx:ASPxComboBox Caption="Month *" runat="server" Width="100%" ID="cbMonth" DataSourceID="odsMonth" ValueField="MonthCycle" ValueType="System.String" NullText="--All--"
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
                                <div class="col-md-6">
                                    <dx:ASPxDropDownEdit ClientInstanceName="checkComboBox" NullText="--All--" Caption="Area" ID="checkRegion" runat="server" AnimationType="None">
                                        <DropDownWindowTemplate>
                                            <dx:ASPxListBox Width="100%" ID="listBox" ClientInstanceName="checkListBox" SelectionMode="CheckColumn" DataSourceID="odsregion"
                                                runat="server" Height="200" EnableSelectAll="true" ValueField="Region" TextField="Region">
                                                <Border BorderStyle="None" />
                                                <BorderBottom BorderStyle="Solid" BorderWidth="1px" BorderColor="#DCDCDC" />
                                                <ClientSideEvents SelectedIndexChanged="updateText" Init="updateText" />
                                            </dx:ASPxListBox>
                                            <table style="width: 100%">
                                                <tr>
                                                    <td style="padding: 4px">
                                                        <dx:ASPxButton ID="ASPxButton1" AutoPostBack="False" runat="server" Text="Close" Style="float: right">
                                                            <ClientSideEvents Click="function(s, e){ checkComboBox.HideDropDown();GetValues(); }" />
                                                        </dx:ASPxButton>
                                                    </td>
                                                </tr>
                                            </table>
                                        </DropDownWindowTemplate>
                                        <ClientSideEvents TextChanged="synchronizeListBoxValues" DropDown="synchronizeListBoxValues" />
                                    </dx:ASPxDropDownEdit>
                                </div>
                            </div>
                            <div class="row marginTop20" style="display: none">
                                <div class="col-md-6">
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
                                    <dx:ASPxComboBox Caption="GFK Area" runat="server" Width="100%" ID="cbRegion" DataSourceID="odsregion" ValueField="Region" ValueType="System.String" NullText="--All--"
                                        ClientInstanceName="cbRegion" EnableCallbackMode="true" DropDownStyle="DropDownList">
                                        <ClearButton DisplayMode="OnHover"></ClearButton>
                                        <Columns>
                                            <dx:ListBoxColumn FieldName="Region" Caption="Region" />
                                        </Columns>
                                    </dx:ASPxComboBox>
                                    <asp:ObjectDataSource ID="odsregion" runat="server" SelectMethod="getRegion_byArea" TypeName="LogicTier.Controllers.OutletBL">
                                        <SelectParameters>
                                            <asp:Parameter Name="Area" Type="String" />
                                        </SelectParameters>
                                    </asp:ObjectDataSource>
                                </div>
                            </div>
                            <div class="row marginTop20" style="display: none">
                                <div class="col-md-6">
                                    <dx:ASPxComboBox Caption="Rank" runat="server" Width="100%" ID="cbRank" ValueType="System.String" NullText="--All--"
                                        ClientInstanceName="cbRank" EnableCallbackMode="true" DropDownStyle="DropDownList">
                                        <Items>
                                            <dx:ListEditItem Value="Expert" Text="Expert" />
                                            <dx:ListEditItem Value="Newbie" Text="Newbie" />
                                            <dx:ListEditItem Value="Probation" Text="Probation" />
                                        </Items>
                                    </dx:ASPxComboBox>
                                </div>
                            </div>
                            <div class="row marginTop20">
                                <div class="col-md-6">
                                    <dx:ASPxButton ID="FilterButton" AutoPostBack="false" runat="server" Text="Search" Style="float: left; margin-right: 10px;">
                                        <ClientSideEvents Click="function(s, e) {  aspCallbackPanel.PerformCallback('filter'); }"></ClientSideEvents>
                                    </dx:ASPxButton>
                                    <dx:ASPxButton ID="ExportButton" AutoPostBack="false" runat="server" Text="Export" Style="float: left; margin-right: 10px;">
                                        <ClientSideEvents Click="function(s, e) {  aspCallbackPanel.PerformCallback('Export'); }"></ClientSideEvents>
                                    </dx:ASPxButton>
                                    <asp:HyperLink ID="hplexcel" runat="server" Visible="false"></asp:HyperLink>
                                </div>
                            </div>
                        </fieldset>
                    </div>
                    <div class="col-md-5" style="margin-top: 27px; display: none">
                        <table class="table text-center table-hover">
                            <thead>
                                <tr>
                                    <th style="text-align: center">Scoring Structure</th>
                                    <th style="text-align: center">Grade</th>
                                    <th style="text-align: center">No.Of PC</th>
                                </tr>
                            </thead>
                            <tbody>
                                <asp:Literal ID="ltrbody" runat="server"></asp:Literal>
                            </tbody>
                        </table>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-12">
                        <dx:ASPxGridView ID="grData" KeyFieldName="EmployeeId" runat="server" AutoGenerateColumns="false" Theme="Material" OnLoad="grData_Load" Width="1140px">
                            <Columns>
                            </Columns>
                            <SettingsDetail ShowDetailRow="false" AllowOnlyOneMasterRowExpanded="false" />
                            <ClientSideEvents RowClick="function(s, e) {s.ExpandDetailRow(s.GetFocusedRowIndex());}" />
                            <Templates>
                                <DetailRow>
                                    <dx:ASPxPageControl runat="server" ID="pageControl" Width="100%" EnableCallBacks="true" ActiveTabIndex="0">
                                        <TabPages>
                                            <dx:TabPage Text="" Visible="true">
                                                <ContentCollection>
                                                    <dx:ContentControl runat="server">
                                                        <asp:Repeater ID="rpDetail" runat="server" OnInit="rptGallery_Init">
                                                            <ItemTemplate>
                                                                <div class="row" style="margin: 15px 0;">
                                                                    <div class="col-md-2">
                                                                        <dx:ASPxBinaryImage ID="BinaryImg" CssClass="w100" runat="server" ClientInstanceName="BinaryImg"
                                                                            Value='<%# Eval("BinaryImg") %>' ImageAlign="AbsMiddle">
                                                                        </dx:ASPxBinaryImage>
                                                                    </div>
                                                                    <div class="col-md-3">
                                                                        <ul style="margin:0; padding: 0">
                                                                            <li style="float: left; width:100%; list-style: none">Working Date: <a><%# Eval("HireDate","{0:dd/MM/yyyy}") %></a></li>
                                                                            <li style="float: left; width:100%; list-style: none">Gender: <a><%# Eval("SexName") %></a></li>
                                                                            <li style="float: left; width:100%; list-style: none">DOB: <a><%# Eval("DOB","{0:dd/MM/yyyy}") %></a></li>
                                                                            <li style="float: left; width:100%; list-style: none">Id: <a><%# Eval("IdNumber") %></a></li>
                                                                            <li style="float: left; width:100%; list-style: none">Phone number: <a><%# Eval("Mobile") %></a></li>
                                                                            <li style="float: left; width:100%; list-style: none">Add: <a><%# Eval("IdPlace") %></a></li>
                                                                        </ul>
                                                                    </div>
                                                                    <div class="col-md-7">
                                                                        <ul class="u-evalua">
                                                                            <li>
                                                                                <h5>Abilities</h5><br />
                                                                                Online test: <a><%# Eval("Product Knowledge-PG") %></a><br />
                                                                                In shop test: <ab><%# Eval("F2F") %></ab>
                                                                            </li>
                                                                            <li>
                                                                                <h5>Manners</h5><br />
                                                                                Attendance: <a><%# Eval("Attendance") %></a><br />
                                                                                Dealer: <a><%# Eval("ByDealer") %></a><br />
                                                                                Uniform: <a><%# Eval("Uniform") %></a>
                                                                            </li>
                                                                            <li>
                                                                                <h5>Sales</h5><br />
                                                                                Target: <a><%# Eval("Target","{0:#,##}") %></a><br />
                                                                                Actual: <a><%# Eval("Actual","{0:#,##}") %></a><br />
                                                                                Percent: <a><%# Eval("Percent") %>%</a><br />
                                                                                <i>For Reference</i>
                                                                            </li>
                                                                            <li style="width:100%; margin: 0; margin-top:30px;height: 60px">
                                                                                <h3 style="border-radius: 50%; padding: 15px 17px;"><%# Eval("Score") %></h3>
                                                                                <h3 style="padding: 15px 25px;"><%# Eval("Grade") %></h3>
                                                                            </li>
                                                                        </ul>
                                                                    </div>
                                                                </div>
                                                            </ItemTemplate>
                                                        </asp:Repeater>
                                                    </dx:ContentControl>
                                                </ContentCollection>
                                            </dx:TabPage>
                                        </TabPages>
                                    </dx:ASPxPageControl>
                                </DetailRow>
                            </Templates>
                            <Settings VerticalScrollableHeight="450" VerticalScrollBarMode="Visible" />
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