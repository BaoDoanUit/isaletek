$(document).ready(function () {
    if (hdfKey.Get("empId") == 90) {
        evnent_region();
        sales_region();
        tablesshare_region();
        sampling_region();
    }
    else {
        evnent_region();
        sales_region();
        tablesshare_region();
        sampling_region();
        posm_region();
        bpashift_region();
        $('#posm').show();
        $('#bpashift').show();
    }

});
var attenId = "container_attendance", salesId = "container_sale", tableshareid = "container_tableshare",
    conversionrateId = "container_conversionrate", samplingid = "container_sampling", posmid = "container_posm",
    evnentId = "container_events", bpashiftId = "container_bpashift";
/** atten */
function atten(title, url, data, id, _click, value) {
    var height = 400;
    $.post(url, data, function (data) {
        var categories = [],
            series = [
                { name: 'Plan', data: [], type: 'column', color: '#0070c0', yAxis: 0, },
                { name: 'Actual', data: [], type: 'column', color: '#00b050', yAxis: 0 },
                { name: '% Achievement', data: [], type: 'line', color: '#ba1e0d', yAxis: 1 }
            ];


        var myArr = $.parseJSON(data);
        for (var i = 0; i < myArr.length; i++) {
            categories.push(myArr[i].categories);
            series[0].data.push(myArr[i].Plan);
            series[1].data.push(myArr[i].Actual);
            series[2].data.push(myArr[i].Achievement);

        }
        var chart = Highcharts.chart(id, {
            chart: { height: height },
            title: { text: title },
            legend: {
                align: 'center',
                backgroundColor: '#FFFFFF',
                borderWidth: 1,
                layout: 'horizontal', shadow: true,
                verticalAlign: 'bottom'
            },
            plotOptions: {
                column: {
                    cursor: 'pointer',
                    dataLabels: {
                        enabled: true,
                        formatter: function () { return ' ' + this.y; },
                        style: { fontSize: '11px' }
                    },
                    point: {
                        events: {
                            click: function () {
                                if (_click === "region") {
                                    atten_bycity(this.category);
                                } else if (_click === "city") {
                                    atten_byshop(this.category, value);
                                }
                                else if (_click === "week") {
                                    atten_date(this.category);
                                }
                            }
                        }
                    }
                },
                line: {
                    cursor: 'pointer',
                    dataLabels: { enabled: true, formatter: function () { return ' ' + this.y + '%'; } },
                    point: {
                        events: {
                            click: function () {
                                if (_click === "region") {
                                    atten_bycity(this.category);
                                }
                                else if (_click === "city") {
                                    atten_byshop(this.category, value);
                                }
                                else if (_click === "week") {
                                    atten_date(this.category);
                                }
                            }
                        }
                    }
                }
            },
            tooltip: { shared: true },
            xAxis: {
                categories: categories,
                labels: { autoRotation: 0 }
            },
            yAxis: [{
                labels: { format: '{value}' },
                title: { text: null }
            }, {
                labels: { format: '{value}%' },
                min: 0,
                opposite: true, title: { text: null }
            }],
            series: series,
            credits: { enabled: false }
        });
    });
}
function atten_region() {
    var url = "/chart/Attendance/ByRegion.ashx";
    var data = { projectId: hdfKey.Get("pId"), userId: hdfKey.Get("empId") };
    //var _click = "function () {atten_bycity(this.category);}";
    var _click = "region";
    atten("ATTENDANCE BY REGION", url, data, attenId, _click);
    $('#backatten').html('');
}
function atten_bycity(key) {
    var url = "/chart/Attendance/ByCity.ashx";
    var data = { projectId: hdfKey.Get("pId"), userId: hdfKey.Get("empId"), region: (key === "Total" ? null : key) }
    var _click = "city";
    var value = key;
    atten("ATTENDANCE BY CITY", url, data, attenId, _click, value);
    var element = "<a class='btn btn-secondary' onclick=\"javascript: atten_region();\" >< Back</a>";
    $('#backatten').html(element);
}
function atten_byshop(key, key2) {
    var url = "/chart/Attendance/ByShop.ashx";
    var data = { projectId: hdfKey.Get("pId"), userId: hdfKey.Get("empId"), region: (key2 === "Total" ? null : key2), city: (key === "Total" ? null : key) }
    atten("ATTENDANCE BY SHOP", url, data, attenId);
    var element = "<a class='btn btn-secondary' onclick=\"javascript: atten_bycity('" + key2 + "');\" >< Back</a>";
    $('#backatten').html(element);
}
function atten_week() {
    var url = "/chart/Attendance/ByWeek.ashx";
    var data = { projectId: hdfKey.Get("pId"), userId: hdfKey.Get("empId") };
    var _click = "week";
    atten("ATTENDANCE BY WEEK", url, data, attenId, _click);
    $('#backatten').html('');
}
function atten_date(key) {
    var url = "/chart/Attendance/ByDate.ashx";
    var data = { projectId: hdfKey.Get("pId"), userId: hdfKey.Get("empId"), week: (key === "Total" ? null : key) };
    atten("ATTENDANCE BY DATE", url, data, attenId);
    var element = "<a class='btn btn-secondary' onclick=\"javascript: atten_week() ;\" >< Back</a>";
    $('#backatten').html(element);
}



/** Sales */

