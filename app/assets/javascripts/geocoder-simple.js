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

  updateOutput(location);

  function updateOutput(location){
    var lat = marker.getPosition().lat();
    var lng = marker.getPosition().lng();
    $(".lat_coords").val(lat);
    $(".long_coords").val(lng);
    $("#latlng").val(lat+","+lng);

    requestAnimationFrame(updateOutput);
  }
}

function codeLatLng() {
  var input = $("#latlng")[0].value;
  var latlngStr = input.split(',', 2);
  var lat = parseFloat(latlngStr[0]);
  var lng = parseFloat(latlngStr[1]);
  var latlng = new google.maps.LatLng(lat, lng);
  window.geocoder.geocode({"latLng": latlng}, function(results, status) {
    if (status == google.maps.GeocoderStatus.OK) {
      if (results[1]) {
        $(".coords_name").val(results[1].formatted_address);
      } else {
        console.warn("No results found");
      }
    } else {
      console.warn("Geocoder failed due to: " + status);
    }
  });
}
