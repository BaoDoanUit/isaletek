<%@ Page Title="Attendance" Language="C#" MasterPageFile="~/Layout.master" AutoEventWireup="true" CodeBehind="Attendance.aspx.cs" Inherits="WebApplication.Pages.Suppervisor.Attendance" Async="true" %>

<%@ Import Namespace="System.Globalization" %>
<asp:Content ID="Content1" ContentPlaceHolderID="Content" runat="server">

    <%--<script src="js/exif.js"></script>
    <script src="js/binaryajax.js"></script>--%>

    <style>
        .image-upload > div > input {
            display: none;
        }
    </style>
    <script type="text/javascript">

        $(document).ready(function () {
            //geoFindMe();

            var cin = document.getElementById('fileIn');
            var cout = document.getElementById('fileOut');
            if (cin != null)
                cin.addEventListener('change', handleIn);
            if (cout != null)
                cout.addEventListener('change', handleOut);
        });


        function handleIn(e) {
            var MAX_HEIGHT = 300;
            var src = URL.createObjectURL(e.target.files[0]);

            var svrDate = '<%= DateTime.Now.ToString("ddd MMM dd yyyy HH:mm:ss", CultureInfo.InvariantCulture) %>';
            var d = new Date(Date.parse(svrDate));
            var dateStr = formatDate(d);

            var shop = Outlets.GetText();
            if (shop === null) {
                alert("Bạn chưa chọn Cửa hàng.");
                return;
            }

            var canvas = document.getElementById('canIn');
            var ctx = canvas.getContext('2d');

            var img = new Image();
            img.onload = function () {

                if (img.height > MAX_HEIGHT) {
                    img.width *= MAX_HEIGHT / img.height;
                    img.height = MAX_HEIGHT;
                }

                ctx.clearRect(0, 0, canvas.width, canvas.height);
                canvas.width = img.width;
                canvas.height = img.height;
                ctx.drawImage(img, 0, 0, img.width, img.height);

                ctx.font = "12px Arial";
                var gradient = ctx.createLinearGradient(0, 0, canvas.width, 0);
                gradient.addColorStop("0", "white");
                //gradient.addColorStop("0.1", "green");
                //gradient.addColorStop("0.2", "magenta");
                ctx.strokeStyle = gradient;
                ctx.strokeText(dateStr + " " + shop, 10, 25);


                //EXIF.getData(img, function () {
                //    alert(this.exifdata.Orientation);
                //    alert(EXIF.pretty(this));
                //});
            };

            img.src = src;

            $('#checkIn').hide();
            $('#dvIn').show();
            btnIn.SetVisible(true);
            btnClearIn.SetVisible(true);
        }
        function handleOut(e) {
            var MAX_HEIGHT = 300;
            var src = URL.createObjectURL(e.target.files[0]);

            var svrDate = '<%= DateTime.Now.ToString("ddd MMM dd yyyy HH:mm:ss", CultureInfo.InvariantCulture) %>';
            var d = new Date(Date.parse(svrDate));
            var dateStr = formatDate(d);

            var shop = Outlets.GetText();
            if (shop === null) {
                alert("Bạn chưa chọn Cửa hàng.");
                return;
            }
            var canvas = document.getElementById('canOut');
            var ctx = canvas.getContext('2d');

            var img = new Image();
            img.onload = function () {

                if (img.height > MAX_HEIGHT) {
                    img.width *= MAX_HEIGHT / img.height;
                    img.height = MAX_HEIGHT;
                }

                ctx.clearRect(0, 0, canvas.width, canvas.height);
                canvas.width = img.width;
                canvas.height = img.height;
                ctx.drawImage(img, 0, 0, img.width, img.height);

                ctx.font = "12px Arial";
                var gradient = ctx.createLinearGradient(0, 0, canvas.width, 0);
                gradient.addColorStop("0", "white");
                //gradient.addColorStop("0.1", "green");
                //gradient.addColorStop("0.2", "magenta");
                ctx.strokeStyle = gradient;
                ctx.strokeText(dateStr + " " + shop, 10, 25);


                //EXIF.getData(img, function () {
                //    alert(this.exifdata.Orientation);
                //    alert(EXIF.pretty(this));
                //});
            };

            img.src = src;

            $('#checkOut').hide();
            $('#dvOut').show();
            btnOut.SetVisible(true);
            btnClearOut.SetVisible(true);
        }
        function clearIn(s, e) {
            $('#checkIn').show();
            $('#dvIn').hide();
            btnClearIn.SetVisible(false);
            btnIn.SetVisible(false);
        }
        function clearOut(s, e) {
            $('#checkOut').show();
            $('#dvOut').hide();
            btnClearOut.SetVisible(false);
            btnOut.SetVisible(false);
        }
        function outletChange(s, e) {
            $('#checkIn').show();
            $('#checkOut').show();
            $('#dvIn').hide();
            $('#dvOut').hide();
            btnIn.SetVisible(false);
            btnClearIn.SetVisible(false);
            btnOut.SetVisible(false);
            btnClearOut.SetVisible(false);
            ASPxCallbackPanel1.PerformCallback('outlets');
        }

        //function findMe(s, e) {
        //    geoFindMe();
        //    var address = '';

        //    var lat = document.getElementById('lat').innerHTML;
        //    var lng = document.getElementById('lng').innerHTML;
        //    var latlng = new google.maps.LatLng(lat, lng);
        //    var geocoder = geocoder = new google.maps.Geocoder();
        //    geocoder.geocode({ 'latLng': latlng }, function (results, status) {
        //        if (status == google.maps.GeocoderStatus.OK) {
        //            $.each(results[0].address_components, function () {
        //                //if (address != 'undefined')
        //                //    address += ",";

        //                switch (this.types[0]) {
        //                    case "route":
        //                        address += this.short_name + ",";
        //                        break;
        //                    case "administrative_area_level_2":
        //                        address += this.short_name + ",";
        //                        break;
        //                    case "administrative_area_level_1":
        //                        address += this.short_name;
        //                        break;
        //                }
        //            });
        //        }
        //        lbAddress.SetText(address);
        //    });
        //    return lbAddress.GetText();

        //}
        //function geoFindMe() {
        //    if (!navigator.geolocation) {
        //        alert("GPS is not supported by your browser.");
        //        return;
        //    }
        //    navigator.geolocation.getCurrentPosition(success, errorCode);
        //}
        //function success(position) {
        //    document.getElementById('lat').innerHTML = position.coords.latitude;
        //    document.getElementById('lng').innerHTML = position.coords.longitude;
        //}

        //function errorCode(error) {
        //    switch (error.code) {
        //        case 0:
        //            alert("Unable to retrieve your location");
        //            break;
        //        case 1:
        //            alert("Permission denied");
        //            break;
        //        case 2:
        //            alert("Position unavailable (error response from location provider)");
        //            break;
        //        case 3:
        //            alert("Timed out");
        //            break;
        //        default:
        //            break;
        //    }
        //}

        function formatDate(dateObj) {
            var monthNames = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"];
            var curr_date = dateObj.getDate();
            var curr_month = dateObj.getMonth();
            curr_month = curr_month + 1;
            var curr_year = dateObj.getFullYear();
            var curr_min = dateObj.getMinutes();
            var curr_hr = dateObj.getHours();
            var curr_sc = dateObj.getSeconds();
            if (curr_month.toString().length == 1)
                curr_month = '0' + curr_month;
            if (curr_date.toString().length == 1)
                curr_date = '0' + curr_date;
            if (curr_hr.toString().length == 1)
                curr_hr = '0' + curr_hr;
            if (curr_min.toString().length == 1)
                curr_min = '0' + curr_min;

            return curr_year + "-" + curr_month + "-" + curr_date + " " + curr_hr + ":" + curr_min + ":" + curr_sc;
        }
        function OnEndCallback(s, e) {
            if (s.cpAlert == 'oke' || s.cpAlert != '') {
                var cin = document.getElementById('fileIn');
                var cout = document.getElementById('fileOut');
                if (cin != null)
                    cin.addEventListener('change', handleIn);
                if (cout != null)
                    cout.addEventListener('change', handleOut);
            }
            if (s.cpAlert != '' && s.cpAlert != 'oke') {
                alert(s.cpAlert);
            }
        }
        function SaveData(type) {
            var file;
            switch (type) {
                case "In":
                    file = document.getElementById("canIn").toDataURL("image/jpeg");
                    break;
                case "Out":
                    file = document.getElementById("canOut").toDataURL("image/jpeg");
                    break;
            }
            var images = file.replace("data:image/jpeg;base64,", "");
            var lat = document.getElementById('lat').innerHTML;
            var lng = document.getElementById('lng').innerHTML;
            var shop = Outlets.GetValue();
            if (shop === null)
                shop = '';
            //    alert("Bạn chưa chọn Cửa hàng.");
            //    return;
            //}

            var spShop = Outlets.GetText();
            var shift = '';
            if (spShop != null)
                shift = spShop.split(';')[0];

            var val = type + '][' + images + '][' + shop + '][' + lat + '][' + lng + '][' + shift;
            return val;
        }
    </script>
    <dx:ASPxCallbackPanel ID="ASPxCallbackPanel1" runat="server" Width="100%"
        ClientInstanceName="ASPxCallbackPanel1" OnCallback="ASPxCallbackPanel1_Callback">
        <ClientSideEvents EndCallback="OnEndCallback" />
        <PanelCollection>
            <dx:PanelContent runat="server">
                <div class="row text-center">
                    <h3>Chấm công</h3>
                    <div class="row text-center">
                        <div class="col-xs-12 col-md-8">
                            <div class="row" style="margin: 5px 3px 0 3px;">
                                <dx:ASPxComboBox runat="server" ID="Outlets" Width="100%" OnInit="Outlets_Init" NullText="Chọn cửa hàng"
                                    DataSourceID="odsOutlet" ValueField="ShopId" ValueType="System.Int32"
                                    EnableCallbackMode="true" ClientInstanceName="Outlets" CallbackPageSize="10">
                                    <ClientSideEvents SelectedIndexChanged="outletChange" />
                                    <ClearButton DisplayMode="OnHover"></ClearButton>
                                    <Columns>
                                        <dx:ListBoxColumn FieldName="ShopName" />
                                        <dx:ListBoxColumn FieldName="EmployeeName" />
                                    </Columns>
                                </dx:ASPxComboBox>
                                <asp:ObjectDataSource ID="odsOutlet" runat="server" SelectMethod="getByParent" TypeName="LogicTier.Controllers.OutletBL">
                                    <SelectParameters>
                                        <asp:Parameter Name="userName" Type="String" />
                                    </SelectParameters>
                                </asp:ObjectDataSource>
                            </div>
                        </div>
                    </div>
                    <div class="col-xs-12 col-md-6" style="margin-top: 5px;">
                        <div class="thumbnail">
                            <dx:ASPxBinaryImage runat="server" ID="imgCheckIn" Visible="false" CssClass="img-responsive"></dx:ASPxBinaryImage>
                        </div>
                        <div class="image-upload" id="dvPanelIn" runat="server">
                            <div id="checkIn">
                                <label for="fileIn">
                                    <img src="../../Content/Images/cam_checkIn.png" class="img-responsive" />
                                </label>
                                <input type="file" name="fileIn" id="fileIn" accept="image/*" capture="camera" onchange="handleIn" />
                            </div>
                            <div id="dvIn" style="display: none;">
                                <canvas style="border: 1px solid dotted; margin: 0 auto;" id="canIn" class="img-responsive"></canvas>
                            </div>
                        </div>
                        <div class="row text-center" style="margin-top: 5px;">
                            <div class="col-xs-8 col-md-8">
                                <dx:ASPxButton runat="server" ID="btnIn"
                                    ClientInstanceName="btnIn"
                                    Text="Lưu [Check-In]"
                                    AutoPostBack="false"
                                    ClientVisible="false"
                                    Width="90%">
                                    <ClientSideEvents Click="function(s, e){
                                        var val = SaveData('In');
                                        ASPxCallbackPanel1.PerformCallback(val);
                                    }" />
                                </dx:ASPxButton>
                            </div>
                            <div class="col-xs-4 col-md-4">
                                <dx:ASPxButton runat="server" ID="btnClearIn"
                                    ClientInstanceName="btnClearIn"
                                    Text="Xóa"
                                    AutoPostBack="false"
                                    ClientVisible="false"
                                    Width="70px">
                                    <ClientSideEvents Click="clearIn" />
                                </dx:ASPxButton>
                            </div>
                        </div>
                    </div>
                    <div class="col-xs-12 col-md-6" style="margin-top: 5px;">
                        <div class="thumbnail">
                            <dx:ASPxBinaryImage runat="server" ID="imgCheckOut" Visible="false" CssClass="img-responsive"></dx:ASPxBinaryImage>
                        </div>
                        <div class="image-upload" id="dvPanelOut" runat="server">
                            <div id="checkOut">
                                <label for="fileOut">
                                    <img src="../../Content/Images/cam_checkOut.png" class="img-responsive" />
                                </label>
                                <input type="file" name="fileOut" id="fileOut" accept="image/*" capture="camera" />
                            </div>
                            <div id="dvOut" style="display: none;">
                                <canvas style="border: 1px solid dotted; margin: 0 auto;" id="canOut" class="img-responsive"></canvas>
                            </div>
                        </div>
                        <dx:ASPxTextBox runat="server" ID="txComment" NullText="Nhập lý do quên chấm công." Width="100%" Visible="false"></dx:ASPxTextBox>
                        <div class="row text-center" style="margin-top: 5px;">
                            <div class="col-xs-8 col-md-8">
                                <dx:ASPxButton runat="server" ID="btnOut"
                                    ClientInstanceName="btnOut"
                                    Text="Lưu [Check-Out]"
                                    Width="90%"
                                    AutoPostBack="false"
                                    ClientVisible="false">
                                    <ClientSideEvents Click="function(s, e){
                                        var val = SaveData('Out');
                                        ASPxCallbackPanel1.PerformCallback(val);
                                        btnOut.SetVisible(false);
                                        btnClearOut.SetVisible(false);
                                    }" />
                                </dx:ASPxButton>
                            </div>
                            <div class="col-xs-4 col-md-4">
                                <dx:ASPxButton runat="server" ID="btnClearOut"
                                    ClientInstanceName="btnClearOut"
                                    Text="Xóa"
                                    Width="70px"
                                    AutoPostBack="false"
                                    ClientVisible="false">
                                    <ClientSideEvents Click="clearOut" />
                                </dx:ASPxButton>
                            </div>
                        </div>
                    </div>
                </div>
                <div id="hiden_div" style="display: none">
                    <div id="lat"></div>
                    <div id="lng"></div>
                    <dx:ASPxLabel runat="server" ID="lbAddress" ClientInstanceName="lbAddress"></dx:ASPxLabel>
                </div>
            </dx:PanelContent>
        </PanelCollection>
    </dx:ASPxCallbackPanel>
    <script async defer src="https://maps.googleapis.com/maps/api/js?key=AIzaSyCs1iSflSTROTLfMYjkTfcP1fX6Fzx9Y2A&callback=initMap"></script>

</asp:Content>