function sales(title, url, data, id, _click, value) {
    var height = 400;
    $.post(url, data, function (data) {
        var categories = [],
            series = [
                { name: 'BGT agency BPA', data: [], type: 'column', color: '#0070c0', yAxis: 0, },
                { name: 'ACT agency BPA', data: [], type: 'column', color: '#00b050', yAxis: 0 },
                { name: 'ACT TOTAL BPA', data: [], type: 'column', color: '#ff3333', yAxis: 0 },
                { name: '% Achievement', data: [], type: 'line', color: '#ba1e0d', yAxis: 1 }
            ];


        var myArr = $.parseJSON(data);
        for (var i = 0; i < myArr.length; i++) {
            categories.push(myArr[i].categories);
            series[0].data.push(myArr[i].KPI);
            series[1].data.push(myArr[i].Actual);
            series[2].data.push(myArr[i].TotalQuantity );
            series[3].data.push(myArr[i].Achievement);

        }
        var chart = Highcharts.chart(id, {
            chart: { height: height },
            title: { text: title },
            legend: {
                align: 'center',
                backgroundColor: '#FFFFFF',
                borderWidth: 1,
                layout: 'horizontal', shadow: true,
                verticalAlign: 'bottom'
            },
            plotOptions: {
                column: {
                    cursor: 'pointer',
                    dataLabels: {
                        enabled: true,
                        formatter: function () { return ' ' + this.y; },
                        style: { fontSize: '11px' }
                    },
                    point: {
                        events: {
                            click: function () {
                                if (_click === "region") {
                                    sales_bycity(this.category);
                                } else if (_click === "city") {
                                    sales_byshop(this.category, value);
                                }
                                else if (_click === "week") {
                                    sales_date(this.category);
                                }
                            }
                        }
                    }
                },
                line: {
                    cursor: 'pointer',
                    dataLabels: { enabled: true, formatter: function () { return ' ' + this.y + '%'; } },
                    point: {
                        events: {
                            click: function () {
                                if (_click === "region") {
                                    sales_bycity(this.category);
                                }
                                else if (_click === "city") {
                                    sales_byshop(this.category, value);
                                }
                                else if (_click === "week") {
                                    sales_date(this.category);
                                }
                            }
                        }
                    }
                }
            },
            tooltip: { shared: true },
            xAxis: {
                categories: categories,
                labels: { autoRotation: 0 }
            },
            yAxis: [{
                labels: { format: '{value}' },
                title: { text: 'case' }
            }, {
                labels: { format: '{value}%' },
                min: 0,
                opposite: true, title: { text: null }
            }],
            series: series,
            credits: { enabled: false }
        });
    });
}
function sales_region() {
    var url = "/chart/Sales/ByRegion.ashx";
    var data = { projectId: hdfKey.Get("pId"), userId: hdfKey.Get("empId") };
    //var _click = "function () {atten_bycity(this.category);}";
    var _click = "region";
    sales("BECK'S ICE SALE VOLUME BY REGION", url, data, salesId, _click);
    $('#backsale').html('');
}
function sales_bycity(key) {
    var url = "/chart/Sales/ByCity.ashx";
    var data = { projectId: hdfKey.Get("pId"), userId: hdfKey.Get("empId"), region: (key === "Total" ? null : key) }
    var _click = "city";
    var value = key;
    sales("BECK'S ICE SALE VOLUME BY CITY", url, data, salesId, _click, value);
    var element = "<a class='btn btn-secondary' onclick=\"javascript: sales_region();\" >< Back</a>";
    $('#backsale').html(element);
}
function sales_byshop(key, key2) {
    var url = "/chart/Sales/ByShop.ashx";
    var data = { projectId: hdfKey.Get("pId"), userId: hdfKey.Get("empId"), region: (key2 === "Total" ? null : key2), city: (key === "Total" ? null : key) }
    sales("BECK'S ICE SALE VOLUME BY SHOP", url, data, salesId);
    var element = "<a class='btn btn-secondary' onclick=\"javascript: sales_bycity('" + key2 + "');\" >< Back</a>";
    $('#backsale').html(element);
}
function sales_week() {
    var url = "/chart/Sales/ByWeek.ashx";
    var data = { projectId: hdfKey.Get("pId"), userId: hdfKey.Get("empId"), region: saleregion.GetValue() };
    var _click = "week";
    sales("BECK'S ICE SALE VOLUME BY WEEK", url, data, salesId, _click);
    $('#backsale').html('');
}
function sales_date(key) {
    var url = "/chart/Sales/ByDate.ashx";
    var data = { projectId: hdfKey.Get("pId"), userId: hdfKey.Get("empId"), week: (key === "Total" ? null : key), region: saleregion.GetValue() };
    sales("BECK'S ICE SALE VOLUME BY DATE", url, data, salesId);
    var element = "<a class='btn btn-secondary' onclick=\"javascript: sales_week() ;\" >< Back</a>";
    $('#backsale').html(element);
}


/* table share */


