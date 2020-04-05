<%@ Page Title="Issued" Language="C#" MasterPageFile="~/Layout.master" AutoEventWireup="true" CodeBehind="Issued.aspx.cs" Inherits="WebApplication.Pages.Employee.Issued" Async="true" %>

<%@ Import Namespace="System.Globalization" %>
<asp:Content ID="Content1" ContentPlaceHolderID="Content" runat="server">
    <style>
        .image-upload > div > input {
            display: none;
        }

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
    </style>
    <script type="text/javascript">
        //for upload image
        $(document).ready(function () {
            //geoFindMe();
            var c = document.getElementById('fileUL');
            if (c != null)
                c.addEventListener('change', handle);
        });

        function handle(e) {
            var MAX_HEIGHT = 768;
            var src = URL.createObjectURL(e.target.files[0]);

            var svrDate = '<%= DateTime.Now.ToString("ddd MMM dd yyyy HH:mm:ss", CultureInfo.InvariantCulture) %>';
            var d = new Date(Date.parse(svrDate));
            var dateStr = formatDate(d);

            var shop = Outlets.GetText();
            if (shop === null) {
                alert("Bạn chưa chọn Cửa hàng.");
                return;
            }
            var canvas = document.getElementById('canImg');
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

                ctx.font = "22px Arial";
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

            $('#inputIMG').hide();
            $('#canvasIMG').show();
            btnSave.SetVisible(true);
            btnClear.SetVisible(true);
        }
        function clear(s, e) {
            $('#inputIMG').show();
            $('#canvasIMG').hide();
            btnClear.SetVisible(false);
            btnSave.SetVisible(false);
        }
        function outletChange(s, e) {
            $('#inputIMG').show();
            $('#canvasIMG').hide();
            btnSave.SetVisible(false);
            btnClear.SetVisible(false);
            ASPxCallbackPanel1.PerformCallback('outlet;' + s.GetValue());
        }
        function issuedChange(s, e) {
            $('#inputIMG').show();
            $('#canvasIMG').hide();
            btnSave.SetVisible(false);
            btnClear.SetVisible(false);
            ASPxCallbackPanel1.PerformCallback('issued;' + s.GetValue());
        }
        function productChange(s, e) {
            $('#inputIMG').show();
            $('#canvasIMG').hide();
            btnSave.SetVisible(false);
            btnClear.SetVisible(false);
            ASPxCallbackPanel1.PerformCallback('product;' + s.GetValue());
        }
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
            //if (s.cpAlert != '') {
            var c = document.getElementById('fileUL');
            if (c != null)
                c.addEventListener('change', handle);
            //}
            //if (s.cpProduct == 'pd' || s.cpProduct != '') {
            //    var c = document.getElementById('fileUL');
            //    if (c != null)
            //        c.addEventListener('change', handle);
            //}

            if (s.cpAlert != '') {
                alert(s.cpAlert);
            }
        }
        function SaveData() {
            var file = document.getElementById("canImg").toDataURL("image/jpeg");
            var images = file.replace("data:image/jpeg;base64,", "");
            //var lat = document.getElementById('lat').innerHTML;
            //var lng = document.getElementById('lng').innerHTML;

            var shop = Outlets.GetValue();
            if (shop === null)
                shop = '';

            var pd = cbIssuedState.GetValue();
            if (pd == null)
                pd = ''

            var cm = txComment.GetText();
            if (cm === null)
                cm = '';

            var val = images + '][' + shop + '][' + pd + '][' + cm;
            return val;
        }
    </script>
    <dx:ASPxCallbackPanel ID="ASPxCallbackPanel1" runat="server" Width="100%"
        ClientInstanceName="ASPxCallbackPanel1" OnCallback="ASPxCallbackPanel1_Callback">
        <ClientSideEvents EndCallback="OnEndCallback" />
        <PanelCollection>
            <dx:PanelContent runat="server">
                <div class="row text-center">
                    <h3>Báo cáo Issued</h3>
                    <div class="col-xs-12" style="margin-top: 5px;">
                        <div class="row" style="margin: 0 4px;">
                            <asp:HiddenField runat="server" ID="hfSaleId" />
                            <dx:ASPxComboBox runat="server" ID="cbxOutlets" Width="100%" OnInit="cbxOutlets_Init" NullText="Chọn cửa hàng"
                                DataSourceID="odsOutlet" ValueField="ShopId" ValueType="System.Int32"
                                EnableCallbackMode="true" ClientInstanceName="Outlets" CallbackPageSize="10">
                                <ClearButton DisplayMode="OnHover"></ClearButton>
                                <ClientSideEvents SelectedIndexChanged="outletChange" />
                                <Columns>
                                    <dx:ListBoxColumn FieldName="ShiftType" />
                                    <dx:ListBoxColumn FieldName="ShopName" />
                                </Columns>
                            </dx:ASPxComboBox>
                            <asp:ObjectDataSource ID="odsOutlet" runat="server" SelectMethod="getByDay" TypeName="LogicTier.Controllers.WorkingPlanBL">
                                <SelectParameters>
                                    <asp:Parameter Name="empId" Type="Int32" />
                                    <asp:Parameter Name="wkDate" Type="String" />
                                </SelectParameters>
                            </asp:ObjectDataSource>
                        </div>
                        <div class="row">
                            <fieldset class="scheduler-border">
                                <legend class="scheduler-border">Hình ảnh Issued</legend>
                                <div class="row marginTop20">
                                    <div class="col-xs-12">
                                        <div class="row" style="margin: 0 4px;">
                                            <dx:ASPxTextBox runat="server" ID="txtIssueName" NullText="Tên Issue(bắt buộc nhập)"></dx:ASPxTextBox>
                                        </div>
                                    </div>
                                </div>
                                <div class="row marginTop20">
                                    <div class="col-xs-12">
                                        <div class="row" style="margin: 0 4px;">
                                            <dx:ASPxComboBox runat="server" ID="cboProduct" Width="100%" NullText="Chọn Product"
                                                ValueType="System.String"
                                                EnableCallbackMode="false" ClientInstanceName="cboproduct" CallbackPageSize="10">
                                                <ClearButton DisplayMode="OnHover"></ClearButton>
                                                <ClientSideEvents SelectedIndexChanged="productChange" />
                                               <%-- <Items>
                                                    
                                                    <dx:ListEditItem Text="--None--" Value="0" />
                                                    <dx:ListEditItem Text="REF" Value="REF" />
                                                    <dx:ListEditItem Text="RAC" Value="RAC" />
                                                    <dx:ListEditItem Text="AP" Value="AP" />
                                                </Items>--%>
                                            </dx:ASPxComboBox>
                                        </div>
                                    </div>
                                </div>
                                <div class="row marginTop20">
                                    <div class="col-xs-12">
                                        <div class="row" style="margin: 0 4px;">
                                            <dx:ASPxComboBox runat="server" ID="cbIssuedState" ValueField="ObjectId" Width="100%"
                                                ValueType="System.Int32" NullText="Chọn loại Issued" OnInit="cbIssuedState_Init"
                                                ClientInstanceName="cbIssuedState" CallbackPageSize="10" DataSourceID="odsissueState">
                                                <ClearButton DisplayMode="OnHover"></ClearButton>
                                                <ClientSideEvents SelectedIndexChanged="issuedChange" />
                                                <Columns>
                                                    <dx:ListBoxColumn FieldName="ObjectName" Caption="Loại Issued" />
                                                </Columns>
                                                <ClientSideEvents SelectedIndexChanged="function(s, e) { ASPxCallbackPanel1.PerformCallback('outlet;filter'); }" />
                                                
                                            </dx:ASPxComboBox>
                                            <asp:ObjectDataSource ID="odsissueState" runat="server" SelectMethod="getlist" TypeName="LogicTier.Controllers.ObjectDataBL">
                                                <SelectParameters>
                                                    <asp:Parameter Name="objId" Type="Int32" />
                                                    <asp:Parameter Name="objType" Type="String" DefaultValue="Issued" />
                                                </SelectParameters>
                                            </asp:ObjectDataSource>
                                        </div>
                                    </div>
                                </div>
                                <asp:Repeater runat="server" ID="rptIssued" DataSourceID="odsIssued" OnItemDataBound="rptIssued_ItemDataBound">
                                    <HeaderTemplate>
                                        <div class="row" style="margin-top: 5px;">
                                    </HeaderTemplate>
                                    <ItemTemplate>
                                        <div class="col-xs-6">
                                            <div class="thumbnail">
                                                <dx:ASPxBinaryImage runat="server" ID="iBinary" CssClass="img-responsive" Value='<%# Eval("BinaryImg") %>'></dx:ASPxBinaryImage>
                                                <div style="margin-top: 3px">
                                                    <dx:ASPxLabel runat="server" ID="lbComment" Text='<%# Eval("Comment") %>'></dx:ASPxLabel>
                                                </div>
                                            </div>
                                        </div>
                                    </ItemTemplate>
                                    <AlternatingItemTemplate>
                                        <div class="col-xs-6">
                                            <div class="thumbnail">
                                                <dx:ASPxBinaryImage runat="server" ID="iBinary" CssClass="img-responsive" Value='<%# Eval("BinaryImg") %>'></dx:ASPxBinaryImage>
                                                <div style="margin-top: 3px">
                                                    <dx:ASPxLabel runat="server" ID="lbComment" Text='<%# Eval("Comment") %>'></dx:ASPxLabel>
                                                </div>
                                            </div>
                                        </div>
                                    </AlternatingItemTemplate>
                                    <FooterTemplate>
                                        <div class="col-xs-6">
                                            <div class="row">
                                                <div class="image-upload" id="dvPanel" runat="server">

                                                    <div id="inputIMG">
                                                        <label for="fileUL">
                                                            <img src="../../Content/Images/camera-icon.png" class="img-responsive" />
                                                        </label>
                                                        <input type="file" name="fileUL" id="fileUL" accept="image/*" capture="camera" />
                                                    </div>
                                                    <div id="canvasIMG" style="display: none;">
                                                        <canvas style="border: 1px solid dotted; margin: 0 auto;" id="canImg" class="img-responsive"></canvas>
                                                        <div style="margin-top: 3px">
                                                            <dx:ASPxTextBox runat="server" ID="txComment" ClientInstanceName="txComment" CssClass="text-justify" Width="100%" NullText="Nhập mô tả."></dx:ASPxTextBox>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-xs-6 text-left">
                                                    <dx:ASPxButton runat="server" ID="btnSave"
                                                        ClientInstanceName="btnSave" CssClass="btn btn-link"
                                                        Text="Lưu"
                                                        AutoPostBack="false"
                                                        ClientVisible="false">
                                                        <ClientSideEvents Click="function(s, e){
                                                                    var val = SaveData();
                                                                    ASPxCallbackPanel1.PerformCallback(val);
                                                                }" />
                                                    </dx:ASPxButton>
                                                </div>
                                                <div class="col-xs-6 text-left">
                                                    <dx:ASPxButton runat="server" ID="btnClear"
                                                        ClientInstanceName="btnClear" CssClass="btn btn-link"
                                                        Text="Xóa"
                                                        AutoPostBack="false"
                                                        ClientVisible="false">
                                                        <ClientSideEvents Click="clear" />
                                                    </dx:ASPxButton>
                                                </div>
                                            </div>
                                        </div>
                                        </div>
                                    </FooterTemplate>
                                </asp:Repeater>
                                <asp:ObjectDataSource ID="odsIssued" runat="server" SelectMethod="getList" TypeName="LogicTier.Controllers.IssuedBL">
                                    <SelectParameters>
                                        <asp:ControlParameter ControlID="hdfKey" Name="userName" PropertyName="['userName']" Type="String" />
                                        <asp:Parameter Name="id" Type="Int64" ConvertEmptyStringToNull="true" />
                                        <asp:ControlParameter ControlID="cboProduct" Name="Product" Type="String" PropertyName="Value" />
                                        <asp:ControlParameter ControlID="cbxOutlets" Name="shopId" Type="String" PropertyName="Value" />
                                        <asp:ControlParameter ControlID="hdfKey" Name="from" PropertyName="['FromDate']" Type="String" />
                                        <asp:ControlParameter ControlID="hdfKey" Name="to" PropertyName="['ToDate']" Type="String" />
                                        <asp:ControlParameter ControlID="cbIssuedState" Name="IssuedId" Type="Int32" PropertyName="Value" />
                                    </SelectParameters>
                                </asp:ObjectDataSource>
                            </fieldset>
                        </div>
                    </div>
                </div>
            </dx:PanelContent>
        </PanelCollection>
    </dx:ASPxCallbackPanel>
    <dx:ASPxHiddenField ID="hdfKey" ClientInstanceName="hdfKey" runat="server"></dx:ASPxHiddenField>
</asp:Content>
