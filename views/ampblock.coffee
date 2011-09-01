$(document).ready () ->
  loc = new google.maps.LatLng 29.948653,-90.067205
  opts =
    zoom: 6
    center: loc
    mapTypeId: google.maps.MapTypeId.ROADMAP
  map = new google.maps.Map($('#get-there-map').get(0), opts)

  router = new google.maps.DirectionsService()

  toDirs = new google.maps.DirectionsRenderer()
  toDirs.setMap(map)

  toRoute =
    origin: "Astor Crowne Plaza New Orleans Hotel, 739 Canal Street, New Orleans, LA 70130"
    destination: "camp at girod"
    travelMode: google.maps.DirectionsTravelMode.WALKING
  router.route toRoute, (response, status) ->
    if status == google.maps.DirectionsStatus.OK
      console.log(response)
      toDirs.setDirections(response)