function tablesshare(title, url, data, id, _click, value) {
    var height = 400;
    $.post(url, data, function (data) {

        var _max = 0;

        var myArr = $.parseJSON(data);
        for (var i = 0; i < myArr.length; i++) {
            if (myArr[i].tablesdrinking > _max)
                _max = myArr[i].tablesdrinking;
        }
        var percent = 1.0;
        if (_max < 200) percent = 0.3;
        else if (_max >= 200 && _max <= 700) percent = 1.0;
        else if (_max > 700 && _max < 900) percent = 1.5;
        else if (_max >= 900 && _max < 2000) percent = 2.5;
        else if (_max >= 2000 && _max < 5000) percent = 6.0;
        else if (_max >= 5000 && _max < 10000) percent = 12.0;
        else if (_max >= 10000 && _max < 20000) percent = 20.0;
        else if (_max >= 20000 ) percent = 30.0;
        var categories = [],
            series = [
                {
                    name: 'Table drinking beer', data: [], type: 'column', color: '#0070c0', yAxis: 0, stack: 'plan',
                    dataLabels: {
                        color: "#000000"
                    }, shadow: false,
                },
                {
                    name: '% Table Sampling', data: [], type: 'column', color: '#bb721e', yAxis: 0, stack: 'sampling',
                    dataLabels: {
                        color: "#000000",
                        enabled: true, formatter: function () { return ' ' + (this.y / percent) + '%'; }
                    },
                    lineWidth: 0,
                    marker: {
                        enabled: true,
                        radius: 6
                    }, tooltip: {
                        valueSuffix: '%'
                    },
                    borderRadius: 50, shadow: false,
                }, {
                    name: '% Table share', data: [], type: 'column', color: '#928c8c', yAxis: 0, stack: 'purchase',
                    dataLabels: {
                        color: "#000000",
                        enabled: true, formatter: function () { return ' ' + (this.y / percent) + '%'; }

                    },
                    lineWidth: 0,
                    lineHeight: 50,
                    marker: {
                        enabled: true,
                        radius: 10,
                    },
                    tooltip: {
                        valueSuffix: '%'
                    },
                    borderRadius: 50,
                    shadow: false

                },
                {
                    name: 'Table sampling', data: [], type: 'column', color: '#d9831f', yAxis: 0, stack: 'sampling',
                    dataLabels: {
                        color: "#000000"
                    },
                    shadow: false
                },
                {
                    name: 'Table purchase', data: [], type: 'column', color: '#aaa', yAxis: 0, stack: 'purchase',
                    dataLabels: {
                        color: "#000000"
                    }, shadow: false
                }
            ];





        for (var i = 0; i < myArr.length; i++) {
            categories.push(myArr[i].categories);
            if (myArr[i].tablesdrinking > 0)
                series[0].data.push(myArr[i].tablesdrinking);
            else series[0].data.push(0);

            if (myArr[i].ptablessampling > 0)
                series[1].data.push(myArr[i].ptablessampling * percent);
            else series[1].data.push(0);


            if (myArr[i].TablesShare > 0)
                series[2].data.push(myArr[i].TablesShare * percent);
            else series[2].data.push(0);
             
            if (myArr[i].tablessampling > 0)
                series[3].data.push(myArr[i].tablessampling);
            else series[3].data.push(0);

            if (myArr[i].tablespurchase > 0)
                series[4].data.push(myArr[i].tablespurchase);
            else series[4].data.push(0);

        }

        var chart = Highcharts.chart(id, {
            chart: { height: height },
            title: { text: title },
            legend: {
                align: 'center',
                backgroundColor: '#FFFFFF',
                borderWidth: 1,
                layout: 'horizontal', shadow: true,
                verticalAlign: 'bottom'
            },
            plotOptions: {
                column: {
                    stacking: 'normal',
                    cursor: 'pointer',
                    dataLabels: {
                        enabled: true,
                        formatter: function () {
                            return ' ' + (this.y);
                        },
                        style: { fontSize: '11px' }
                    },
                    point: {
                        events: {
                            click: function () {
                                if (_click === "region") {
                                    tablesshare_bycity(this.category);
                                } else if (_click === "city") {
                                    tablesshare_byshop(this.category, value);
                                }
                                else if (_click === "week") {
                                    tablesshare_date(this.category);
                                }
                            }
                        }
                    },

                },
                line: {
                    cursor: 'pointer',
                    dataLabels: { enabled: true, formatter: function () { return ' ' + this.y + '%'; } },
                    point: {
                        events: {
                            click: function () {
                                if (_click === "region") {
                                    tablesshare_bycity(this.category);
                                } else if (_click === "city") {
                                    tablesshare_byshop(this.category, value);
                                }
                                else if (_click === "week") {
                                    tablesshare_date(this.category);
                                }
                            }
                        }
                    }
                }
            },
            tooltip: {
                formatter: function () {
                    var s = '<b>' + this.x + '</b>';
                    $.each(this.points, function () {
                        if (this.series.name === "% Table share" || this.series.name === "% Table Sampling") {
                            s += '<br/>' + this.series.name + ': ' + (this.y / percent) + '%';
                        } else {
                            s += '<br/>' + this.series.name + ': ' + (this.y);
                        }
                    });
                    return s;
                },
                shared: true
            },
            xAxis: {
                categories: categories,
                labels: { autoRotation: 0 }
            },
            yAxis: [{
                labels: {
                    formatter: function () {
                        return this.value;
                    }
                },
                title: { text: null }
            }, {
                labels: { format: '{value}%' },
                min: 0,
                opposite: true, title: { text: null }
            }],
            series: series,
            credits: { enabled: false }
        });
    });
}
function tablesshare_region() {
    var url = "/chart/Sales/ByRegion.ashx";
    var data = { projectId: hdfKey.Get("pId"), userId: hdfKey.Get("empId") };
    //var _click = "function () {atten_bycity(this.category);}";
    var _click = "region";
    tablesshare("%TABLE SAMPLING AND %TABLE SHARE BY REGION", url, data, tableshareid, _click);
    $('#backtableshare').html('');
}
function tablesshare_bycity(key) {
    var url = "/chart/Sales/ByCity.ashx";
    var data = { projectId: hdfKey.Get("pId"), userId: hdfKey.Get("empId"), region: (key === "Total" ? null : key) }
    var _click = "city";
    var value = key;
    tablesshare("%TABLE SAMPLING AND %TABLE SHARE BY CITY", url, data, tableshareid, _click, value);
    var element = "<a class='btn btn-secondary' onclick=\"javascript: tablesshare_region();\" >< Back</a>";
    $('#backtableshare').html(element);
}
function tablesshare_byshop(key, key2) {
    var url = "/chart/Sales/ByShop.ashx";
    var data = { projectId: hdfKey.Get("pId"), userId: hdfKey.Get("empId"), region: (key2 === "Total" ? null : key2), city: (key === "Total" ? null : key) }
    tablesshare("%TABLE SAMPLING AND %TABLE SHARE BY SHOP", url, data, tableshareid);
    var element = "<a class='btn btn-secondary' onclick=\"javascript: tablesshare_bycity('" + key2 + "');\" >< Back</a>";
    $('#backtableshare').html(element);
}
function tablesshare_week() {
    var url = "/chart/Sales/ByWeek.ashx";
    var data = { projectId: hdfKey.Get("pId"), userId: hdfKey.Get("empId"), region: tablessharegion.GetValue() };
    var _click = "week";
    tablesshare("%TABLE SAMPLING AND %TABLE SHARE BY WEEK", url, data, tableshareid, _click);
    $('#backtableshare').html('');
}
function tablesshare_date(key) {
    var url = "/chart/Sales/ByDate.ashx";
    var data = { projectId: hdfKey.Get("pId"), userId: hdfKey.Get("empId"), week: (key === "Total" ? null : key), region: tablessharegion.GetValue() };
    tablesshare("%TABLE SAMPLING AND %TABLE SHARE BY DATE", url, data, tableshareid);
    var element = "<a class='btn btn-secondary' onclick=\"javascript: tablesshare_week() ;\" >< Back</a>";
    $('#backtableshare').html(element);
}


