$(initialize);

var MAP_OPTIONS = {
  zoom: 9,
};

function initialize(){
  createMap();
  window.geocoder = new google.maps.Geocoder();
  addLocations();
  geocodeAddress();
  window.infowindow = new google.maps.InfoWindow({
    maxWidth: 100
  });

  var geocoder = $("#geocode")[0]
  geocoder.addEventListener("click", function (){
    geocodeAddress();
  });

  var geocodeForm = $("#address")[0]
  geocodeForm.addEventListener("keypress", function(event){
    var ENTER = 13
    var key = event.keyCode;
    if (key === ENTER){
      geocodeAddress();
    }
  });
}

function createMap(){

  var mapCanvas = document.getElementById("map_canvas")

    window.map = new google.maps.Map(mapCanvas, MAP_OPTIONS);

  if (window.location.href.indexOf("dive_sites/new") > -1) {
    google.maps.event.addListenerOnce(map, "click", function(event) {
      placeMarker(event.latLng);
      codeLatLng(event.latLng);
    });
  }
}

function placeMarker(location){
  var marker = new google.maps.Marker({
    position: location,
    map: map,
    draggable: true,
  });

  google.maps.event.addListener(marker, "dragstart", function(event){
    updateOutput(event.latLng);
  });

  google.maps.event.addListener(marker, "dragend", function(event){
    codeLatLng(event.latLng);
  });

  function updateOutput(location){
    var lat = marker.getPosition().lat();
    var lng = marker.getPosition().lng();
    $(".lat_coords").val(lat);
    $(".long_coords").val(lng);
    $("#latlng").val(lat+","+lng);

    requestAnimationFrame(updateOutput);
  }

  updateOutput(location);
}

function codeLatLng() {
  var input = document.getElementById('latlng').value;
  var latlngStr = input.split(',', 2);
  var lat = parseFloat(latlngStr[0]);
  var lng = parseFloat(latlngStr[1]);
  var latlng = new google.maps.LatLng(lat, lng);
  window.geocoder.geocode({'latLng': latlng}, function(results, status) {
    if (status == google.maps.GeocoderStatus.OK) {
      if (results[1]) {
        $(".coords_name").val(results[1].formatted_address);
      } else {
        console.warn('No results found');
      }
    } else {
      console.log('Geocoder failed due to: ' + status);
    }
  });
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
  console.log(lat, lng);
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
      alert("Geocode was not successful for the following reason: " + status);
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
