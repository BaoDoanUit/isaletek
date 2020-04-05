<%@ Page Title="Sellout Realtime" Language="C#" MasterPageFile="~/Layout.master" AutoEventWireup="true" CodeBehind="CustomerSelloutRealtime.aspx.cs" Inherits="WebApplication.Pages.CustomerSelloutRealtime" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Content" runat="server">
    <script src="https://code.highcharts.com/highcharts.js"></script>
    <script src="https://code.highcharts.com/modules/series-label.js"></script>
    <script src="https://code.highcharts.com/modules/exporting.js"></script>
    <script src="https://code.highcharts.com/modules/export-data.js"></script>
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

        .dxeRadioButtonList_Moderno {
            border: none !important
        }

        .dxeRoot_Moderno td:first-child {
            width: 85px
        }

        .dxeRoot_Moderno td:last-child {
            width: calc(100% - 85px)
        }
        .dxeCalendarButton_Moderno {
            width: 100%!important
        }
        .dxeRadioButtonList_Moderno td{
            width: auto!important
        }
    </style>
    <script>
        function OnEndCallback(s, e) {
            if (s.cpAlert != null && s.cpAlert != '') {
                alert(s.cpAlert);
            }
            chart();
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
        function chart() {
            var LbDay = $('span#Content_aspCallbackPanel_LbDay').html();
            var LbLast_Year_Amt = $('span#Content_aspCallbackPanel_LbLast_Year_Amt').html();
            var LbLast_Year_Qty = $('span#Content_aspCallbackPanel_LbLast_Year_Qty').html();
            var LbResult_Amt = $('span#Content_aspCallbackPanel_LbResult_Amt').html();
            var LbResult_Qty = $('span#Content_aspCallbackPanel_LbResult_Qty').html();
            var LbTargetQty = $('span#Content_aspCallbackPanel_LbTargetQty').html();
            var LbTargetAmt = $('span#Content_aspCallbackPanel_LbTargetAmt').html();
            var LbQtyAT = $('span#Content_aspCallbackPanel_LbQtyAT').html();
            var LbAmtAT = $('span#Content_aspCallbackPanel_LbAmtAT').html();
            var arrDay = [];
            var resDay = LbDay.split(',');
            for (var i = 0; i < resDay.length; i++) {
                arrDay.push(resDay[i]);
            }
            // Qty
            var arrRQty = [];
            var resRQty = LbResult_Qty.split(',');
            for (var i = 0; i < resRQty.length; i++) {
                arrRQty.push(parseInt(resRQty[i]));
            }
            var arrLQty = [];
            var resLQty = LbLast_Year_Qty.split(',');
            for (var i = 0; i < resLQty.length; i++) {
                arrLQty.push(parseInt(resLQty[i]));
            }
            var arrTQty = [];
            var resTQty = LbTargetQty.split(',');
            for (var i = 0; i < resTQty.length; i++) {
                arrTQty.push(parseInt(resTQty[i]));
            }
            var arrQtyAT = [];
            var resQtyAT = LbQtyAT.split(',');
            for (var i = 0; i < resQtyAT.length; i++) {
                arrQtyAT.push(parseInt(resQtyAT[i]));
            }
            // Amt
            var arrRAmt = [];
            var resRAmt = LbResult_Amt.split(',');
            for (var i = 0; i < resRAmt.length; i++) {
                arrRAmt.push(parseInt(resRAmt[i]));
            }
            var arrLAmt = [];
            var resLAmt = LbLast_Year_Amt.split(',');
            for (var i = 0; i < resLAmt.length; i++) {
                arrLAmt.push(parseInt(resLAmt[i]));
            }
            var arrTAmt = [];
            var resTAmt = LbTargetAmt.split(',');
            for (var i = 0; i < resTAmt.length; i++) {
                arrTAmt.push(parseInt(resTAmt[i]));
            }
            var arrAmtAT = [];
            var resAmtAT = LbAmtAT.split(',');
            for (var i = 0; i < resAmtAT.length; i++) {
                arrAmtAT.push(parseInt(resAmtAT[i]));
            }
            Highcharts.chart('ctnAmt', {
                title: {
                    text: 'Sell out by monthly Amt'
                },
                xAxis: {
                    categories: arrDay
                },
                yAxis: {
                    title: {
                        text: 'Amt (KVND)'
                    }
                },
                tooltip: {
                    shared: true,
                    valueSuffix: ' '
                },
                credits: {
                    enabled: false
                },
                plotOptions: {
                    areaspline: {
                        fillOpacity: 0.5
                    }
                },
                series: [{
                    type: 'spline',
                    name: 'Target',
                    data: arrTAmt,
                    index: 2,
                    color: '#4591f9'
                },
                {
                    type: 'spline',
                    name: 'Actual',
                    data: arrRAmt,
                    color: '#ff1800',
                    index: 2
                    }
                //{
                //    type: 'areaspline',
                //    name: 'Last Year',
                //    data: arrLAmt,
                //    color: {
                //        radialGradient: { cx: 0.5, cy: 0.5, r: 0.5 },
                //        stops: [
                //            [0, '#dae9fd'],
                //            [1, '#c6deff']
                //        ]
                //    },
                //    index: 1
                //}
                    ,
                {
                    type: 'spline',
                    name: 'AT%',
                    data: arrQtyAT,
                    color: '#ffa50000',
                    index: 2,
                    tooltip: {
                        valueSuffix: '{.1f}%'
                    }
                }]
            });
            Highcharts.chart('ctnQty', {
                title: {
                    text: 'Sell out by monthly Qty'
                },
                xAxis: {
                    categories: arrDay
                },
                yAxis: {
                    title: {
                        text: 'Qty'
                    }
                },
                tooltip: {
                    shared: true,
                    valueSuffix: ' '
                },
                credits: {
                    enabled: false
                },
                plotOptions: {
                    areaspline: {
                        fillOpacity: 0.5
                    }
                },
                series: [{
                    type: 'spline',
                    name: 'Target',
                    data: arrTQty,
                    index: 2,
                    color: '#4591f9'
                },
                {
                    type: 'spline',
                    name: 'Actual',
                    data: arrRQty,
                    color: '#ff1800',
                    index: 2
                    }
                //{
                //    type: 'areaspline',
                //    name: 'Last Year',
                //    data: arrLQty,
                //    color: {
                //        radialGradient: { cx: 0.5, cy: 0.5, r: 0.5 },
                //        stops: [
                //            [0, '#dae9fd'],
                //            [1, '#c6deff']
                //        ]
                //    },
                //    index: 1
                //}
                    ,
                {
                    type: 'spline',
                    name: 'AT%',
                    data: arrQtyAT,
                    color: '#ffa50000',
                    index: 2,
                    tooltip: {
                        valueSuffix: '{.1f}%'
                    }
                }]
            });

            // by Range
            var RLbRange = $('span#Content_aspCallbackPanel_RLbRange').html();
            var RTarget_Qty = $('span#Content_aspCallbackPanel_RTarget_Qty').html();
            var RResult_Qty = $('span#Content_aspCallbackPanel_RResult_Qty').html();
            var RLast_Qty = $('span#Content_aspCallbackPanel_RLast_Qty').html();
            var RTarget_Amt = $('span#Content_aspCallbackPanel_RTarget_Amt').html();
            var RResult_Amt = $('span#Content_aspCallbackPanel_RResult_Amt').html();
            var RLast_Amt = $('span#Content_aspCallbackPanel_RLast_Amt').html();
            var RAT_Qty = $('span#Content_aspCallbackPanel_RAT_Qty').html();
            var RALY_Qty = $('span#Content_aspCallbackPanel_RALY_Qty').html();
            var RAT_Amt = $('span#Content_aspCallbackPanel_RAT_Amt').html();
            var RALY_Amt = $('span#Content_aspCallbackPanel_RALY_Amt').html();

            var arrRange = [];
            var resRange = RLbRange.split(',');
            for (var i = 0; i < resRange.length; i++) {
                arrRange.push(resRange[i]);
            }
            var arrTargetQty = [];
            var resTargetQty = RTarget_Qty.split(',');
            for (var i = 0; i < resTargetQty.length; i++) {
                arrTargetQty.push(parseInt(resTargetQty[i]));
            }

            var arrResultQty = [];
            var resResultQty = RResult_Qty.split(',');
            for (var i = 0; i < resResultQty.length; i++) {
                arrResultQty.push(parseInt(resResultQty[i]));
            }

            var arrLastQty = [];
            var resLastQty = RLast_Qty.split(',');
            for (var i = 0; i < resLastQty.length; i++) {
                arrLastQty.push(parseInt(resLastQty[i]));
            }

            var arrATQty = [];
            var resATQty = RAT_Qty.split(',');
            for (var i = 0; i < resATQty.length; i++) {
                arrATQty.push(parseInt(resATQty[i]));
            }

            var arrALYQty = [];
            var resALYQty = RALY_Qty.split(',');
            for (var i = 0; i < resALYQty.length; i++) {
                arrALYQty.push(parseInt(resALYQty[i]));
            }

            var arrTargetAmt = [];
            var resTargetAmt = RTarget_Amt.split(',');
            for (var i = 0; i < resTargetAmt.length; i++) {
                arrTargetAmt.push(parseInt(resTargetAmt[i]));
            }

            var arrResultAmt = [];
            var resResultAmt = RResult_Amt.split(',');
            for (var i = 0; i < resResultAmt.length; i++) {
                arrResultAmt.push(parseInt(resResultAmt[i]));
            }

            var arrLastAmt = [];
            var resLastAmt = RLast_Amt.split(',');
            for (var i = 0; i < resLastAmt.length; i++) {
                arrLastAmt.push(parseInt(resLastAmt[i]));
            }

            var arrATAmt = [];
            var resATAmt = RAT_Amt.split(',');
            for (var i = 0; i < resATAmt.length; i++) {
                arrATAmt.push(parseInt(resATAmt[i]));
            }

            var arrALYAmt = [];
            var resALYAmt = RALY_Amt.split(',');
            for (var i = 0; i < resALYAmt.length; i++) {
                arrALYAmt.push(parseInt(resALYAmt[i]));
            }
            //chart Qty
            Highcharts.chart('ctnRQtyAT', {
                title: {
                    text: 'AT'
                },
                xAxis: {
                    categories: arrRange
                },
                yAxis: {
                    title: {
                        text: ' '
                    }
                },
                tooltip: {
                    shared: true,
                    valueSuffix: ' '
                },
                credits: {
                    enabled: false
                },
                plotOptions: {
                    areaspline: {
                        fillOpacity: 0.5
                    }
                },
                series: [{
                    name: 'Target',
                    type: 'column',
                    data: arrTargetQty,
                    color: '#4591f9'
                }, {
                    name: 'Result',
                    type: 'column',
                    data: arrResultQty,
                    color: '#ff1800'
                },
                {
                    type: 'spline',
                    name: '%',
                    data: arrATQty,
                    color: '#ffa50000',
                    tooltip: {
                        valueSuffix: '{.1f}%'
                    }
                }]
            });
            Highcharts.chart('ctnRQtyALY', {
                title: {
                    text: 'ALY'
                },
                xAxis: {
                    categories: arrRange
                },
                yAxis: {
                    title: {
                        text: ' '
                    }
                },
                tooltip: {
                    shared: true,
                    valueSuffix: ' '
                },
                credits: {
                    enabled: false
                },
                plotOptions: {
                    areaspline: {
                        fillOpacity: 0.5
                    }
                },
                series: [{
                    name: 'Result',
                    type: 'column',
                    data: arrResultQty,
                    color: '#ff1800'
                }, {
                    name: 'LastYear',
                    type: 'column',
                    data: arrLastQty,
                    color: '#c6deff'
                },
                {
                    type: 'spline',
                    name: '%',
                    data: arrALYQty,
                    color: '#ffa50000',
                    tooltip: {
                        valueSuffix: '{.1f}%'
                    }
                }]
            });
            //chart Amt
            Highcharts.chart('ctnRAmtAT', {
                title: {
                    text: 'AT(KVND)'
                },
                xAxis: {
                    categories: arrRange
                },
                yAxis: {
                    title: {
                        text: ' '
                    }
                },
                tooltip: {
                    shared: true,
                    valueSuffix: ' '
                },
                credits: {
                    enabled: false
                },
                plotOptions: {
                    areaspline: {
                        fillOpacity: 0.5
                    }
                },
                series: [{
                    name: 'Target',
                    type: 'column',
                    data: arrTargetAmt,
                    color: '#4591f9'
                }, {
                    name: 'Result',
                    type: 'column',
                    data: arrResultAmt,
                    color: '#ff1800'
                },
                {
                    type: 'spline',
                    name: '%',
                    data: arrATAmt,
                    color: '#ffa50000',
                    tooltip: {
                        valueSuffix: '{.1f}%'
                    }
                }]
            });
            Highcharts.chart('ctnRAmtALY', {
                title: {
                    text: 'ALY(KVND)'
                },
                xAxis: {
                    categories: arrRange
                },
                yAxis: {
                    title: {
                        text: ' '
                    }
                },
                tooltip: {
                    shared: true,
                    valueSuffix: ' '
                },
                credits: {
                    enabled: false
                },
                plotOptions: {
                    areaspline: {
                        fillOpacity: 0.5
                    }
                },
                series: [{
                    name: 'Result',
                    type: 'column',
                    data: arrResultAmt,
                    color: '#ff1800'
                }, {
                    name: 'LastYear',
                    type: 'column',
                    data: arrLastAmt,
                    color: '#c6deff'
                },
                {
                    type: 'spline',
                    name: '%',
                    data: arrALYAmt,
                    color: '#ffa50000',
                    tooltip: {
                        valueSuffix: '{.1f}%'
                    }
                }]
            });
        }
    </script>
    <script type="text/javascript">
        $(document).ready(function () {
            chart();
        })
    </script>
    <dx:ASPxCallbackPanel ID="aspCallbackPanel" runat="server" Width="100%" ClientSideEvents-EndCallback="OnEndCallback"
        ClientInstanceName="aspCallbackPanel" OnCallback="aspCallbackPanel_Callback">
        <ClientSideEvents EndCallback="OnEndCallback"></ClientSideEvents>
        <PanelCollection>
            <dx:PanelContent runat="server">
                <div class="row filter">
                    <div class="col-md-3">
                        <fieldset class="scheduler-border">
                            <legend class="scheduler-border">Search</legend>
                            <div class="row">
                                <div class="col-md-12">
                                    <dx:ASPxDateEdit runat="server" ID="txtDate" OnInit="txtDate_Init" Caption="Date *" CalendarProperties-ShowClearButton="true" DisplayFormatString="MMM dd"
                                        EditFormat="Custom" EditFormatString="MMM dd">
                                        <ClientSideEvents ValueChanged="monthChanged" />
                                        <ClearButton DisplayMode="OnHover"></ClearButton>
                                    </dx:ASPxDateEdit>
                                </div>
                            </div>
                            <div class="row marginTop10">
                                <div class="col-md-12">
                                    <dx:ASPxDropDownEdit ClientInstanceName="checkComboBox" NullText="--All--" Caption="Area" ID="checkRegion" runat="server" AnimationType="None">
                                        <DropDownWindowTemplate>
                                            <dx:ASPxListBox ID="listBox" Width="100%" ClientInstanceName="checkListBox" SelectionMode="CheckColumn" DataSourceID="odsregion"
                                                runat="server" Height="200" EnableSelectAll="true" ValueField="Region" TextField="Region">
                                                <Border BorderStyle="None" />
                                                <BorderBottom BorderStyle="Solid" BorderWidth="1px" BorderColor="#DCDCDC" />
                                                <ClientSideEvents SelectedIndexChanged="updateText" Init="updateText" />
                                            </dx:ASPxListBox>
                                            <table>
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
                                    <asp:ObjectDataSource ID="odsregion" runat="server" SelectMethod="getRegion_byArea" TypeName="LogicTier.Controllers.OutletBL">
                                        <SelectParameters>
                                            <asp:Parameter Name="Area" Type="String" />
                                        </SelectParameters>
                                    </asp:ObjectDataSource>
                                </div>
                            </div>
                            <div class="row marginTop10">
                                <div class="col-md-12">
                                    <dx:ASPxRadioButtonList runat="server" Caption="Product *" ID="rdProduct" RepeatColumns="2" DataSourceID="odsProduct" ValueField="Product" dis TextField="Product" RepeatDirection="Vertical">
                                        <RadioButtonStyle Font-Size="10px"></RadioButtonStyle>
                                    </dx:ASPxRadioButtonList>
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
                                <div class="col-md-12" style="padding-bottom: 10px">
                                    <dx:ASPxButton ID="FilterButton" AutoPostBack="false" runat="server" Text="Search">
                                        <ClientSideEvents Click="function(s, e) {  aspCallbackPanel.PerformCallback('filter'); }"></ClientSideEvents>
                                    </dx:ASPxButton>
                                    <dx:ASPxButton ID="ASPxButton1" AutoPostBack="false" runat="server" Text="Download">
                                        <ClientSideEvents Click="function(s, e) {  ImageExcelCallbackPanel.PerformCallback(); }"></ClientSideEvents>
                                    </dx:ASPxButton>
                                    <dx:ASPxCallbackPanel runat="server" ID="ImageExcelCallbackPanel" Style="float: left; margin-right: 10px; margin-top: 5px;" ClientInstanceName="ImageExcelCallbackPanel"
                                        OnCallback="ImageExcelCallbackPanel_Callback" SettingsLoadingPanel-Text="Exporting Data, please wait.">
                                        <SettingsLoadingPanel Text="Exporting Data, please wait."></SettingsLoadingPanel>

                                        <ClientSideEvents EndCallback="OnEndCallback" />
                                        <PanelCollection>
                                            <dx:PanelContent ID="PanelContent3" runat="server">
                                                <asp:HyperLink ID="hplexcel" runat="server"></asp:HyperLink>
                                            </dx:PanelContent>
                                        </PanelCollection>
                                    </dx:ASPxCallbackPanel>
                                </div>
                            </div>
                            <div class="row" style="display: none">
                                <div class="col-md-6">
                                    <dx:ASPxComboBox Caption="Term *" runat="server" ID="cbTerm" Width="100%" DataSourceID="odsTerm" ValueField="Id" ValueType="System.Int32" NullText="--All--"
                                        ClientInstanceName="cbTerm" DropDownStyle="DropDownList">
                                        <ClearButton DisplayMode="OnHover"></ClearButton>
                                        <Columns>
                                            <dx:ListBoxColumn FieldName="TermCycle" Caption="Term" />
                                        </Columns>
                                    </dx:ASPxComboBox>
                                    <asp:ObjectDataSource ID="odsTerm" runat="server" SelectMethod="getList" TypeName="LogicTier.Controllers.TermController"></asp:ObjectDataSource>
                                </div>
                                <div class="col-md-6" style="display: none">
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
                                <div class="col-md-3" style="display: none">
                                    <dx:ASPxComboBox runat="server" ID="cbAccount" Caption="Dealer" Width="100%" ValueType="System.Int32" NullText="--All--"
                                        DataSourceID="odsAccount" TextField="Account" ValueField="ObjectId"
                                        ClientInstanceName="cbAccount" CallbackPageSize="10">
                                        <ClearButton DisplayMode="OnHover"></ClearButton>
                                    </dx:ASPxComboBox>
                                    <asp:ObjectDataSource ID="odsAccount" runat="server" SelectMethod="getAccountGroup" TypeName="LogicTier.Controllers.SaleOutBL"></asp:ObjectDataSource>
                                </div>
                            </div>
                        </fieldset>
                    </div>
                    <div class="col-md-9" style="margin-top: 25px; padding-left: 0; min-height: 200px">
                        <fieldset class="scheduler-border">
                            <dx:ASPxPageControl runat="server" ID="ASPxPageControl1" Width="100%" CssClass="dxtcFixed" ActiveTabIndex="0" EnableHierarchyRecreation="True">
                                <ClientSideEvents ActiveTabChanged="function(s, e) {
                                                        chart(); }" />
                                <TabPages>
                                    <dx:TabPage Text="Qty">
                                        <ContentCollection>
                                            <dx:ContentControl runat="server">
                                                <div id="ctnQty" style="height: 240px"></div>
                                            </dx:ContentControl>
                                        </ContentCollection>
                                    </dx:TabPage>
                                    <dx:TabPage Text="Amt">
                                        <ContentCollection>
                                            <dx:ContentControl runat="server">
                                                <div id="ctnAmt" style="height: 240px"></div>
                                            </dx:ContentControl>
                                        </ContentCollection>
                                    </dx:TabPage>
                                    <dx:TabPage Text="Range (Qty)">
                                            <ContentCollection>
                                                <dx:ContentControl runat="server">
                                                    <div class="row">
                                                        <div class="col-md-6">
                                                            <div id="ctnRQtyAT" style="height: 240px"></div>
                                                        </div>
                                                        <div class="col-md-6">
                                                            <div id="ctnRQtyALY" style="height: 240px"></div>
                                                        </div>
                                                    </div>
                                                </dx:ContentControl>
                                            </ContentCollection>
                                        </dx:TabPage>
                                        <dx:TabPage Text="Range (Amt)">
                                            <ContentCollection>
                                                <dx:ContentControl runat="server">
                                                    <div class="row">
                                                        <div class="col-md-6">
                                                            <div id="ctnRAmtAT" style="height: 240px"></div>
                                                        </div>
                                                        <div class="col-md-6">
                                                            <div id="ctnRAmtALY" style="height: 240px"></div>
                                                        </div>
                                                    </div>
                                                </dx:ContentControl>
                                            </ContentCollection>
                                        </dx:TabPage>
                                </TabPages>
                            </dx:ASPxPageControl>
                        </fieldset>
                    </div>
                </div>
                <div style="display: none">
                    <asp:Label ID="LbDay" runat="server" Text="Label"></asp:Label>
                    <asp:Label ID="LbLast_Year_Amt" runat="server" Text="Label"></asp:Label>
                    <asp:Label ID="LbLast_Year_Qty" runat="server" Text="Label"></asp:Label>
                    <asp:Label ID="LbResult_Amt" runat="server" Text="Label"></asp:Label>
                    <asp:Label ID="LbResult_Qty" runat="server" Text="Label"></asp:Label>
                    <asp:Label ID="LbTargetQty" runat="server" Text="Label"></asp:Label>
                    <asp:Label ID="LbTargetAmt" runat="server" Text="Label"></asp:Label>
                    <asp:Label ID="LbQtyAT" runat="server" Text="Label"></asp:Label>
                    <asp:Label ID="LbAmtAT" runat="server" Text="Label"></asp:Label>

                    <asp:Label ID="RTarget_Qty" runat="server" Text="Label"></asp:Label>
                    <asp:Label ID="RResult_Qty" runat="server" Text="Label"></asp:Label>
                    <asp:Label ID="RLast_Qty" runat="server" Text="Label"></asp:Label>
                    <asp:Label ID="RTarget_Amt" runat="server" Text="Label"></asp:Label>
                    <asp:Label ID="RResult_Amt" runat="server" Text="Label"></asp:Label>
                    <asp:Label ID="RLast_Amt" runat="server" Text="Label"></asp:Label>
                    <asp:Label ID="RLbRange" runat="server" Text="Label"></asp:Label>
                    <asp:Label ID="RAT_Qty" runat="server" Text="Label"></asp:Label>
                    <asp:Label ID="RALY_Qty" runat="server" Text="Label"></asp:Label>
                    <asp:Label ID="RAT_Amt" runat="server" Text="Label"></asp:Label>
                    <asp:Label ID="RALY_Amt" runat="server" Text="Label"></asp:Label>
                </div>
                <div class="row">
                    <div class="col-md-12">
                        <dx:ASPxPageControl runat="server" ID="pageControl" Width="100%" CssClass="dxtcFixed" ActiveTabIndex="0" EnableHierarchyRecreation="True">
                            <TabPages>
                                <dx:TabPage Text="Qty">
                                    <ContentCollection>
                                        <dx:ContentControl runat="server">
                                            <dx:ASPxGridView ID="grDataQty" runat="server" AutoGenerateColumns="false" Theme="Material" Width="100%">
                                                <Columns>
                                                    <%--<dx:GridViewDataTextColumn FieldName="Dealer" Caption="Dealer" Width="120px" VisibleIndex="0"></dx:GridViewDataTextColumn>
                                                    <dx:GridViewDataTextColumn FieldName="Province" Caption="Province" Width="120px" VisibleIndex="1"></dx:GridViewDataTextColumn>
                                                    <dx:GridViewDataTextColumn FieldName="Shop" Caption="ShopName" Width="250px" VisibleIndex="2"></dx:GridViewDataTextColumn>
                                                    <dx:GridViewDataTextColumn FieldName="Target_Qty" CellStyle-HorizontalAlign="Center" PropertiesTextEdit-DisplayFormatString="N0" Caption="Target" VisibleIndex="2"></dx:GridViewDataTextColumn>
                                                    <dx:GridViewDataTextColumn FieldName="Result_Qty" CellStyle-HorizontalAlign="Center" PropertiesTextEdit-DisplayFormatString="N0" Caption="Result" VisibleIndex="2"></dx:GridViewDataTextColumn>
                                                    <dx:GridViewDataTextColumn FieldName="AT_Qty" CellStyle-HorizontalAlign="Center" Caption="AT%" VisibleIndex="2"></dx:GridViewDataTextColumn>
                                                    <dx:GridViewDataTextColumn FieldName="Last_Year_Qty" CellStyle-HorizontalAlign="Center" PropertiesTextEdit-DisplayFormatString="N0" Caption="Last year" VisibleIndex="2"></dx:GridViewDataTextColumn>
                                                    <dx:GridViewDataTextColumn FieldName="ALY_Qty" CellStyle-HorizontalAlign="Center" Caption="ALY%" VisibleIndex="2"></dx:GridViewDataTextColumn>
                                                    <dx:GridViewDataColumn Width="110px" Caption="Detail">
                                                        <CellStyle HorizontalAlign="Center"></CellStyle>
                                                        <DataItemTemplate>
                                                            <a target="_blank" href='<%# "/sellout-by-shop/"+Eval("Product")+"/" + Eval("ShopId") + "/" + hdfKey.Get("Month") + "/2019/0" %>'>Click</a>
                                                        </DataItemTemplate>
                                                    </dx:GridViewDataColumn>--%>
                                                </Columns>
                                                <%--<TotalSummary>
                                                    <dx:ASPxSummaryItem FieldName="Shop" DisplayFormat="Total :{0:N0}" SummaryType="Count" />
                                                    <dx:ASPxSummaryItem FieldName="Target_Qty" DisplayFormat="N0" SummaryType="Sum" />
                                                    <dx:ASPxSummaryItem FieldName="Result_Qty" DisplayFormat="N0" SummaryType="Sum" />
                                                    <dx:ASPxSummaryItem FieldName="Last_Year_Qty" DisplayFormat="N0" SummaryType="Sum" />
                                                </TotalSummary>--%>
                                                <Settings HorizontalScrollBarMode="Visible" VerticalScrollBarStyle="Standard" VerticalScrollableHeight="370" VerticalScrollBarMode="Visible" />
                                                <SettingsBehavior AllowSort="true" ColumnResizeMode="Control" />
                                                <Styles>
                                                    <Header HorizontalAlign="Center" Wrap="True" Paddings-Padding="3px"></Header>
                                                    <Cell Wrap="True" VerticalAlign="Middle" Paddings-Padding="5px"></Cell>
                                                </Styles>
                                                <SettingsPager PageSize="200000"></SettingsPager>
                                            </dx:ASPxGridView>
                                        </dx:ContentControl>
                                    </ContentCollection>
                                </dx:TabPage>
                                <dx:TabPage Text="Amt">
                                    <ContentCollection>
                                        <dx:ContentControl runat="server">
                                            <dx:ASPxGridView ID="grData" runat="server" AutoGenerateColumns="false" OnLoad="grData_OnLoad" Theme="Material" Width="100%">
                                                <Columns>
                                                    <%--<dx:GridViewDataTextColumn FieldName="Dealer" Caption="Dealer" Width="120px" VisibleIndex="0"></dx:GridViewDataTextColumn>
                                                    <dx:GridViewDataTextColumn FieldName="Province" Caption="Province" Width="120px" VisibleIndex="1"></dx:GridViewDataTextColumn>
                                                    <dx:GridViewDataTextColumn FieldName="Shop" Caption="ShopName" VisibleIndex="2" Width="250px"></dx:GridViewDataTextColumn>
                                                    <dx:GridViewDataTextColumn FieldName="Target_Amt" CellStyle-HorizontalAlign="Center" Caption="Target" PropertiesTextEdit-DisplayFormatString="N0" VisibleIndex="2"></dx:GridViewDataTextColumn>
                                                    <dx:GridViewDataTextColumn FieldName="Result_Amt" CellStyle-HorizontalAlign="Center" Caption="Result" PropertiesTextEdit-DisplayFormatString="N0" VisibleIndex="2"></dx:GridViewDataTextColumn>
                                                    <dx:GridViewDataTextColumn FieldName="AT_Amt" CellStyle-HorizontalAlign="Center" Caption="AT%" VisibleIndex="2"></dx:GridViewDataTextColumn>
                                                    <dx:GridViewDataTextColumn FieldName="Last_Year_Amt" CellStyle-HorizontalAlign="Center" Caption="Last year" PropertiesTextEdit-DisplayFormatString="N0" VisibleIndex="2"></dx:GridViewDataTextColumn>
                                                    <dx:GridViewDataTextColumn FieldName="ALY_Amt" CellStyle-HorizontalAlign="Center" Caption="ALY%" VisibleIndex="2"></dx:GridViewDataTextColumn>
                                                    <dx:GridViewDataColumn Width="110px" Caption="Detail">
                                                        <CellStyle HorizontalAlign="Center"></CellStyle>
                                                        <DataItemTemplate>
                                                            <a target="_blank" href='<%# "/sellout-by-shop/"+Eval("Product")+"/" + Eval("ShopId") + "/" + hdfKey.Get("Month") + "/2019/0" %>'>Click</a>
                                                        </DataItemTemplate>
                                                    </dx:GridViewDataColumn>--%>
                                                </Columns>
                                                <%--<TotalSummary>
                                                    <dx:ASPxSummaryItem FieldName="Shop" DisplayFormat="Total :{0:N0}" SummaryType="Count" />
                                                    <dx:ASPxSummaryItem FieldName="Target_Amt" DisplayFormat="N0" SummaryType="Sum" />
                                                    <dx:ASPxSummaryItem FieldName="Result_Amt" DisplayFormat="N0" SummaryType="Sum" />
                                                    <dx:ASPxSummaryItem FieldName="Last_Year_Amt" DisplayFormat="N0" SummaryType="Sum" />
                                                </TotalSummary>--%>
                                                <Settings HorizontalScrollBarMode="Visible" VerticalScrollBarStyle="Standard" VerticalScrollableHeight="370" VerticalScrollBarMode="Visible" />
                                                <SettingsBehavior AllowSort="true" ColumnResizeMode="Control" />
                                                <Styles>
                                                    <Header HorizontalAlign="Center" Wrap="True" Paddings-Padding="3px"></Header>
                                                    <Cell Wrap="True" VerticalAlign="Middle" Paddings-Padding="5px"></Cell>
                                                </Styles>
                                                <SettingsPager PageSize="200000"></SettingsPager>
                                            </dx:ASPxGridView>
                                        </dx:ContentControl>
                                    </ContentCollection>
                                </dx:TabPage>
                            </TabPages>
                        </dx:ASPxPageControl>
                    </div>
                </div>
            </dx:PanelContent>
        </PanelCollection>
    </dx:ASPxCallbackPanel>
    <dx:ASPxHiddenField ID="hdfKey" ClientInstanceName="hdfKey" runat="server"></dx:ASPxHiddenField>
</asp:Content>
