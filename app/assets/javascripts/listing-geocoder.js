$(initialize);

var MAP_OPTIONS = {
  zoom: 9,
};

function initialize(){
  createMap();
  window.geocoder = new google.maps.Geocoder();
  window.infowindow = new google.maps.InfoWindow({
    maxWidth: 100
  });

  addLocations();
  geocodeAddress();

  var geoInput = $("#geocoder")[0]
    geoInput.addEventListener("click", function (){
      geocodeAddress();
    });

  var geoForm = $("#address")[0]
    geoForm.addEventListener("keypress", function(event){
      var ENTER = 13
        var key = event.keyCode;
      if (key === ENTER){
        geocodeAddress();
      }
    });
}

function createMap(){

  var mapCanvas = $("#map_canvas")[0]

    window.map = new google.maps.Map(mapCanvas, MAP_OPTIONS);

  if (window.location.href.indexOf("dive_sites/new") > -1) {
    google.maps.event.addListenerOnce(map, "click", function(event) {
      placeMarker(event.latLng);
      codeLatLng(event.latLng);
    });
  }
}

function addLocations() {
  $(".listing-location").each(function(i, listingLocation) {
    var lat = parseFloat($(listingLocation).find(".site_lat").text());
    var lng = parseFloat($(listingLocation).find(".site_lng").text());
    var id = $(this).parent().data("id");
    geocodeAndAddMarker(lat, lng, id);
  });
};

function geocodeAndAddMarker(lat, lng, id){
  var latLng = new google.maps.LatLng(lat, lng);
  window.geocoder.geocode({ 'latLng': latLng }, function(results, status) {
    if (status == google.maps.GeocoderStatus.OK) {
      var result_location = results[0].geometry.location;

      map.setCenter(result_location)
        var marker = new google.maps.Marker({
          map: window.map,
          position: latLng
        });
      var listingInfo = $("[data-id=" + id + "]").clone();
      var contentString = listingInfo.html();

      google.maps.event.addListener(marker, "click", function(){
        infowindow.setContent(contentString);
        infowindow.open(map, marker);
      });
    } else {
      console.warn("Geocode was not successful for the following reason: " + status);
    }
  });
}

function geocodeAddress() {
  var address = document.getElementById('address').value;
  window.geocoder.geocode( { 'address': address}, function(results, status) {
    if (status == google.maps.GeocoderStatus.OK) {
      map.setCenter(results[0].geometry.location);
      var marker = new google.maps.Marker({
        map: map,
        position: results[0].geometry.location
      });
      marker.setVisible(false);
    } else {
      console.warn('Geocode was not successful for the following reason: ' + status);
    }
  });
}
