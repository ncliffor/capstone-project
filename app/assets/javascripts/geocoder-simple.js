$(initialize);

var infowindow = new google.maps.InfoWindow();

var MAP_OPTIONS = {
  zoom: 12,
};

function initialize(){
  createMap();
  geocoder = new google.maps.Geocoder();
  addLocations();
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
    map:map,
    draggable:true,
  });

  google.maps.event.addListener(marker, "dragstart", function(event){
    updateOutput(event.latLng);
  });

  google.maps.event.addListener(marker, "dragend", function(event){
    codeLatLng(event.latLng);
  });

  function updateOutput(location){
      $(".lat_coords").val(marker.position.k);
      $(".long_coords").val(marker.position.B);
      $("#latlng").val(marker.position.k+","+marker.position.B);

    requestAnimationFrame(updateOutput);
  }
      $(".lat_coords").val(marker.position.k);
      $(".long_coords").val(marker.position.B);
      $("#latlng").val(marker.position.k+","+marker.position.B);
}


function addLocations() {
  $(".address").each(function(i, address) {
    geocodeAndAddMarker($(address).text());
  });
};

function geocodeAndAddMarker(address){
  var geocoder = new google.maps.Geocoder();
  geocoder.geocode( { 'address': address }, function(results, status) {
    if (status == google.maps.GeocoderStatus.OK) {
      var result_location = results[0].geometry.location;

      map.setCenter(result_location)
        var marker = new google.maps.Marker({
          map: window.map,
          position: result_location
        });
    } else {
      alert("Geocode was not successful for the following reason: " + status);
    }
  });
}

function codeAddress() {
  var address = document.getElementById('address').value;
  geocoder.geocode( { 'address': address}, function(results, status) {
    if (status == google.maps.GeocoderStatus.OK) {
      map.setCenter(results[0].geometry.location);
      var marker = new google.maps.Marker({
        map: map,
        position: results[0].geometry.location
      });
    } else {
      alert('Geocode was not successful for the following reason: ' + status);
    }
  });
}

function codeLatLng() {
  var input = document.getElementById('latlng').value;
  var latlngStr = input.split(',', 2);
  var lat = parseFloat(latlngStr[0]);
  var lng = parseFloat(latlngStr[1]);
  var latlng = new google.maps.LatLng(lat, lng);
  geocoder.geocode({'latLng': latlng}, function(results, status) {
    if (status == google.maps.GeocoderStatus.OK) {
      if (results[1]) {
      $(".coords").val(results[1].formatted_address);
      } else {
        alert('No results found');
      }
    } else {
      alert('Geocoder failed due to: ' + status);
    }
  });
}