/* Conversion Rate */

function conversionrate(title, url, data, id, _click, value) {
    var height = 400;
    $.post(url, data, function (data) {
        var categories = [],
            series = [
                { name: 'No of tables sampling', data: [], type: 'column', color: '#0070c0', yAxis: 0, },
                { name: 'No of tables purchase', data: [], type: 'column', color: '#00b050', yAxis: 0 },
                { name: '% Conversion rate', data: [], type: 'line', color: '#ba1e0d', yAxis: 1 }
            ];


        var myArr = $.parseJSON(data);
        for (var i = 0; i < myArr.length; i++) {
            categories.push(myArr[i].categories);
            series[0].data.push(myArr[i].tablessampling);
            series[1].data.push(myArr[i].tablespurchase);
            series[2].data.push(myArr[i].ConversionRate);

        }
        var chart = Highcharts.chart(id, {
            chart: { height: height },
            title: { text: title },
            legend: {
                align: 'center',
                backgroundColor: '#FFFFFF',
                borderWidth: 1,
                layout: 'horizontal', shadow: true,
                verticalAlign: 'bottom'
            },
            plotOptions: {
                column: {
                    cursor: 'pointer',
                    dataLabels: {
                        enabled: true,
                        formatter: function () { return ' ' + this.y; },
                        style: { fontSize: '11px' }
                    },
                    point: {
                        events: {
                            click: function () {
                                if (_click === "region") {
                                    conversionrate_bycity(this.category);
                                } else if (_click === "city") {
                                    conversionrate_byshop(this.category, value);
                                }
                                else if (_click === "week") {
                                    conversionrate_date(this.category);
                                }
                            }
                        }
                    }
                },
                line: {
                    cursor: 'pointer',
                    dataLabels: { enabled: true, formatter: function () { return ' ' + this.y + '%'; } },
                    point: {
                        events: {
                            click: function () {
                                if (_click === "region") {
                                    conversionrate_bycity(this.category);
                                } else if (_click === "city") {
                                    conversionrate_byshop(this.category, value);
                                }
                                else if (_click === "week") {
                                    conversionrate_date(this.category);
                                }
                            }
                        }
                    }
                }
            },
            tooltip: { shared: true },
            xAxis: {
                categories: categories,
                labels: { autoRotation: 0 }
            },
            yAxis: [{
                labels: { format: '{value}' },
                title: { text: null }
            }, {
                labels: { format: '{value}%' },
                min: 0,
                opposite: true, title: { text: null }
            }],
            series: series,
            credits: { enabled: false }
        });
    });
}
function conversionrate_region() {
    var url = "/chart/Sales/ByRegion.ashx";
    var data = { projectId: hdfKey.Get("pId"), userId: hdfKey.Get("empId") };
    //var _click = "function () {atten_bycity(this.category);}";
    var _click = "region";
    conversionrate("% CONVERSION RATE BY REGION", url, data, conversionrateId, _click);
    $('#backconversionrate').html('');
}
function conversionrate_bycity(key) {
    var url = "/chart/Sales/ByCity.ashx";
    var data = { projectId: hdfKey.Get("pId"), userId: hdfKey.Get("empId"), region: (key === "Total" ? null : key) }
    var _click = "city";
    var value = key;
    conversionrate("% CONVERSION RATE BY CITY", url, data, conversionrateId, _click, value);
    var element = "<a class='btn btn-secondary' onclick=\"javascript: conversionrate_region();\" >< Back</a>";
    $('#backconversionrate').html(element);
}
function conversionrate_byshop(key, key2) {
    var url = "/chart/Sales/ByShop.ashx";
    var data = { projectId: hdfKey.Get("pId"), userId: hdfKey.Get("empId"), region: (key2 === "Total" ? null : key2), city: (key === "Total" ? null : key) }
    conversionrate("% CONVERSION RATE BY SHOP", url, data, conversionrateId);
    var element = "<a class='btn btn-secondary' onclick=\"javascript: conversionrate_bycity('" + key2 + "');\" >< Back</a>";
    $('#backconversionrate').html(element);
}
function conversionrate_week() {
    var url = "/chart/Sales/ByWeek.ashx";
    var data = { projectId: hdfKey.Get("pId"), userId: hdfKey.Get("empId") };
    var _click = "week";
    conversionrate("% CONVERSION RATE BY WEEK", url, data, conversionrateId, _click);
    $('#backconversionrate').html('');
}
function conversionrate_date(key) {
    var url = "/chart/Sales/ByDate.ashx";
    var data = { projectId: hdfKey.Get("pId"), userId: hdfKey.Get("empId"), week: (key === "Total" ? null : key) };
    conversionrate("% CONVERSION RATE BY DATE", url, data, conversionrateId);
    var element = "<a class='btn btn-secondary' onclick=\"javascript: conversionrate_week() ;\" >< Back</a>";
    $('#backconversionrate').html(element);
}



