<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="GoogleMapAPI.ascx.cs" Inherits="WebApplication.UserControls.GoogleMapAPI" %>
<div id="map" style="height: 100%; width: 100%;"></div>
<script>
    var labels = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
    var locations = [
        { lat: 10.761701, lng: 106.690139 },
        { lat: 10.758798, lng: 106.6882 },
        { lat: 10.769913, lng: 106.690307 },
        { lat: 10.764186, lng: 106.696291 },
        { lat: 10.790262, lng: 106.69926 },
        { lat: 10.804161, lng: 106.682005 },
        { lat: 10.791229, lng: 106.693752 },
        { lat: 10.77033, lng: 106.692099 },
        { lat: 10.76868, lng: 106.699377 },
        { lat: 10.769333, lng: 106.691392 },
        { lat: 10.76738, lng: 106.690624 },
        { lat: 10.766667, lng: 106.692058 },
        { lat: 10.781098, lng: 106.703888 },
        { lat: 10.7926, lng: 106.69349 },
        { lat: 10.797794, lng: 106.679764 },
        { lat: 10.791741, lng: 106.696276 },
        { lat: 10.801606, lng: 106.712849 },
        { lat: 10.769131, lng: 106.687493 }
    ]

    function initMap(dlat, dlng, Id) {
        if (dlat != null && dlng != null) {
            var map = new google.maps.Map(document.getElementById('map'), {
                center: { lat: dlat, lng: dlng },
                zoom: 18
            });
        }
        else {
            var map = new google.maps.Map(document.getElementById('map'), {
                center: { lat: 10.778083, lng: 106.700479 },
                zoom: 4
            });
        } 
        var infowindow = new google.maps.InfoWindow({
            content: document.getElementById('iw-container')
        });

        var markers = locations.map(function (location, i) {
            var marker = new google.maps.Marker({
                position: location,
                label: labels[i % labels.length],
                map: map
            });

            google.maps.event.addListener(marker, 'click', function () {
                getByShopId(Id);
                infowindow.open(map, marker);
            });

            google.maps.event.addListener(map, 'click', function () {
                infowindow.close();
            });

            return marker;

        });

        var markerCluster = new MarkerClusterer(map, markers, {
            imagePath: 'https://developers.google.com/maps/documentation/javascript/examples/markerclusterer/m'
        });
    }
</script>
<script src="https://developers.google.com/maps/documentation/javascript/examples/markerclusterer/markerclusterer.js"></script>
<script async defer src="https://maps.googleapis.com/maps/api/js?key=AIzaSyCs1iSflSTROTLfMYjkTfcP1fX6Fzx9Y2A&callback=initMap"></script>
