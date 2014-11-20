$(initialize);

var MAP_OPTIONS = {
  zoom: 12,
};

function initialize(){
  createMap();
  addLocations();
}

function createMap(){

  var mapCanvas = document.getElementById("map_canvas")

    window.map = new google.maps.Map(mapCanvas, MAP_OPTIONS);

  if (window.location.href.indexOf("dive_sites/new") > -1) {
    google.maps.event.addListenerOnce(map, "click", function(event) {
      placeMarker(event.latLng);
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

  function updateOutput(location){
    output.innerHTML='Latitude: '+marker.position.k+'<br>Longitude: '+marker.position.B;
      $("#coords").val(marker.position.k)

    requestAnimationFrame(updateOutput);
  }
  output.innerHTML='Latitude: '+marker.position.k+'<br>Longitude: '+marker.position.B;
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