/* Sampling */

function sampling(title, url, data, id, _click, value) {
    var height = 400;
    $.post(url, data, function (data) {
        var categories = [],
            series = [
                { name: 'BGT', data: [], type: 'column', color: '#0070c0', yAxis: 0, },
                { name: 'ACT', data: [], type: 'column', color: '#00b050', yAxis: 0 },
                { name: '% Achievement', data: [], type: 'line', color: '#ba1e0d', yAxis: 1 }
            ];


        var myArr = $.parseJSON(data);
        for (var i = 0; i < myArr.length; i++) {
            categories.push(myArr[i].categories);
            series[0].data.push(myArr[i].KPI);
            series[1].data.push(myArr[i].Actual);
            series[2].data.push(myArr[i].Achievement);

        }
        var chart = Highcharts.chart(id, {
            chart: { height: height },
            title: { text: title },
            legend: {
                align: 'center',
                backgroundColor: '#FFFFFF',
                borderWidth: 1,
                layout: 'horizontal', shadow: true,
                verticalAlign: 'bottom'
            },
            plotOptions: {
                column: {
                    cursor: 'pointer',
                    dataLabels: {
                        enabled: true,
                        formatter: function () { return ' ' + this.y; },
                        style: { fontSize: '11px' }
                    },
                    point: {
                        events: {
                            click: function () {
                                if (_click === "region") {
                                    sampling_bycity(this.category);
                                } else if (_click === "city") {
                                    sampling_byshop(this.category, value);
                                }
                                else if (_click === "week") {
                                    sampling_date(this.category);
                                }
                            }
                        }
                    }
                },
                line: {
                    cursor: 'pointer',
                    dataLabels: { enabled: true, formatter: function () { return ' ' + this.y + '%'; } },
                    point: {
                        events: {
                            click: function () {
                                if (_click === "region") {
                                    sampling_bycity(this.category);
                                } else if (_click === "city") {
                                    sampling_byshop(this.category, value);
                                }
                                else if (_click === "week") {
                                    sampling_date(this.category);
                                }
                            }
                        }
                    }
                }
            },
            tooltip: { shared: true },
            xAxis: {
                categories: categories,
                labels: { autoRotation: 0 }
            },
            yAxis: [{
                labels: { format: '{value}' },
                title: { text: 'can' }
            }, {
                labels: { format: '{value}%' },
                min: 0,
                opposite: true, title: { text: null }
            }],
            series: series,
            credits: { enabled: false }
        });
    });
}
function sampling_region() {
    var url = "/chart/Sampling/ByRegion.ashx";
    var data = { projectId: hdfKey.Get("pId"), userId: hdfKey.Get("empId") };
    //var _click = "function () {atten_bycity(this.category);}";
    var _click = "region";
    sampling("#SAMPLES TO CONSUMERS BY REGION", url, data, samplingid, _click);
    $('#backsampling').html('');
}
function sampling_bycity(key) {
    var url = "/chart/Sampling/ByCity.ashx";
    var data = { projectId: hdfKey.Get("pId"), userId: hdfKey.Get("empId"), region: (key === "Total" ? null : key) }
    var _click = "city";
    var value = key;
    sampling("#SAMPLES TO CONSUMERS BY CITY", url, data, samplingid, _click, value);
    var element = "<a class='btn btn-secondary' onclick=\"javascript: sampling_region();\" >< Back</a>";
    $('#backsampling').html(element);
}
function sampling_byshop(key, key2) {
    var url = "/chart/Sampling/ByShop.ashx";
    var data = { projectId: hdfKey.Get("pId"), userId: hdfKey.Get("empId"), region: (key2 === "Total" ? null : key2), city: (key === "Total" ? null : key) }
    sampling("#SAMPLES TO CONSUMERS BY SHOP", url, data, samplingid);
    var element = "<a class='btn btn-secondary' onclick=\"javascript: sampling_bycity('" + key2 + "');\" >< Back</a>";
    $('#backsampling').html(element);
}
function sampling_week() {
    var url = "/chart/Sampling/ByWeek.ashx";
    var data = { projectId: hdfKey.Get("pId"), userId: hdfKey.Get("empId"), region: samplingregion.GetValue() };
    var _click = "week";
    sampling("#SAMPLES TO CONSUMERS BY WEEK", url, data, samplingid, _click);
    $('#backsampling').html('');
}
function sampling_date(key) {
    var url = "/chart/Sampling/ByDate.ashx";
    var data = { projectId: hdfKey.Get("pId"), userId: hdfKey.Get("empId"), week: (key === "Total" ? null : key), region: samplingregion.GetValue() };
    sampling("#SAMPLES TO CONSUMERS BY DATE", url, data, samplingid);
    var element = "<a class='btn btn-secondary' onclick=\"javascript: sampling_week() ;\" >< Back</a>";
    $('#backsampling').html(element);
}



/* POSM */

