$(document).ready () ->
  loc = new google.maps.LatLng 29.948653,-90.067205
  opts =
    zoom: 15
    center: loc
    mapTypeId: google.maps.MapTypeId.ROADMAP
  map = new google.maps.Map($('#get-there-map').get(0), opts)
  fromMap = new google.maps.Map($('#get-back-map').get(0), opts)

  router = new google.maps.DirectionsService()

  toDirs = new google.maps.DirectionsRenderer()
  toDirs.setMap(map)

  fromDirs = new google.maps.DirectionsRenderer()
  fromDirs.setMap(fromMap)

  toRoute =
    origin: "Astor Crowne Plaza New Orleans Hotel, 739 Canal Street, New Orleans, LA 70130"
    destination: "camp at girod"
    travelMode: google.maps.DirectionsTravelMode.WALKING
  router.route toRoute, (response, status) ->
    if status == google.maps.DirectionsStatus.OK
      toDirs.setDirections(response)

  fromWaypoints = ['camp at girod', 'bourbon at canal', 'tulane university medical center']
  googleWaypoints = ({location: waypoint} for waypoint in fromWaypoints[1..fromWaypoints.length-2])
  fromRoute =
    origin: fromWaypoints[0]
    destination: fromWaypoints[fromWaypoints.length-1]
    waypoints: googleWaypoints
    travelMode: google.maps.DirectionsTravelMode.WALKING

  router.route fromRoute, (response, status) ->
    if status == google.maps.DirectionsStatus.OK
      index = 0
      while(index < response.routes[0].legs.length)
        response.routes[0].legs[index].start_address = fromWaypoints[index]
        response.routes[0].legs[index].end_address = fromWaypoints[index+1]
        index += 1
      fromDirs.setDirections(response)
