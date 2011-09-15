class SponsorDripper

  constructor: (given) ->
    defaults =
      # have to pick someone
      img: '/images/flat_stack.png'
      href: '#'
      height: 199
      width: 433
      z: 1001
      rotateSpeed: 2
      # starting top position
      top: 30
      # position on the left or right?
      left: false
      duration: 25000
      # how many pixels wide the tranch on the right side of the screen should be
      channelWidth: 150
    @opts = $.extend({}, defaults, given)

    # we'd add some triggers to move this div around on resize if someone were paying us.
    @parent = $('<div />')
    @parent.css('position', 'absolute')
    @parent.css('top', '0')
    left = if @opts.left then 0 else $(window).width() - @opts.channelWidth

    @parent.css('left', left)
    @parent.css('width', @opts.channelWidth)
    @parent.css('height', $(document).height())
    @parent.css('overflow', 'hidden')
    $('body').append(@parent)

    @a = $('<a href="'+ @opts.href + '" />')
    @a.css('position','absolute')
    @a.css('left',30)
    @a.css('z-index', @opts.z)
    @parent.append(@a)

    @img = $('<img src="'+@opts.img+'"/>')
    @img.css('height', @opts.height)
    @img.css('width', @opts.width)
    @img.css('border', 'none')
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


  right_sponsors =
    channelWidth: 150

  left_sponsors = $.extend {}, right_sponsors, { left: true}

  sponsors = []

  # Flat Stack
  sponsors.push
    img: '/images/flat_stack.png'
    href: 'http://flatsourcing.com/'
    height: 46
    width: 100

  # GitHub
  sponsors.push
    img: '/images/octocat.png'
    href: 'http://github.com'
    height: 80
    width: 80

  # Engine Yard
  sponsors.push
    img: '/images/engineyard.png'
    href: 'http://engineyard.com'
    height: 100
    width: 61

  # TODO
  # Audiosocket
  sponsors.push
    img: '/images/audio_socket.png'
    href: 'http://audiosocket.com'
    height: 46
    width: 100

  # Blue Box
  sponsors.push
    img: '/images/bbg_logo.png'
    href: 'http://bluebox.net'
    height: 41
    width: 100

  # iSeatz

  interval = 0
  $(window).scroll () ->
    # picked arbitrarily to get mobile browsers.
    if $(window).width() > 700
      if $(window).scrollTop() > 800
        if interval == 0
          drip = (defaults) ->
            sponsor = $.extend({}, defaults, sponsors[Math.floor(Math.random() * sponsors.length)])
            dripper = new SponsorDripper sponsor
            dripper.drip()
          drip(right_sponsors)
          interval = setInterval drip, 5000, right_sponsors
          setTimeout =>
            drip(left_sponsors)
            setInterval drip, 5000, left_sponsors
          , 2500
