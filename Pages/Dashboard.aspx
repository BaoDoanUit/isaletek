<%@ Page Title="" Language="C#" MasterPageFile="~/Layout.master" AutoEventWireup="true" CodeBehind="Dashboard.aspx.cs" Inherits="WebApplication.Pages.Dashboard" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Content" runat="server">
    <script src="/Scripts/jquery-1.12.2.min.js"></script>
    <script src="/Scripts/highstock.js"></script>
    <script src="/Scripts/highcharts.js"></script>
    <div class="container">
        <div class="row marginTop20">
            <div class="col-md-12">
                <div class="form-group col-md-3">
                    <label>Filter by</label>
                    <div class="input-group">
                        <asp:RadioButtonList ID="rdfilter" RepeatDirection="Horizontal" runat="server">
                            <asp:ListItem  Value="1">Daily</asp:ListItem>
                            <asp:ListItem Value="2">Weekly</asp:ListItem>
                            <asp:ListItem Selected="True" Value="3">Monthly</asp:ListItem>
                            <asp:ListItem Value="4">Yearly</asp:ListItem>
                        </asp:RadioButtonList>
                    </div>
                </div>
                <div class="form-group col-md-3" id="from" style="display: none">
                    <label>Day</label>
                    <div class="input-group">
                        <dx:ASPxDateEdit runat="server" ID="fFromDate" DisplayFormatString="yyyy-MM-dd"
                            EditFormat="Custom" EditFormatString="yyyy-MM-dd" ClientInstanceName="fFromDate">
                            <ClearButton DisplayMode="OnHover"></ClearButton>
                        </dx:ASPxDateEdit>
                    </div>
                </div>
                <div class="form-group col-md-3" id="to" style="display: none">
                    <label>To</label>
                    <div class="input-group">
                        <dx:ASPxDateEdit runat="server" ID="fToDate" DisplayFormatString="yyyy-MM-dd"
                            EditFormat="Custom" EditFormatString="yyyy-MM-dd" ClientInstanceName="fToDate">
                            <ClearButton DisplayMode="OnHover"></ClearButton>
                        </dx:ASPxDateEdit>
                    </div>
                </div>
                <div class="form-group col-md-3" id="Year" >
                    <label>Year</label>
                    <div class="input-group">
                        <dx:ASPxComboBox runat="server" ID="ddlYear"  ValueType="System.String"  ClientInstanceName="ddlYear">
                            <Items>
                                <dx:ListEditItem Text="2017" Value="2017" />
                                <dx:ListEditItem Text="2018" Value="2018" />
                                <dx:ListEditItem Text="2019" Value="2019" />
                            </Items>
                        </dx:ASPxComboBox>
                    </div>
                </div>
                <div class="form-group col-md-3" id="Month"  >
                    <label>Month</label>
                    <div class="input-group">
                        <dx:ASPxComboBox runat="server" ID="ddlMonth"
                            ValueType="System.String" 
                            ClientInstanceName="ddlMonth">
                            <Items>
                                <dx:ListEditItem Text="1" Value="1" />
                                <dx:ListEditItem Text="2" Value="2" />
                                <dx:ListEditItem Text="3" Value="3" />
                                <dx:ListEditItem Text="4" Value="4" />
                                <dx:ListEditItem Text="5" Value="5" />
                                <dx:ListEditItem Text="6" Value="6" />
                                <dx:ListEditItem Text="7" Value="7" />
                                <dx:ListEditItem Text="8" Value="8" />
                                <dx:ListEditItem Text="9" Value="9" />
                                <dx:ListEditItem Text="10" Value="10" />
                                <dx:ListEditItem Text="11" Value="11" />
                                <dx:ListEditItem Text="12" Value="12" />
                            </Items>
                        </dx:ASPxComboBox>
                    </div>
                </div>
                <div class="form-group col-md-3" id="Week" style="display: none">
                    <label>Week</label>
                    <div class="input-group">
                        <dx:ASPxComboBox runat="server" ID="ddlWeek"
                            ValueType="System.String" 
                            ClientInstanceName="ddlWeek">
                            <Items>
                                <dx:ListEditItem Text="1" Value="1" />
                                <dx:ListEditItem Text="2" Value="2" />
                                <dx:ListEditItem Text="3" Value="3" />
                                <dx:ListEditItem Text="4" Value="4" />
                                <dx:ListEditItem Text="5" Value="5" />
                            </Items>
                        </dx:ASPxComboBox>
                    </div>
                </div>
                <div class="form-group col-md-3">
                    <label>Region</label>
                    <div class="input-group">
                        <dx:ASPxComboBox runat="server" ID="cbRegion" ValueField="Region"
                            ValueType="System.String" NullText="Choose to filter by Region"
                            ClientInstanceName="cbRegion" CallbackPageSize="10" DataSourceID="odsRegion">
                            <ClearButton DisplayMode="OnHover"></ClearButton>
                            <ClientSideEvents SelectedIndexChanged="function(s,e){cbCity.PerformCallback(s.GetValue());cbOutlet.PerformCallback(cbRegion.GetValue()+';'+cbCity.GetValue()+';'+cbAccount.GetValue());}" />
                            <Columns>
                                <dx:ListBoxColumn FieldName="Region" />
                            </Columns>
                        </dx:ASPxComboBox>
                        <asp:ObjectDataSource ID="odsRegion" runat="server" SelectMethod="getDivision" TypeName="LogicTier.Controllers.OutletBL">
                            <SelectParameters>
                                <asp:Parameter DefaultValue="Region" Name="fieldName" Type="String" />
                                <asp:Parameter Name="fieldValue" Type="String" />
                                <asp:Parameter DefaultValue="Region" Name="fieldDisplay" Type="String" />
                            </SelectParameters>
                        </asp:ObjectDataSource>
                    </div>
                </div>
                <div class="form-group col-md-3">
                    <label>City</label>
                    <div class="input-group">
                        <dx:ASPxComboBox runat="server" ID="cbCity" OnCallback="cbCity_Callback"
                            ValueType="System.String" NullText="Choose to filter by City" ValueField="City"
                            ClientInstanceName="cbCity" CallbackPageSize="10" DataSourceID="odsCity">
                            <ClearButton DisplayMode="OnHover"></ClearButton>
                            <ClientSideEvents SelectedIndexChanged="function(s,e){cbOutlet.PerformCallback(cbRegion.GetValue()+';'+cbCity.GetValue()+';'+cbAccount.GetValue());}" />
                            <Columns>
                                <dx:ListBoxColumn FieldName="City" />
                            </Columns>
                        </dx:ASPxComboBox>
                        <asp:ObjectDataSource ID="odsCity" runat="server" SelectMethod="getDivision" TypeName="LogicTier.Controllers.OutletBL">
                            <SelectParameters>
                                <asp:Parameter DefaultValue="City" Name="fieldName" Type="String" />
                                <asp:Parameter Name="fieldValue" Type="String" />
                                <asp:Parameter DefaultValue="City" Name="fieldDisplay" Type="String" />
                            </SelectParameters>
                        </asp:ObjectDataSource>
                    </div>
                </div>
                <div class="form-group col-md-3">
                    <label>Suppervisor</label>
                    <div class="input-group">
                        <dx:ASPxComboBox runat="server" ID="cbLearder" ValueField="EmployeeId"
                            ValueType="System.Int32" NullText="Choose to filter by Leader person"
                            ClientInstanceName="cbLearder" CallbackPageSize="10"  OnInit="cbLearder_Init"
                            IncrementalFilteringMode="Contains" TextFormatString="{0}" EnableCallbackMode="true" DropDownStyle="DropDownList">
                            <ClientSideEvents SelectedIndexChanged="function(s,e){cbEmployee.PerformCallback(s.GetValue());}" />
                            <ClearButton DisplayMode="OnHover"></ClearButton>
                            <Columns>
                                <dx:ListBoxColumn FieldName="EmployeeName" />
                            </Columns>
                        </dx:ASPxComboBox>
                        <asp:ObjectDataSource ID="odsLeader" runat="server" SelectMethod="getList" TypeName="LogicTier.Controllers.EmployeeBL">
                            <SelectParameters>
                                <asp:Parameter Name="empId" Type="Int32" />
                                <asp:Parameter Name="empCode" Type="String" />
                                <asp:Parameter Name="pos" Type="String" />
                                <asp:Parameter Name="parentId" Type="Int32" />
                                <asp:Parameter Name="userName" Type="String" />
                            </SelectParameters>
                        </asp:ObjectDataSource>
                    </div>
                </div>
                <div class="form-group col-md-3">
                    <label>Employee</label>
                    <div class="input-group">
                        <dx:ASPxComboBox runat="server" ID="cbEmployee" OnCallback="cbEmployee_Callback"
                            ValueType="System.Int32" NullText="Choose to filter by Employee person" ValueField="EmployeeId"
                            ClientInstanceName="cbEmployee" CallbackPageSize="10" DataSourceID="odsEmployee"
                            IncrementalFilteringMode="Contains" TextFormatString="{0}" EnableCallbackMode="true" DropDownStyle="DropDownList">
                            <ClearButton DisplayMode="OnHover"></ClearButton>
                            <Columns>
                                <dx:ListBoxColumn FieldName="EmployeeName" />
                            </Columns>
                        </dx:ASPxComboBox>
                        <asp:ObjectDataSource ID="odsEmployee" runat="server" SelectMethod="getList" TypeName="LogicTier.Controllers.EmployeeBL">
                            <SelectParameters>
                                <asp:Parameter Name="empId" Type="Int32" />
                                <asp:Parameter Name="empCode" Type="String" />
                                <asp:Parameter Name="pos" Type="String" />
                                <asp:Parameter Name="parentId" Type="Int32" />
                                <asp:Parameter Name="userName" Type="String" />
                            </SelectParameters>
                        </asp:ObjectDataSource>
                    </div>
                </div>
                <div class="form-group col-md-12">
                    <dx:ASPxButton ID="FilterButton" AutoPostBack="false" runat="server" Text="Tìm kiếm">
                        <ClientSideEvents Click="function (s, e) {FilterData();}" />
                    </dx:ASPxButton>
                </div>
            </div>
        </div>
        <div class="col-md-12">
            <div id="dvTab" class="dxtcLite_Moderno dxtcSys dxtc-flex dxtc-top dxtc-pc" style="width: 100%; overflow: visible;">
                <ul id="tabs" class="dxtc-strip dxtc-row dxtc-alLeft dxtc-stripContainer">
                    <li class="dxtc-leftIndent">&nbsp;</li>
                    <li class="dxtc-activeTab dxtc-lead " style="height: 29px;" id="lilevel1">
                        <a class="dxtc-link" href="#level1">
                            <span class="dx-vam">Sell Out</span></a></li>
                    <li class="dxtc-tab dxtc-lead " style="height: 29px;" id="lilevel2">
                        <a class="dxtc-link" href="#level2" id="alevel2">
                            <span class="dx-vam">Display</span></a>
                    </li>
                    <li class="dxtc-rightIndent">&nbsp;</li>
                </ul>
                <div class="dxtc-content" style="width: 100%; max-width: 1110px">
                    <div style="width: 100%; float: left; max-width: 1110px" id="level1">
                        <div class="row">
                            <div class="col-md-7" id="selltrend"></div>
                            <div class="col-md-5">
                                <div class="col-md-12" id="sellaccount"></div>
                                <div class="col-md-12" id="sellproduct"></div>

                            </div>
                            <div class="col-md-12" id="sellregion"></div>
                        </div>
                    </div>
                    <div id="level2" style="width: 100%; float: left; max-width: 1110px" class="hide">
                        <div class="row">
                            <div class="col-md-6" id="displaybybrand"></div>
                            <div class="col-md-6" id="displaybytotalbrand"></div>
                            <div class="col-md-12" id="displaybydetail">
                            </div>
                        </div>
                    </div>
                </div>
            </div>

        </div>
    </div>
    <script type="text/javascript">
        $(document).ready(function () {
            FilterData();
        });
        function FilterData() {
            selltrend();
            sellaccount();
            sellProduct();
            SelloutRegion();
            Display();
            MarketSharebyProductbybrand();

        }
        function selltrend() {
            var FromDate = fFromDate.GetText();
            //var ToDate = fToDate.GetText();
            var ToDate = fFromDate.GetText();
            var Region = cbRegion.GetValue();
            var City = cbCity.GetValue();
            var ParentId = cbLearder.GetValue();
            var EmployeeId = cbLearder.GetValue();
            var UserName = '<%=userInfo.UserName%>';
            var Year = ddlYear.GetValue();
            var Month = ddlMonth.GetValue();
            var Week = ddlWeek.GetValue();
            var Filter = $('#Content_rdfilter input:checked').val();
            var formData = new FormData();
            formData.append('FromDate', FromDate);
            formData.append('ToDate', ToDate);
            formData.append('Region', Region);
            formData.append('City', City);
            formData.append('ParentId', ParentId);
            formData.append('EmployeeId', EmployeeId);
            formData.append('UserName', UserName);
            formData.append('Year', Year);
            formData.append('Month', Month);
            formData.append('Week', Week);
            formData.append('Filter', Filter);
            formData.append('Function', 'SELLOUT');
            formData.append('Type', "TREND");
            $.ajax({
                type: 'post',
                url: '/Handler/DashboardHandler.ashx',
                data: formData,
                success: function (status) {
                    if (status != 'error' && status != '') {
                        var myArr = $.parseJSON(status);
                        Highcharts.chart('selltrend', {
                            chart: { type: 'column', height: 600 },
                            credits: { enabled: false },
                            title: { text: myArr.Title },
                            scrollbar: { enabled: true },
                            xAxis: { max: 10, categories: myArr.Categories, crosshair: true, labels: { rotation: 270 } },
                            yAxis: { min: 0, title: { text: '10 Triệu đồng' } },
                            tooltip: {  shared: true },
                            series: myArr.Series
                        });
                    }
                },
                processData: false,
                contentType: false,
                error: function () {
                    //alert("Whoops something went wrong!");
                }
            });


        }
        function sellaccount() {
            var FromDate = fFromDate.GetText();
            //var ToDate = fToDate.GetText();
            var ToDate = fFromDate.GetText();
            var Region = cbRegion.GetValue();
            var City = cbCity.GetValue();
            var ParentId = cbLearder.GetValue();
            var EmployeeId = cbLearder.GetValue();
            var UserName = '<%=userInfo.UserName%>';
            var Year = ddlYear.GetValue();
            var Month = ddlMonth.GetValue();
            var Week = ddlWeek.GetValue();
            var Filter = $('#Content_rdfilter input:checked').val();

            var formData = new FormData();
            formData.append('FromDate', FromDate);
            formData.append('ToDate', ToDate);
            formData.append('Region', Region);
            formData.append('City', City);
            formData.append('ParentId', ParentId);
            formData.append('EmployeeId', EmployeeId);
            formData.append('UserName', UserName);
            formData.append('Year', Year);
            formData.append('Month', Month);
            formData.append('Week', Week);
            formData.append('Filter', Filter);
            formData.append('Function', 'SELLOUT');
            formData.append('Type', "ACCOUNT");
            $.ajax({
                type: 'post',
                url: '/Handler/DashboardHandler.ashx',
                data: formData,
                success: function (status) {
                    if (status != 'error' && status != '') {
                        var myArr = $.parseJSON(status);
                        Highcharts.chart('sellaccount', {
                            chart: { type: 'column', height: 300 },
                            credits: { enabled: false },
                            title: { text: myArr.Title },
                            xAxis: { categories: myArr.Categories, crosshair: true },
                            yAxis: { min: 0, title: { text: '10 Triệu đồng' } },
                            tooltip: { shared: true },
                            series: myArr.Series
                        });
                    }
                },
                processData: false,
                contentType: false,
                error: function () {
                    //alert("Whoops something went wrong!");
                }
            });


        }
        function sellProduct() {
            var FromDate = fFromDate.GetText();
            //var ToDate = fToDate.GetText();
            var ToDate = fFromDate.GetText();
            var Region = cbRegion.GetValue();
            var City = cbCity.GetValue();
            var ParentId = cbLearder.GetValue();
            var EmployeeId = cbLearder.GetValue();
            var UserName = '<%=userInfo.UserName%>';
            var Year = ddlYear.GetValue();
            var Month = ddlMonth.GetValue();
            var Week = ddlWeek.GetValue();
            var Filter = $('#Content_rdfilter input:checked').val();

            var formData = new FormData();
            formData.append('FromDate', FromDate);
            formData.append('ToDate', ToDate);
            formData.append('Region', Region);
            formData.append('City', City);
            formData.append('ParentId', ParentId);
            formData.append('EmployeeId', EmployeeId);
            formData.append('UserName', UserName);
            formData.append('Year', Year);
            formData.append('Month', Month);
            formData.append('Week', Week);
            formData.append('Filter', Filter);
            formData.append('Function', 'SELLOUT');
            formData.append('Type', "PRODUCT");

            $.ajax({
                type: 'post',
                url: '/Handler/DashboardHandler.ashx',
                data: formData,
                success: function (status) {
                    if (status != 'error' && status != '') {
                        var myArr = $.parseJSON(status);
                        Highcharts.chart('sellproduct', {
                            chart: { type: 'pie', height: 300 },
                            credits: { enabled: false },
                            title: { text: myArr.Title },
                            tooltip: {
                                formatter: function () {
                                    return '<b>' + this.point.name + '</b>: ' + Math.round(this.percentage, 2) + '%';
                                }
                            },
                            plotOptions: {
                                pie: {
                                    allowPointSelect: true,
                                    
                                    cursor: 'pointer',
                                    dataLabels: {
                                        enabled: true,
                                        color: '#000000',
                                        connectorColor: '#000000',
                                        formatter: function () {
                                            return '<b>' + this.point.name + '</b>: ' + Math.round(this.percentage, 2) + '%';
                                        }
                                    }
                                }
                            },
                            series: myArr.Series
                        });
                    }
                },
                processData: false,
                contentType: false,
                error: function () {
                    //alert("Whoops something went wrong!");
                }
            });
        }

        function Display() {
            var FromDate = fFromDate.GetText();
            //var ToDate = fToDate.GetText();
            var ToDate = fFromDate.GetText();
            var Region = cbRegion.GetValue();
            var City = cbCity.GetValue();
            var ParentId = cbLearder.GetValue();
            var EmployeeId = cbLearder.GetValue();
            var UserName = '<%=userInfo.UserName%>';
            var Year = ddlYear.GetValue();
            var Month = ddlMonth.GetValue();
            var Week = ddlWeek.GetValue();
            var Filter = $('#Content_rdfilter input:checked').val();

            var formData = new FormData();
            formData.append('FromDate', FromDate);
            formData.append('ToDate', ToDate);
            formData.append('Region', Region);
            formData.append('City', City);
            formData.append('ParentId', ParentId);
            formData.append('EmployeeId', EmployeeId);
            formData.append('UserName', UserName);
            formData.append('Year', Year);
            formData.append('Month', Month);
            formData.append('Week', Week);
            formData.append('Filter', Filter);
            formData.append('Function', 'DISPLAY');
            formData.append('Type', "BRAND");

            $.ajax({
                type: 'post',
                url: '/Handler/DashboardHandler.ashx',
                data: formData,
                success: function (status) {
                    if (status != 'error' && status != '') {
                        var myArr = $.parseJSON(status);
                        Highcharts.chart('displaybybrand', {
                            chart: { type: 'pie', height: 300 },
                            credits: { enabled: false },
                            title: { text: myArr[0].Title },
                            tooltip: {
                                formatter: function () {
                                    return '<b>' + this.point.name + '</b>: ' + Math.round(this.percentage, 2) + '%';
                                }
                            },
                            plotOptions: {
                                pie: {
                                    allowPointSelect: true,
                                    cursor: 'pointer',
                                    dataLabels: {
                                        enabled: true,
                                        color: '#000000',
                                        connectorColor: '#000000',
                                        formatter: function () {
                                            return '<b>' + this.point.name + '</b>: ' + Math.round(this.percentage, 2) + '%';
                                        }
                                    }
                                }
                            },
                            series: myArr[0].Series
                        });
                        Highcharts.chart('displaybytotalbrand', {
                            chart: { type: 'pie', height: 300 },
                            credits: { enabled: false },
                            title: { text: myArr[1].Title },
                            tooltip: {
                                formatter: function () {
                                    return '<b>' + this.point.name + '</b>: ' + Math.round(this.percentage, 2) + '%';
                                }
                            },
                            plotOptions: {
                                pie: {
                                    allowPointSelect: true,
                                    cursor: 'pointer',
                                    dataLabels: {
                                        enabled: true,
                                        color: '#000000',
                                        connectorColor: '#000000',
                                        formatter: function () {
                                            return '<b>' + this.point.name + '</b>: ' + Math.round(this.percentage, 2) + '%';
                                        }
                                    }
                                }
                            },
                            series: myArr[1].Series
                        });
                    }
                },
                processData: false,
                contentType: false,
                error: function () {
                    //alert("Whoops something went wrong!");
                }
            });
        }

        function MarketSharebyProductbybrand() {
            var FromDate = fFromDate.GetText();
            //var ToDate = fToDate.GetText();
            var ToDate = fFromDate.GetText();
            var Region = cbRegion.GetValue();
            var City = cbCity.GetValue();
            var ParentId = cbLearder.GetValue();
            var EmployeeId = cbLearder.GetValue();
            var UserName = '<%=userInfo.UserName%>';
            var Year = ddlYear.GetValue();
            var Month = ddlMonth.GetValue();
            var Week = ddlWeek.GetValue();
            var Filter = $('#Content_rdfilter input:checked').val();
            var formData = new FormData();
            formData.append('FromDate', FromDate);
            formData.append('ToDate', ToDate);
            formData.append('Region', Region);
            formData.append('City', City);
            formData.append('ParentId', ParentId);
            formData.append('EmployeeId', EmployeeId);
            formData.append('UserName', UserName);
            formData.append('Year', Year);
            formData.append('Month', Month);
            formData.append('Week', Week);
            formData.append('Filter', Filter);
            formData.append('Function', 'DISPLAY');
            formData.append('Type', "PRODUCT");
            $.ajax({
                type: 'post',
                url: '/Handler/DashboardHandler.ashx',
                data: formData,
                success: function (status) {
                    if (status != 'error' && status != '') {
                        var myArr = $.parseJSON(status);
                        Highcharts.chart('displaybydetail', {
                            chart: { type: 'column' },
                            credits: { enabled: false },
                            title: { text: myArr.Title },
                            //scrollbar: { enabled: true },
                            xAxis: { categories: myArr.Categories, crosshair: true },
                            yAxis: { min: 0 },
                            tooltip: { shared: true },
                            series: myArr.Series
                        });
                    }
                },
                processData: false,
                contentType: false,
                error: function () {
                    //alert("Whoops something went wrong!");
                }
            });


        }
        function SelloutRegion() {
            var FromDate = fFromDate.GetText();
            //var ToDate = fToDate.GetText();
            var ToDate = fFromDate.GetText();
            var Region = cbRegion.GetValue();
            var City = cbCity.GetValue();
            var ParentId = cbLearder.GetValue();
            var EmployeeId = cbLearder.GetValue();
            var UserName = '<%=userInfo.UserName%>';
            var Year = ddlYear.GetValue();
            var Month = ddlMonth.GetValue();
            var Week = ddlWeek.GetValue();
            var Filter = $('#Content_rdfilter input:checked').val();
            var formData = new FormData();
            formData.append('FromDate', FromDate);
            formData.append('ToDate', ToDate);
            formData.append('Region', Region);
            formData.append('City', City);
            formData.append('ParentId', ParentId);
            formData.append('EmployeeId', EmployeeId);
            formData.append('UserName', UserName);
            formData.append('Year', Year);
            formData.append('Month', Month);
            formData.append('Week', Week);
            formData.append('Filter', Filter);
            formData.append('Function', 'SELLOUT');
            formData.append('Type', "REGION");
            $.ajax({
                type: 'post',
                url: '/Handler/DashboardHandler.ashx',
                data: formData,
                success: function (status) {
                    if (status != 'error' && status != '') {
                        var myArr = $.parseJSON(status);
                        Highcharts.chart('sellregion', {
                            chart: { type: 'column' },
                            credits: { enabled: false },
                            title: { text: myArr.Title },
                            //scrollbar: { enabled: true },
                            xAxis: { categories: myArr.Categories, crosshair: true },
                            yAxis: { min: 0,  title: { text: '10 Triệu đồng' } },
                            tooltip: { shared: true },
                            series: myArr.Series
                        });
                    }
                },
                processData: false,
                contentType: false,
                error: function () {
                    //alert("Whoops something went wrong!");
                }
            });


        }
    </script>
    <script type="text/javascript">

        var tabLinks = new Array();
        var contentDivs = new Array();
        var tabLinkLi = new Array();

        function init() {

            // Grab the tab links and content divs from the page
            var tabListItems = document.getElementById('tabs').childNodes;
            for (var i = 0; i < tabListItems.length; i++) {
                if (tabListItems[i].nodeName == "LI") {
                    try {
                        var tabLink = getFirstChildWithTagName(tabListItems[i], 'A');
                        var id = getHash(tabLink.getAttribute('href'));
                        tabLinks[id] = tabLink;
                        contentDivs[id] = document.getElementById(id);
                        tabLinkLi[id] = document.getElementById('li' + id);
                    } catch (e) { }

                }
            }
            // Assign onclick events to the tab links, and
            // highlight the first tab
            var i = 0;
            for (var id in tabLinks) {
                tabLinks[id].onclick = showTab;
                tabLinks[id].onfocus = function () { this.blur() };
                if (i == 0) tabLinkLi[id].className = 'dxtc-activeTab dxtc-lead';
                i++;
            }
            // Hide all content divs except the first
            var i = 0;
            for (var id in contentDivs) {
                if (i != 0) contentDivs[id].className = '  hide';
                i++;
            }

        }
        function showTab() {
            FilterData();
            var selectedId = getHash(this.getAttribute('href'));

            // Highlight the selected tab, and dim all others.
            // Also show the selected content div, and hide all others.
            for (var id in contentDivs) {
                if (id == selectedId) {
                    tabLinkLi[id].className = 'dxtc-activeTab dxtc-lead ';
                    contentDivs[id].className = '';
                } else {
                    tabLinkLi[id].className = 'dxtc-tab dxtc-lead';
                    contentDivs[id].className = 'hide';
                }
            }
            // Stop the browser following the link
            return false;
        }
        function getFirstChildWithTagName(element, tagName) {
            for (var i = 0; i < element.childNodes.length; i++) {
                if (element.childNodes[i].nodeName == tagName) return element.childNodes[i];
            }
        }
        function getHash(url) {
            var hashPos = url.lastIndexOf('#');
            return url.substring(hashPos + 1);
        }
        $("dvTab").ready(function () {
            init();
        });
    </script>
    <script>
        $(document).ready(function () {
            $('#Content_rdfilter').change(function () {

                var val = $('#Content_rdfilter input:checked').val();
                if (val == "1") {
                    $('#from').fadeIn();
                    $('#Year').fadeOut();
                    $('#Week').fadeOut();
                    $('#Month').fadeOut();
                } else if (val == "2") {
                    $('#from').fadeOut();
                    $('#Year').fadeIn();
                    $('#Month').fadeIn();
                    $('#Week').fadeIn();
                } else if (val == "3") {
                    $('#from').fadeOut();
                    $('#Year').fadeIn();
                    $('#Month').fadeIn();
                    $('#Week').fadeOut();
                } else if (val == "4") {
                    $('#from').fadeOut();
                    $('#Year').fadeIn();
                    $('#Month').fadeOut();
                    $('#Week').fadeOut();
                }
                FilterData();
            });
        });
    </script>
    <style>
        .hide {
            display: none
        }
    </style>
</asp:Content>