function posm(title, url, data, id, _click, value) {
    var height = 400;
    $.post(url, data, function (data) {
        var categories = [],
            series = [
                { name: 'Plan', data: [], type: 'column', color: '#0070c0', yAxis: 0, },
                { name: 'No. Pass (>=70%)', data: [], type: 'column', color: '#00b050', yAxis: 0 },
                { name: '% Achievement', data: [], type: 'spline', color: '#ba1e0d', yAxis: 1 }
            ];


        var myArr = $.parseJSON(data);
        for (var i = 0; i < myArr.length; i++) {
            categories.push(myArr[i].categories);
            series[0].data.push(myArr[i].Plan);
            series[1].data.push(myArr[i].Actual);
            series[2].data.push(myArr[i].Achievement);
            //series[0].data.push(myArr[i].PlanofOutlet);
            //series[1].data.push(myArr[i].quantityofoutlet);
            //if (myArr[i].PlanofOutlet > 0)
            //    series[2].data.push(Math.round(myArr[i].quantityofoutlet / myArr[i].PlanofOutlet * 100, 0));
            //else series[2].data.push(0);
        }
        var chart = Highcharts.chart(id, {
            chart: { height: height },
            title: { text: title },
            legend: {
                align: 'center',
                backgroundColor: '#FFFFFF',
                borderWidth: 1,
                layout: 'horizontal', shadow: true,
                verticalAlign: 'bottom'
            },
            plotOptions: {
                column: {
                    cursor: 'pointer',
                    dataLabels: {
                        enabled: true,
                        formatter: function () { return ' ' + this.y; },
                        style: { fontSize: '11px' }
                    },
                    point: {
                        events: {
                            click: function () {
                                if (_click === "region") {
                                    posm_bycity(this.category);
                                } else if (_click === "city") {
                                    posm_byshop(this.category, value);
                                }
                                else if (_click === "week") {
                                    posm_date(this.category);
                                }
                            }
                        }
                    }
                },
                spline: {
                    cursor: 'pointer',
                    dataLabels: { enabled: true, formatter: function () { return ' ' + this.y + '%'; } },
                    point: {
                        events: {
                            click: function () {
                                if (_click === "region") {
                                    posm_bycity(this.category);
                                } else if (_click === "city") {
                                    posm_byshop(this.category, value);
                                }
                                else if (_click === "week") {
                                    posm_date(this.category);
                                }
                            }
                        }
                    }
                }
            },
            tooltip: { shared: true },
            xAxis: {
                categories: categories,
                labels: { autoRotation: 0 }
            },
            yAxis: [{
                labels: { format: '{value}' },
                title: { text: null }
            }, {
                labels: { format: '{value}%' },
                min: 0,
                opposite: true, title: { text: null }
            }],
            series: series,
            credits: { enabled: false }
        });
    });
}
function posm_region() {
    var url = "/chart/Posm/ByRegion.ashx";
    var data = { projectId: hdfKey.Get("pId"), userId: hdfKey.Get("empId") };
    //var _click = "function () {atten_bycity(this.category);}";
    var _click = "region";
    posm("BASIC POCM BY REGION", url, data, posmid, _click);
    $('#backposm').html('');
}
function posm_bycity(key) {
    var url = "/chart/Posm/ByCity.ashx";
    var data = { projectId: hdfKey.Get("pId"), userId: hdfKey.Get("empId"), region: (key === "Total" ? null : key) }
    var _click = "city";
    var value = key;
    posm("BASIC POCM BY CITY", url, data, posmid, _click, value);
    var element = "<a class='btn btn-secondary' onclick=\"javascript: posm_region();\" >< Back</a>";
    $('#backposm').html(element);
}
function posm_byshop(key, key2) {
    var url = "/chart/Posm/ByShop.ashx";
    var data = { projectId: hdfKey.Get("pId"), userId: hdfKey.Get("empId"), region: (key2 === "Total" ? null : key2), city: (key === "Total" ? null : key) }
    posm("BASIC POCM BY SHOP", url, data, posmid);
    var element = "<a class='btn btn-secondary' onclick=\"javascript: posm_bycity('" + key2 + "');\" >< Back</a>";
    $('#backposm').html(element);
}
function posm_week() {
    var url = "/chart/Posm/ByWeek.ashx";
    var data = { projectId: hdfKey.Get("pId"), userId: hdfKey.Get("empId"), region: posmregion.GetValue() };
    var _click = "week";
    posm("BASIC POCM BY WEEK", url, data, posmid, _click);
    $('#backposm').html('');
}
function posm_date(key) {
    var url = "/chart/Posm/ByDate.ashx";
    var data = { projectId: hdfKey.Get("pId"), userId: hdfKey.Get("empId"), week: (key === "Total" ? null : key), region: posmregion.GetValue() };
    posm("BASIC POCM BY DATE", url, data, posmid);
    var element = "<a class='btn btn-secondary' onclick=\"javascript: posm_week() ;\" >< Back</a>";
    $('#backposm').html(element);
}



