class SponsorDripper

  constructor: (given) ->
    defaults =
      # have to pick someone
      img: '/images/flat_stack.png'
      href: 'http://flatstack.com'
      height: 199
      width: 433
      z: 1001
      rotateSpeed: 2
      # starting top position
      top: 30
      # content width for calculating right position
      contentWidth: 1024
      # how far into the content, from the right, to position the element
      right: 30
      duration: 15000
    @opts = $.extend({}, defaults, given)

    @parent = $('<div />')
    @parent.css('position', 'absolute')
    @parent.css('top', '0')
    left = ($(document).width() - @opts.contentWidth) / 2 + @opts.contentWidth - @opts.right
    @parent.css('left', left)
    @parent.css('width', $(document).width() - left)
    @parent.css('height', $(document).height())
    @parent.css('overflow', 'hidden')
    $('body').append(@parent)

    @a = $('<a href="'+ @opts.href + '" />')
    @a.css('position','absolute')
    @a.css('z-index', @opts.z)
    @parent.append(@a)

    @img = $('<img src="'+@opts.img+'"/>')
    @img.css('height', @opts.height)
    @img.css('width', @opts.width)
    @a.append(@img)

  drip: ()->
    @r = 0
    rotater = setInterval () =>
      r = @r = (@r + @opts.rotateSpeed) % 360
      @a.css('rotation', r + 'deg')
      @a.css('-webkit-transform', 'rotate(' + r + 'deg)')
      @a.css('-moz-transform', 'rotate(' + r + 'deg)')
      @a
    , 30
    @a.css('top', @opts.top)
    margin = ($(document).width() - @opts.contentWidth) / 2
    #@a.css('left', margin + @opts.contentWidth - @opts.right)
    @a.css('display', 'block')
    target =
      top: $(document).height() + 300
    @a.animate target,
      duration: @opts.duration,
      complete: () =>
        clearInterval rotater
        @parent.remove()

$(document).ready () ->
  loc = new google.maps.LatLng 29.948653,-90.067205
  opts =
    zoom: 15
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
      toDirs.setDirections(response)

  flat_stack =
    img: '/images/flat_stack.png'
    height: 46
    width: 100

  interval = 0
  $(window).scroll () ->
    if $(window).scrollTop() > 800
      if interval == 0
        drip = ->
          dripper = new SponsorDripper(flat_stack)
          dripper.drip()
        drip()
        interval = setInterval drip, 5000
