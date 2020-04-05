
var attenId = "container_attendance1", timingId = "container_attendance2";
var samplingId = "container_sampling", inventoryId = "container_inventory";
var posmId = "container_posm", uniformId = "container_uniform";
function atten(title, url, data, id, _click, value) {
    var height = 400;
    $.post(url, data, function (data) {
        var categories = [],
            series = [
                { name: 'Plan', data: [], type: 'column', color: '#0070c0', yAxis: 0 },
                { name: 'Check-in', data: [], type: 'column', color: '#00b050', yAxis: 0 },
                { name: 'Check-out', data: [], type: 'column', color: '#ffc000', yAxis: 0 },
                { name: '% Achivement', data: [], type: 'line', color: '#ba1e0d', yAxis: 1 }
            ];


        var myArr = $.parseJSON(data);
        for (var i = 0; i < myArr.length; i++) {
            categories.push(myArr[i].categories);
            series[0].data.push(myArr[i].Plan);
            series[1].data.push(myArr[i].checkin);
            series[2].data.push(myArr[i].checkout);
            series[3].data.push(myArr[i].Per_checkout);

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
                                if (_click === "city") {
                                    atten_byshop(this.category);
                                }
                                else if (_click === "week") {
                                    atten_date(this.category, value);
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
                                if (_click === "city") {
                                    atten_byshop(this.category);
                                }
                                else if (_click === "week") {
                                    atten_date(this.category, value);
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
function atten_bycity() {
    var url = "/chart/Attendance/ByCity.ashx";
    var data = { projectId: hdfKey.Get("pId"), userId: hdfKey.Get("empId"), region: null }
    atten("ATTENDANCE BY CITY", url, data, attenId, "city");
    $('#backatten').html("");
}
function atten_byshop(key) {
    var url = "/chart/Attendance/ByShop.ashx";
    var data = { projectId: hdfKey.Get("pId"), userId: hdfKey.Get("empId"), city: (key === "Total" ? null : key) }
    _click = "week";
    atten("ATTENDANCE BY SHOP", url, data, attenId, _click, key);

    var element = "<a class='btn btn-secondary' onclick=\"javascript: atten_bycity();\" >< Back</a>";
    $('#backatten').html(element);
}
function atten_date(key, key2) {
    var url = "/chart/Attendance/ByDate.ashx";
    var data = { projectId: hdfKey.Get("pId"), userId: hdfKey.Get("empId"), shopId: (key === "Total" ? null : key) };
    atten("ATTENDANCE BY DATE", url, data, attenId);
    var element = "<a class='btn btn-secondary' onclick=\"javascript: atten_byshop('" + key2 + "') ;\" >< Back</a>";
    $('#backatten').html(element);
}

function timing(title, url, data, id, _click, value) {
    var height = 400;
    $.post(url, data, function (data) {
        var categories = [],
            series = [
                { name: 'Plan', data: [], type: 'column', color: '#0070c0', yAxis: 0 },
                { name: 'Đúng giờ', data: [], type: 'column', color: '#00b050', yAxis: 0 },
                { name: 'Trễ giờ', data: [], type: 'column', color: '#ffc000', yAxis: 0 },
                { name: '% Achivement', data: [], type: 'line', color: '#ba1e0d', yAxis: 1 }
            ];


        var myArr = $.parseJSON(data);
        for (var i = 0; i < myArr.length; i++) {
            categories.push(myArr[i].categories);
            series[0].data.push(myArr[i].Plan);
            series[1].data.push(myArr[i].Dung_gio);
            series[2].data.push(myArr[i].Tre_gio);
            series[3].data.push(myArr[i].Per_Dung_gio);

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
                                if (_click === "city") {
                                    timing_byshop(this.category);
                                }
                                else if (_click === "week") {
                                    timing_date(this.category, value);
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
                                if (_click === "city") {
                                    timing_byshop(this.category);
                                }
                                else if (_click === "week") {
                                    timing_date(this.category, value);
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
function timingn_bycity() {
    var url = "/chart/Attendance/ByCity.ashx";
    var data = { projectId: hdfKey.Get("pId"), userId: hdfKey.Get("empId"), region: null }
    timing("TIMING BY CITY", url, data, timingId, "city");
    $('#backtiming').html("");
}
function timing_byshop(key) {
    var url = "/chart/Attendance/ByShop.ashx";
    var data = { projectId: hdfKey.Get("pId"), userId: hdfKey.Get("empId"), city: (key === "Total" ? null : key) }
    _click = "week";
    timing("TIMING BY SHOP", url, data, timingId, _click, key);

    var element = "<a class='btn btn-secondary' onclick=\"javascript: timingn_bycity();\" >< Back</a>";
    $('#backtiming').html(element);
}
function timing_date(key, key2) {
    var url = "/chart/Attendance/ByDate.ashx";
    var data = { projectId: hdfKey.Get("pId"), userId: hdfKey.Get("empId"), shopId: (key === "Total" ? null : key) };
    timing("TIMING BY DATE", url, data, timingId);
    var element = "<a class='btn btn-secondary' onclick=\"javascript: timing_byshop('" + key2 + "') ;\" >< Back</a>";
    $('#backtiming').html(element);
}


function sampling(title, url, data, id, _click, value) {
    var height = 400;
    $.post(url, data, function (data) {
        var categories = [],
            series = [
                { name: 'KPI', data: [], type: 'column', color: '#0070c0', yAxis: 0 },
                { name: 'Actual', data: [], type: 'column', color: '#00b050', yAxis: 0 },
                { name: '% Achivement', data: [], type: 'line', color: '#ba1e0d', yAxis: 1 }
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
                                if (_click === "city") {
                                    sampling_byshop(this.category);
                                }
                                else if (_click === "week") {
                                    sampling_date(this.category, value);
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
                                if (_click === "city") {
                                    sampling_byshop(this.category);
                                }
                                else if (_click === "week") {
                                    sampling_date(this.category, value);
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
function sampling_bycity() {
    var url = "/chart/Inventory_Sampling/ByCity.ashx";
    var data = { projectId: hdfKey.Get("pId"), userId: hdfKey.Get("empId"), region: null }
    sampling("TOTAL SAMPLING BY CITY", url, data, samplingId, "city");
    $('#backsamling').html("");
}
function sampling_byshop(key) {
    var url = "/chart/Inventory_Sampling/ByShop.ashx";
    var data = { projectId: hdfKey.Get("pId"), userId: hdfKey.Get("empId"), city: (key === "Total" ? null : key) }
    _click = "week";
    sampling("TOTAL SAMPLING BY SHOP", url, data, samplingId, _click, key);

    var element = "<a class='btn btn-secondary' onclick=\"javascript: sampling_bycity();\" >< Back</a>";
    $('#backsamling').html(element);
}
function sampling_date(key, key2) {
    var url = "/chart/Inventory_Sampling/ByDate.ashx";
    var data = { projectId: hdfKey.Get("pId"), userId: hdfKey.Get("empId"), shopId: (key === "Total" ? null : key) };
    sampling("TOTAL SAMPLING BY DATE", url, data, samplingId);
    var element = "<a class='btn btn-secondary' onclick=\"javascript: sampling_byshop('" + key2 + "') ;\" >< Back</a>";
    $('#backsamling').html(element);
}




function iinventory(title, url, data, id, _click, value) {
    var height = 400;
    $.post(url, data, function (data) {
        var categories = [],
            series = [
                { name: 'Tồn đầu', data: [], type: 'column', color: '#0070c0', yAxis: 0 },
                { name: 'Tồn cuối', data: [], type: 'column', color: '#00b050', yAxis: 0 },
                { name: 'Đã sử dụng ', data: [], type: 'column', color: '#ffc000', yAxis: 0 },
                { name: '% Achivement', data: [], type: 'line', color: '#ba1e0d', yAxis: 1 }
            ];


        var myArr = $.parseJSON(data);
        for (var i = 0; i < myArr.length; i++) {
            categories.push(myArr[i].categories);
            series[0].data.push(myArr[i].beforeValue);
            series[1].data.push(myArr[i].endValue);
            series[2].data.push(myArr[i].usedValue);
            series[3].data.push(myArr[i].per_usedValue);
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
                                if (_click === "city") {
                                    inventory_byshop(this.category);
                                }
                                else if (_click === "week") {
                                    inventory_date(this.category, value);
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
                                if (_click === "city") {
                                    inventory_byshop(this.category);
                                }
                                else if (_click === "week") {
                                    inventory_date(this.category, value);
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
function inventory_bycity() {
    var url = "/chart/Inventory_Sampling/ByCity.ashx";
    var data = { projectId: hdfKey.Get("pId"), userId: hdfKey.Get("empId"), region: null }
    iinventory("INVENTORY BY CITY", url, data, inventoryId, "city");
    $('#backinventory').html("");
}
function inventory_byshop(key) {
    var url = "/chart/Inventory_Sampling/ByShop.ashx";
    var data = { projectId: hdfKey.Get("pId"), userId: hdfKey.Get("empId"), city: (key === "Total" ? null : key) }
    _click = "week";
    iinventory("INVENTORY BY SHOP", url, data, inventoryId, _click, key);

    var element = "<a class='btn btn-secondary' onclick=\"javascript: inventory_bycity();\" >< Back</a>";
    $('#backinventory').html(element);
}
function inventory_date(key, key2) {
    var url = "/chart/Inventory_Sampling/ByDate.ashx";
    var data = { projectId: hdfKey.Get("pId"), userId: hdfKey.Get("empId"), shopId: (key === "Total" ? null : key) };
    iinventory("INVENTORY BY DATE", url, data, inventoryId);
    var element = "<a class='btn btn-secondary' onclick=\"javascript: inventory_byshop('" + key2 + "') ;\" >< Back</a>";
    $('#backinventory').html(element);
}


function posm(title, url, data, id, _click, value) {
    var height = 400;
    $.post(url, data, function (data) {
        var categories = [],
            series = [
                { name: 'Plan', data: [], type: 'column', color: '#0070c0', yAxis: 0, stack: 'plan' },
                { name: 'ĐẦY ĐỦ - CÒN MỚI', data: [], type: 'column', color: '#009900', yAxis: 0, stack: 'result' },
                { name: 'ĐẦY ĐỦ', data: [], type: 'column', color: '#00cc00', yAxis: 0, stack: 'result' },
                { name: 'HƯ HỎNG NHẸ', data: [], type: 'column', color: '#ffcccc', yAxis: 0, stack: 'result' },
                { name: 'HƯ HỎNG', data: [], type: 'column', color: '#ff3333', yAxis: 0, stack: 'result' },
                { name: 'HƯ HỎNG NẶNG', data: [], type: 'column', color: '#cc0000', yAxis: 0, stack: 'result' },
                { name: '% Achivement', data: [], type: 'line', color: '#ba1e0d', yAxis: 1 }
            ];


        var myArr = $.parseJSON(data);
        for (var i = 0; i < myArr.length; i++) {
            categories.push(myArr[i].categories);
            series[0].data.push(myArr[i].plan);
            series[1].data.push(myArr[i].posm1);
            series[2].data.push(myArr[i].posm2);
            series[3].data.push(myArr[i].posm3);
            series[4].data.push(myArr[i].posm4);
            series[5].data.push(myArr[i].posm5);
            if (myArr[i].plan > 0)
                series[6].data.push(Math.round(myArr[i].posm1 / myArr[i].plan * 100, 0));
            else series[6].data.push(0);
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
                        formatter: function () { return ' ' + this.y; },
                        style: { fontSize: '11px' }
                    },
                    point: {
                        events: {
                            click: function () {
                                if (_click === "city") {
                                    posm_byshop(this.category);
                                }
                                else if (_click === "week") {
                                    posm_date(this.category, value);
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
                                if (_click === "city") {
                                    posm_byshop(this.category);
                                }
                                else if (_click === "week") {
                                    posm_date(this.category, value);
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
function posm_bycity() {
    var url = "/chart/Posm_Uniform/ByCity.ashx";
    var data = { projectId: hdfKey.Get("pId"), userId: hdfKey.Get("empId"), region: null }
    posm("POSM BY CITY", url, data, posmId, "city");
    $('#backposm').html("");
}
function posm_byshop(key) {
    var url = "/chart/Posm_Uniform/ByShop.ashx";
    var data = { projectId: hdfKey.Get("pId"), userId: hdfKey.Get("empId"), city: (key === "Total" ? null : key) }
    _click = "week";
    posm("POSM BY SHOP", url, data, posmId, _click, key);

    var element = "<a class='btn btn-secondary' onclick=\"javascript: posm_bycity();\" >< Back</a>";
    $('#backposm').html(element);
}
function posm_date(key, key2) {
    var url = "/chart/Posm_Uniform/ByDate.ashx";
    var data = { projectId: hdfKey.Get("pId"), userId: hdfKey.Get("empId"), shopId: (key === "Total" ? null : key) };
    posm("POSM BY DATE", url, data, posmId);
    var element = "<a class='btn btn-secondary' onclick=\"javascript: posm_byshop('" + key2 + "') ;\" >< Back</a>";
    $('#backposm').html(element);
}



function uniform(title, url, data, id, _click, value) {
    var height = 400;
    $.post(url, data, function (data) {
        var categories = [],
            series = [
                { name: 'Plan', data: [], type: 'column', color: '#0070c0', yAxis: 0 },
                { name: 'ĐẠT YÊU CẦU', data: [], type: 'column', color: '#00b050', yAxis: 0 },
                { name: 'KHÔNG ĐẠT YÊU CẦU', data: [], type: 'column', color: '#ffc000', yAxis: 0 },
                { name: '% Achivement', data: [], type: 'line', color: '#ba1e0d', yAxis: 1 }
            ];


        var myArr = $.parseJSON(data);
        for (var i = 0; i < myArr.length; i++) {
            categories.push(myArr[i].categories); 
            series[0].data.push(myArr[i].plan);
            series[1].data.push(myArr[i].uniform1);
            series[2].data.push(myArr[i].uniform2);
            if (myArr[i].plan > 0)
                series[3].data.push(Math.round(myArr[i].uniform1 / myArr[i].plan * 100, 0));
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
                    cursor: 'pointer',
                    dataLabels: {
                        enabled: true,
                        formatter: function () { return ' ' + this.y; },
                        style: { fontSize: '11px' }
                    },
                    point: {
                        events: {
                            click: function () {
                                if (_click === "city") {
                                    uniform_byshop(this.category);
                                }
                                else if (_click === "week") {
                                    uniform_date(this.category, value);
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
                                if (_click === "city") {
                                    uniform_byshop(this.category);
                                }
                                else if (_click === "week") {
                                   uniform_date(this.category, value);
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
function uniform_bycity() {
    var url = "/chart/Posm_Uniform/ByCity.ashx";
    var data = { projectId: hdfKey.Get("pId"), userId: hdfKey.Get("empId"), region: null }
    uniform("UNIFORM BY CITY", url, data, uniformId, "city");
    $('#backuniform').html("");
}
function uniform_byshop(key) {
    var url = "/chart/Posm_Uniform/ByShop.ashx";
    var data = { projectId: hdfKey.Get("pId"), userId: hdfKey.Get("empId"), city: (key === "Total" ? null : key) }
    _click = "week";
    uniform("UNIFORM BY SHOP", url, data, uniformId , _click, key);

    var element = "<a class='btn btn-secondary' onclick=\"javascript: uniform_bycity();\" >< Back</a>";
    $('#backuniform').html(element);
}
function uniform_date(key, key2) {
    var url = "/chart/Posm_Uniform/ByDate.ashx";
    var data = { projectId: hdfKey.Get("pId"), userId: hdfKey.Get("empId"), shopId: (key === "Total" ? null : key) };
    uniform("UNIFORM BY DATE", url, data,uniformId  );
    var element = "<a class='btn btn-secondary' onclick=\"javascript: uniform_byshop('" + key2 + "') ;\" >< Back</a>";
    $('#backuniform').html(element);
}



 