/** Sampling evnent happen */
function evnent(title, url, data, id, _click, value) {
    var height = 400;
    $.post(url, data, function (data) {
        var categories = [],
            series = [
                { name: 'BGT', data: [], type: 'column', color: '#0070c0', yAxis: 0, },
                { name: 'ACT', data: [], type: 'column', color: '#00b050', yAxis: 0 },
                { name: '% Achievement', data: [], type: 'line', color: '#ba1e0d', yAxis: 1 }
            ];


        var myArr = $.parseJSON(data);
        for (var i = 0; i < myArr.length; i++) {
            categories.push(myArr[i].categories);
            if (myArr[i].Plan > 0)
                series[0].data.push(myArr[i].Plan);
            else series[0].data.push(0);
            if (myArr[i].Actual > 0)
                series[1].data.push(myArr[i].Actual);
            else series[1].data.push(0);
            if (myArr[i].Achievement > 0)
                series[2].data.push(myArr[i].Achievement);
            else series[2].data.push(0);
        }
        var chart = Highcharts.chart(id, {
            chart: { height: height },
            title: { text: title },
            legend: {
                align: 'center',
                backgroundColor: '#FFFFFF',
                borderWidth: 1,
                layout: 'horizontal', shadow: true,
                verticalAlign: 'bottom'
            },
            plotOptions: {
                column: {
                    cursor: 'pointer',
                    dataLabels: {
                        enabled: true,
                        formatter: function () { return ' ' + this.y; },
                        style: { fontSize: '11px' }
                    },
                    point: {
                        events: {
                            click: function () {
                                if (_click === "region") {
                                    evnent_bycity(this.category);
                                } else if (_click === "city") {
                                    evnent_byshop(this.category, value);
                                }
                                else if (_click === "week") {
                                    evnent_date(this.category);
                                }
                            }
                        }
                    }
                },
                line: {
                    cursor: 'pointer',
                    dataLabels: { enabled: true, formatter: function () { return ' ' + this.y + '%'; } },
                    point: {
                        events: {
                            click: function () {
                                if (_click === "region") {
                                    evnent_bycity(this.category);
                                }
                                else if (_click === "city") {
                                    evnent_byshop(this.category, value);
                                }
                                else if (_click === "week") {
                                    evnent_date(this.category);
                                }
                            }
                        }
                    }
                }
            },
            tooltip: { shared: true },
            xAxis: {
                categories: categories,
                labels: { autoRotation: 0 }
            },
            yAxis: [{
                labels: { format: '{value}' },
                title: { text: null }
            }, {
                labels: { format: '{value}%' },
                min: 0,
                opposite: true, title: { text: null }
            }],
            series: series,
            credits: { enabled: false }
        });
    });
}
function evnent_region() {
    var url = "/chart/Events/ByRegion.ashx";
    var data = { projectId: hdfKey.Get("pId"), userId: hdfKey.Get("empId") };
    //var _click = "function () {evnent_bycity(this.category);}";
    var _click = "region";
    evnent("#SAMPLING EVENTS HAPPEN BY REGION", url, data, evnentId, _click);
    $('#backevnent').html('');
}
function evnent_bycity(key) {
    var url = "/chart/Events/ByCity.ashx";
    var data = { projectId: hdfKey.Get("pId"), userId: hdfKey.Get("empId"), region: (key === "Total" ? null : key) }
    var _click = "city";
    var value = key;
    evnent("#SAMPLING EVENTS HAPPEN BY CITY", url, data, evnentId, _click, value);
    var element = "<a class='btn btn-secondary' onclick=\"javascript: evnent_region();\" >< Back</a>";
    $('#backevnent').html(element);
}
function evnent_byshop(key, key2) {
    var url = "/chart/Events/ByShop.ashx";
    var data = { projectId: hdfKey.Get("pId"), userId: hdfKey.Get("empId"), region: (key2 === "Total" ? null : key2), city: (key === "Total" ? null : key) }
    evnent("#SAMPLING EVENTS HAPPEN BY SHOP", url, data, evnentId);
    var element = "<a class='btn btn-secondary' onclick=\"javascript: evnent_bycity('" + key2 + "');\" >< Back</a>";
    $('#backevnent').html(element);
}
function evnent_week() {
    var url = "/chart/Events/ByWeek.ashx";
    var data = { projectId: hdfKey.Get("pId"), userId: hdfKey.Get("empId"), region: eventsregion.GetValue() };
    var _click = "week";
    evnent("#SAMPLING EVENTS HAPPEN BY WEEK", url, data, evnentId, _click);
    $('#backevnent').html('');
}
function evnent_date(key) {
    var url = "/chart/Events/ByDate.ashx";
    var data = { projectId: hdfKey.Get("pId"), userId: hdfKey.Get("empId"), week: (key === "Total" ? null : key), region: eventsregion.GetValue() };
    evnent("#SAMPLING EVENTS HAPPEN BY DATE", url, data, evnentId);
    var element = "<a class='btn btn-secondary' onclick=\"javascript: evnent_week() ;\" >< Back</a>";
    $('#backevnent').html(element);
}


/* BPA SHift */


