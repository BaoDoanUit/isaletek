<%@ Page Title="News" Language="C#" MasterPageFile="~/Layout.master" AutoEventWireup="true" 
    CodeBehind="Community_News.aspx.cs" Inherits="WebApplication.Pages.Community_News" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Content" runat="server">
    <style>
        .news-list-other li a{
          line-height: 18px !important
        }
       .news-list-other li {
            width: 25%;
            height: 200px;
            float: left;
            list-style: none;
        }
    </style>
    <div class="bx-events">
        <asp:Literal runat="server" ID="ltrContent"></asp:Literal>
        <asp:Literal runat="server" ID="ltrMoreEvents"></asp:Literal>
       <%-- <div class="row">
            <div class="col-md-12">
                <h5 class="category-title-main">Sự kiện khác</h5>
                <hr class="bl-header">
                <ul class="news-list-other">
                    <li><a href="/tin-tuc/khai-truong-khach-san-holiday-inn-dau-tien-o-viet-nam/pd7.wd6882.html"><i class="fa fa-caret-right pl-cl pr-2"></i>KHAI TRƯƠNG KHÁCH SẠN HOLIDAY INN ĐẦU TIÊN Ở VIỆT NAM</a></li>
                    <li><a href="/tin-tuc/phu-long-khai-truong-van-phong-moi-tai-ha-noi/pd7.wd5863.html"><i class="fa fa-caret-right pl-cl pr-2"></i>PHÚ LONG KHAI TRƯƠNG VĂN PHÒNG MỚI TẠI HÀ NỘI</a></li>
                    <li><a href="/tin-tuc/phu-long-duoc-vinh-danh-tai-giai-thuong-khu-vuc-chau-a-bci-asia-top-10-awards/pd7.wd5699.html"><i class="fa fa-caret-right pl-cl pr-2"></i>PHÚ LONG ĐƯỢC VINH DANH TẠI GIẢI THƯỞNG KHU VỰC CHÂU Á - BCI ASIA TOP 10 AWARDS</a></li>
                    <li><a href="/tin-tuc/vinh-danh-khu-do-thi-dragon-city-du-an-dang-song-2019/pd7.wd5661.html"><i class="fa fa-caret-right pl-cl pr-2"></i>VINH DANH KHU ĐÔ THỊ DRAGON CITY - DỰ ÁN ĐÁNG SỐNG 2019</a></li>
                    <li><a href="/tin-tuc/trai-nghiem-nhung-ky-quan-cua-bien-tai-festival-bien-nha-trang-2019/pd7.wd5660.html"><i class="fa fa-caret-right pl-cl pr-2"></i>TRẢI NGHIỆM NHỮNG KỲ QUAN CỦA BIỂN TẠI FESTIVAL BIỂN NHA TRANG 2019</a></li>
                    <li><a href="/tin-tuc/phu-long-duoc-vinh-danh-top-10-thuong-hieu-manh-dan-dau-viet-nam/pd7.wd5659.html"><i class="fa fa-caret-right pl-cl pr-2"></i>PHÚ LONG ĐƯỢC VINH DANH TOP 10 THƯƠNG HIỆU MẠNH DẪN ĐẦU VIỆT NAM</a></li>
                    <li><a href="/tin-tuc/phu-long-team-building-2019-vuon-ra-bien-lon/pd7.wd5625.html"><i class="fa fa-caret-right pl-cl pr-2"></i>PHÚ LONG TEAM BUILDING 2019 - VƯƠN RA BIỂN LỚN</a></li>
                    <li><a href="/tin-tuc/dragon-village-–-du-an-dan-dau-xu-the-xanh-va-thong-minh/pd7.wd3483.html"><i class="fa fa-caret-right pl-cl pr-2"></i>DRAGON VILLAGE – DỰ ÁN DẪN ĐẦU XU THẾ XANH VÀ THÔNG MINH</a></li>
                    <li><a href="/tin-tuc/phu-long-lua-chon-kpmg-la-don-vi-tu-van-chien-luoc-phat-trien/pd7.wd5799.html"><i class="fa fa-caret-right pl-cl pr-2"></i>PHÚ LONG LỰA CHỌN KPMG LÀ ĐƠN VỊ TƯ VẤN CHIẾN LƯỢC PHÁT TRIỂN</a></li>
                    <li><a href="/tin-tuc/phu-long-master-chef-2019-am-ap-bua-com-gia-dinh/pd7.wd5575.html"><i class="fa fa-caret-right pl-cl pr-2"></i>PHU LONG MASTER CHEF 2019 - “ẤM ÁP BỮA CƠM GIA ĐÌNH”</a></li>
                </ul>
            </div>
        </div>--%>
    </div>
</asp:Content>