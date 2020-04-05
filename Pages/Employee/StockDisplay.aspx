<%@ Page Title="Displays" Language="C#" MasterPageFile="~/Layout.master" AutoEventWireup="true" CodeBehind="StockDisplay.aspx.cs" Inherits="WebApplication.Pages.Employee.StockDisplay" Async="true" %>

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

           <%-- var svrDate = '<%= DateTime.Now.ToString("ddd MMM dd yyyy HH:mm:ss", CultureInfo.InvariantCulture) %>';
            var d = new Date(Date.parse(svrDate));
            var dateStr = formatDate(d);--%>

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

                //ctx.font = "22px Arial";
                //var gradient = ctx.createLinearGradient(0, 0, canvas.width, 0);
                //gradient.addColorStop("0", "white");
                //gradient.addColorStop("0.1", "green");
                //gradient.addColorStop("0.2", "magenta");
                //ctx.strokeStyle = gradient;
                //ctx.strokeText(dateStr + " " + shop, 10, 25);


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
        function productChange(s, e) {
            ASPxCallbackPanel1.PerformCallback('product;' + s.GetValue() + ';' + Outlets.GetValue());
        }
        function imgProductChange(s, e) {
            $('#inputIMG').show();
            $('#canvasIMG').hide();
            btnSave.SetVisible(false);
            btnClear.SetVisible(false);
            ASPxCallbackPanel1.PerformCallback('imgProduct;' + s.GetValue() + ';' + Outlets.GetValue());
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
            if (s.cpAlert == 'oke' || s.cpAlert != '') {
                var c = document.getElementById('fileUL');
                if (c != null)
                    c.addEventListener('change', handle);
            }
            if (s.cpProduct == 'pd' || s.cpProduct != '') {
                var c = document.getElementById('fileUL');
                if (c != null)
                    c.addEventListener('change', handle);
            }

            if (s.cpAlert != '' && s.cpAlert != 'oke') {
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

            var pd = cbimgProduct.GetValue();
            if (pd == null)
                pd = ''

            var model = cbModel.GetValue();
            if (model === null)
                model = '';

            var cm = txComment.GetText();
            if (cm === null)
                cm = '';

            var val = images + '][' + shop + '][' + pd + '][' + model + '][' + cm;
            return val;
        }
        function onFileUploadComplete(s, e) {
            if (e.callbackData) {
                //var fileData = e.callbackData.split('|');
                //var fileName = fileData[0],
                //    fileUrl = fileData[1],
                //    fileSize = fileData[2];

                var shop = Outlets.GetValue();
                if (shop === null)
                    shop = '';

                var pd = cbimgProduct.GetValue();
                if (pd == null)
                    pd = ''

                ASPxCallbackPanel1.PerformCallback('imgProduct;' + pd + ";" + shop);
            }
        }
        function TextChanged(s, e) {
            var cm = txComment.GetText();
            $('#Content_hdfcomment').val(cm);
        }
    </script>
    <dx:ASPxCallbackPanel ID="ASPxCallbackPanel1" runat="server" Width="100%"
        ClientInstanceName="ASPxCallbackPanel1" OnCallback="ASPxCallbackPanel1_Callback">
        <ClientSideEvents EndCallback="OnEndCallback" />
        <PanelCollection>
            <dx:PanelContent runat="server">
                <div class="row text-center">
                    <h3>Báo cáo trưng bày</h3>
                    <h4></h4>
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
                        <div class="row" style="margin: 4px 4px 0 4px;">
                            <dx:ASPxComboBox runat="server" ID="cbProduct" ValueField="Product" Width="100%"
                                ValueType="System.String" NullText="Chọn Product" OnInit="cbProduct_Init"
                                ClientInstanceName="cbProduct" CallbackPageSize="10" DataSourceID="odsProduct">
                                <ClearButton DisplayMode="OnHover"></ClearButton>
                                <ClientSideEvents SelectedIndexChanged="productChange" />
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
                        <div class="row">
                            <fieldset class="scheduler-border">
                                <legend class="scheduler-border">Số lượng trưng bày</legend>
                                <div class="row">
                                    <div class="col-xs-12">
                                        <asp:Repeater runat="server" ID="rptProduct" DataSourceID="odsStockDisplay">
                                            <HeaderTemplate>
                                                <div class="row text-primary">
                                                    <div class="col-xs-7 text-uppercase text-success">
                                                        Sản phẩm
                                                    </div>
                                                    <div class="col-xs-5 text-center text-uppercase text-success">
                                                        Trưng bày
                                                    </div>
                                                </div>
                                            </HeaderTemplate>
                                            <ItemTemplate>
                                                <div class="row marginTop20">
                                                    <div class="col-xs-7 text-info text-left">
                                                        <%# Container.ItemIndex + 1 %>.
                                                        <dx:ASPxLabel runat="server" ID="lbModel" Text='<%# Eval("Model") %>'></dx:ASPxLabel>
                                                    </div>
                                                    <div class="col-xs-5 text-center">
                                                        <dx:ASPxSpinEdit runat="server" ID="txDisplay" ClientInstanceName="txDisplay" Width="100%" MaxLength="2" Text='<%# Eval("Display") %>'>
                                                            <SpinButtons ShowIncrementButtons="false"></SpinButtons>
                                                        </dx:ASPxSpinEdit>
                                                    </div>
                                                </div>
                                            </ItemTemplate>
                                        </asp:Repeater>
                                        <asp:ObjectDataSource ID="odsStockDisplay" runat="server" SelectMethod="getProduct" TypeName="LogicTier.Controllers.StockDisplayBL">
                                            <SelectParameters>
                                                <asp:Parameter Name="empId" Type="Int32" />
                                                <asp:Parameter Name="shopId" Type="Int32" />
                                                <asp:Parameter Name="rpDate" Type="String" />
                                                <asp:Parameter Name="product" Type="String" />
                                            </SelectParameters>
                                        </asp:ObjectDataSource>
                                    </div>
                                </div>
                            </fieldset>
                        </div>
                        <div class="row text-left">
                            <div class="col-xs-12">
                                <dx:ASPxButton runat="server" ID="btSave" ClientInstanceName="btSave" CssClass="btn btn-primary" Text="Lưu" AutoPostBack="false">
                                    <ClientSideEvents Click="function(s,e){ASPxCallbackPanel1.PerformCallback('Save');}" />
                                </dx:ASPxButton>
                                &nbsp;
                                <%--<dx:ASPxButton runat="server" ID="btnConfirm" ClientInstanceName="btnConfirm" CssClass="btn btn-danger" Text="[Khóa dữ liệu]" AutoPostBack="false">
                                    <ClientSideEvents Click="function(s,e){
                                        if(confirm('Bạn có muốn khóa dữ liệu không?'))
                                            ASPxCallbackPanel1.PerformCallback('Confirm');
                                    }" />
                                </dx:ASPxButton>--%>
                            </div>
                        </div>
                        <div class="row marginTop20">
                            <fieldset class="scheduler-border">
                                <legend class="scheduler-border">Hình ảnh trưng bày</legend>
                                <div class="row marginTop05">
                                    <div class="col-xs-6">
                                        <dx:ASPxComboBox runat="server" ID="cbimgProduct" ValueField="Product" Width="100%"
                                            ValueType="System.String" NullText="Chọn Product" OnInit="cbimgProduct_Init"
                                            ClientInstanceName="cbimgProduct" CallbackPageSize="10" DataSourceID="ObjectDataSource1">
                                            <ClearButton DisplayMode="OnHover"></ClearButton>
                                            <ClientSideEvents SelectedIndexChanged="imgProductChange" />
                                            <Columns>
                                                <dx:ListBoxColumn FieldName="Product" />
                                            </Columns>
                                        </dx:ASPxComboBox>
                                        <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" SelectMethod="getDivision" TypeName="LogicTier.Controllers.ProductsBL">
                                            <SelectParameters>
                                                <asp:Parameter DefaultValue="Product" Name="fieldName" Type="String" />
                                                <asp:Parameter Name="fieldValue" Type="String" />
                                                <asp:Parameter DefaultValue="Product" Name="fieldDisplay" Type="String" />
                                            </SelectParameters>
                                        </asp:ObjectDataSource>
                                    </div>
                                    <div class="col-xs-6">
                                        <dx:ASPxComboBox runat="server" ID="cbModel" ValueType="System.String" NullText="Chọn Model" Width="100%"
                                            DataSourceID="ObjectDataSource2" ValueField="Model" OnInit="cbModel_Init"
                                            ClientInstanceName="cbModel" CallbackPageSize="10"
                                            IncrementalFilteringMode="Contains" TextFormatString="{0}" EnableCallbackMode="true" DropDownStyle="DropDownList">
                                            <ClearButton DisplayMode="OnHover"></ClearButton>
                                            <Columns>
                                                <dx:ListBoxColumn FieldName="Model" />
                                            </Columns>
                                        </dx:ASPxComboBox>
                                        <asp:ObjectDataSource ID="ObjectDataSource2" runat="server" SelectMethod="getProduct" TypeName="LogicTier.Controllers.StockDisplayBL">
                                            <SelectParameters>
                                                <asp:Parameter Name="empId" Type="Int32" />
                                                <asp:Parameter Name="shopId" Type="Int32" />
                                                <asp:Parameter Name="rpDate" Type="String" />
                                                <asp:Parameter Name="product" Type="String" />
                                            </SelectParameters>
                                        </asp:ObjectDataSource>
                                    </div>
                                    <div class="col-xs-12" style="text-align: left">
                                        <div class="image-upload" id="dvPanel" runat="server">
                                            <div id="canvasIMG" style="display: block; margin-bottom: 5px">
                                                <%--<canvas style="border: 1px solid dotted; margin: 0 auto;" id="canImg" class="img-responsive"></canvas>--%>
                                                <div style="margin-top: 3px">
                                                    <dx:ASPxTextBox runat="server" ID="txComment" ClientInstanceName="txComment" CssClass="text-justify" Width="100%" NullText="Nhập mô tả."></dx:ASPxTextBox>
                                                </div>
                                            </div>

                                            <%--<div id="inputIMG">
                                                                <label for="fileUL">
                                                                    <img src="../../Content/Images/camera-icon.png" class="img-responsive" />
                                                                </label>
                                                                <input type="file" name="fileUL" id="fileUL" accept="image/*" multiple="multiple" />
                                                            </div>--%>
                                            <dx:ASPxUploadControl ID="UploadControl" runat="server" ClientInstanceName="UploadControl" Width="100%" UploadButton-ImagePosition="Bottom"
                                                NullText="Chọn hình..." UploadMode="Advanced" ShowUploadButton="True" ShowProgressPanel="True" RemoveButton-Text="Xóa" CancelButton-Text="Hủy"
                                                OnFileUploadComplete="UploadControl_FileUploadComplete" FileUploadMode="OnPageLoad">
                                                <AdvancedModeSettings EnableMultiSelect="True" EnableFileList="True" EnableDragAndDrop="True" />
                                                <ValidationSettings AllowedFileExtensions=".jpg,.jpeg,.gif,.png"></ValidationSettings>
                                                <ClientSideEvents FilesUploadStart="function(s, e) {TextChanged(s,e)}" FileUploadComplete="onFileUploadComplete" />
                                                <UploadButton Text="">
                                                    <Image Url="../../Content/Images/saveimg.png">
                                                    </Image>
                                                </UploadButton>
                                            </dx:ASPxUploadControl>

                                        </div>

                                        <div class="clearfix"></div>
                                        <div class="col-xs-6 text-left">
                                            <dx:ASPxButton runat="server" ID="btnSave"
                                                ClientInstanceName="btnSave" CssClass="btn btn-primary"
                                                Text="Lưu" ClientVisible="false"
                                                AutoPostBack="false">
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
                                <div class="row">
                                    <div class="col-xs-12">
                                        <asp:Repeater runat="server" ID="rptDisplayImg" DataSourceID="odsImgDisplay" OnItemDataBound="rptDisplayImg_ItemDataBound" OnLoad="rptDisplayImg_Load">
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
                                                </div>
                                            </FooterTemplate>
                                        </asp:Repeater>
                                        <asp:ObjectDataSource ID="odsImgDisplay" runat="server" SelectMethod="getList" TypeName="LogicTier.Controllers.ImageDisplayBL">
                                            <SelectParameters>
                                                <asp:Parameter Name="userName" Type="String" />
                                                <asp:Parameter Name="id" Type="Int64" />
                                                <asp:Parameter Name="empId" Type="Int32" />
                                                <asp:Parameter Name="shopId" Type="Int32" />
                                                <asp:Parameter Name="product" Type="String" />
                                                <asp:Parameter Name="from" Type="String" />
                                                <asp:Parameter Name="to" Type="String" />
                                            </SelectParameters>
                                        </asp:ObjectDataSource>
                                    </div>
                                </div>
                            </fieldset>
                            <asp:HiddenField ID="hdfcomment" runat="server" />
                        </div>
                    </div>
                </div>
            </dx:PanelContent>
        </PanelCollection>
    </dx:ASPxCallbackPanel>
</asp:Content>