function bpashift(title, url, data, id, _click, value) {
    var height = 400;
    $.post(url, data, function (data) {

        var _max = 0;

        var myArr = $.parseJSON(data);
        for (var i = 0; i < myArr.length; i++) {
            if (myArr[i].AgencyBPA > _max)
                _max = myArr[i].AgencyBPA;
            if (myArr[i].ABIBPA > _max)
                _max = myArr[i].ABIBPA;
        }
        var percent = 10;
        if (_max <= 20) percent = 10;
        else if (_max >= 21 && _max < 300) percent = 40;
        else if (_max >= 300 && _max < 1000) percent = 100;
        else if (_max >= 1000 && _max < 3000) percent = 200;
        else if (_max >= 3000 ) percent = 300;

        var categories = [],
            series = [

                {
                    name: 'Agency BPA/event', data: [], type: 'column', color: '#928c8c', yAxis: 0, stack: 'Agency',
                    dataLabels: {
                        enabled: true, formatter: function () { return ' ' + (this.y - percent); },
                    },
                    lineWidth: 0,
                    marker: {
                        enabled: true,
                        radius: 6
                    }, tooltip: {
                        valueSuffix: ''
                    },
                    borderRadius: 50,
                },
                {
                    name: 'Agency BPA shifts', data: [], type: 'column', color: '#0070c0', yAxis: 0, stack: 'Agency'
                },
                {
                    name: 'ABI BPA/event', data: [], type: 'column', color: '#928c8c', yAxis: 0, stack: 'ABI',
                    dataLabels: {
                        enabled: true, formatter: function () { return ' ' + (this.y - percent); },

                    },
                    lineWidth: 0,
                    lineHeight: 50,
                    marker: {
                        enabled: true,
                        radius: 10,
                    },
                    tooltip: {
                        valueSuffix: ''
                    },
                    borderRadius: 50,

                },
                {
                    name: 'ABI BPA shifts', data: [], type: 'column', color: '#d9831f', yAxis: 0, stack: 'ABI'
                }

            ];



        for (var i = 0; i < myArr.length; i++) {
            categories.push(myArr[i].categories);
            if (myArr[i].AvgAgency > 0)
                series[0].data.push(Math.round(myArr[i].AvgAgency + percent, 2));
            else series[0].data.push(0);

            if (myArr[i].AgencyBPA > 0)
                series[1].data.push(myArr[i].AgencyBPA);
            else series[1].data.push(0);

            if (myArr[i].AvgABI > 0)
                series[2].data.push(Math.round(myArr[i].AvgABI + percent, 2));
            else series[2].data.push(0);

            if (myArr[i].ABIBPA > 0)
                series[3].data.push(myArr[i].ABIBPA);
            else series[3].data.push(0);


        }

        var chart = Highcharts.chart(id, {
            chart: { height: height },
            title: { text: title },
            legend: {
                align: 'center',
                backgroundColor: '#FFFFFF',
                borderWidth: 1,
                layout: 'horizontal', shadow: true,
                verticalAlign: 'bottom'
            },
            plotOptions: {
                column: {
                    stacking: 'normal',
                    cursor: 'pointer',
                    dataLabels: {
                        enabled: true,
                        formatter: function () {
                            return ' ' + (this.y);
                        },
                        style: { fontSize: '11px' }
                    },
                    point: {
                        events: {
                            click: function () {
                                if (_click === "region") {
                                    bpashift_bycity(this.category);
                                } else if (_click === "city") {
                                    bpashift_byshop(this.category, value);
                                }
                                else if (_click === "week") {
                                    bpashift_date(this.category);
                                }
                            }
                        }
                    },

                },
                line: {
                    cursor: 'pointer',
                    dataLabels: { enabled: true, formatter: function () { return ' ' + this.y + '%'; } },
                    point: {
                        events: {
                            click: function () {
                                if (_click === "region") {
                                    bpashift_bycity(this.category);
                                } else if (_click === "city") {
                                    bpashift_byshop(this.category, value);
                                }
                                else if (_click === "week") {
                                    bpashift_date(this.category);
                                }
                            }
                        }
                    }
                }
            },
            tooltip: {
                formatter: function () {
                    var s = '<b>' + this.x + '</b>';
                    $.each(this.points, function () {
                        if (this.series.name === "Agency BPA/event" || this.series.name === "ABI BPA/event") {
                            s += '<br/>' + this.series.name + ': ' + (this.y - percent);
                        } else {
                            s += '<br/>' + this.series.name + ': ' + (this.y);
                        }
                    });
                    return s;
                },
                shared: true
            },
            xAxis: {
                categories: categories,
                labels: { autoRotation: 0 }
            },
            yAxis: [{
                labels: {
                    formatter: function () {
                        return (this.value);
                    }
                },
                title: { text: null }, max: (_max + 100)
            }, {
                labels: { format: '{value}%' },
                min: 0,
                opposite: true, title: { text: null }
            }],
            series: series,
            credits: { enabled: false }
        });
    });
}
function bpashift_region() {
    var url = "/chart/BPAShift/ByRegion.ashx";
    var data = { projectId: hdfKey.Get("pId"), userId: hdfKey.Get("empId") };
    //var _click = "function () {atten_bycity(this.category);}";
    var _click = "region";
    bpashift("BPA SHIFT BY REGION", url, data, bpashiftId, _click);
    $('#backbpashift').html('');
}
function bpashift_bycity(key) {
    var url = "/chart/BPAShift/ByCity.ashx";
    var data = { projectId: hdfKey.Get("pId"), userId: hdfKey.Get("empId"), region: (key === "Total" ? null : key) }
    var _click = "city";
    var value = key;
    bpashift("BPA SHIFT BY CITY", url, data, bpashiftId, _click, value);
    var element = "<a class='btn btn-secondary' onclick=\"javascript: bpashift_region();\" >< Back</a>";
    $('#backbpashift').html(element);
}
function bpashift_byshop(key, key2) {
    var url = "/chart/BPAShift/ByShop.ashx";
    var data = { projectId: hdfKey.Get("pId"), userId: hdfKey.Get("empId"), region: (key2 === "Total" ? null : key2), city: (key === "Total" ? null : key) }
    bpashift("BPA SHIFT BY SHOP", url, data, bpashiftId);
    var element = "<a class='btn btn-secondary' onclick=\"javascript: bpashift_bycity('" + key2 + "');\" >< Back</a>";
    $('#backbpashift').html(element);
}
function bpashift_week() {
    var url = "/chart/BPAShift/ByWeek.ashx";
    var data = { projectId: hdfKey.Get("pId"), userId: hdfKey.Get("empId"), region: bpashiftregion.GetValue() };
    var _click = "week";
    bpashift("BPA SHIFT BY WEEK", url, data, bpashiftId, _click);
    $('#backbpashift').html('');
}
function bpashift_date(key) {
    var url = "/chart/BPAShift/ByDate.ashx";
    var data = { projectId: hdfKey.Get("pId"), userId: hdfKey.Get("empId"), week: (key === "Total" ? null : key), region: bpashiftregion.GetValue() };
    bpashift("BPA SHIFT SHARE BY DATE", url, data, bpashiftId);
    var element = "<a class='btn btn-secondary' onclick=\"javascript: bpashift_week() ;\" >< Back</a>";
    $('#backbpashift').html(element);
}
