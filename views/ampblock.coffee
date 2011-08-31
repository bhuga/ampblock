$(document).ready () ->
  loc = google.maps.LatLng(-34.97, 150.644)
  opts = 
    zoom: 8
    center: loc
  map = new google.maps.Map($('#get-there-map').get(0), opts)
