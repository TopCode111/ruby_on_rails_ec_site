$(document).ready ->
  $('.photor').photor();

  itemLargeImage_size();
  $('.slide-menu__overlay').css('display', 'none')
  $(".burger").click ->
    openNav()
  $(".slide-menu__close, .slide-menu__overlay").click ->
    closeNav()

  $('.search-filter--btn').click ->
    openSearchFilter()
  $('.search-filter__close').click ->
    closeSearchFilter()


  openNav = ->
    $('#JsSidenav').width(300+'px')
    $('body').addClass('slider-open')
    $('.slide-menu__overlay').css('display', 'block')
    return

  closeNav = ->
    $('#JsSidenav').css
      'width': 0
    $('body').removeClass('slider-open')
    $('.slide-menu__overlay').css('display', 'none')
    return

  openSearchFilter = ->
    $('#JsSearch-filter').animate({width: '100%'}, 50)
    $('body').addClass('search-slider-open')
    $('.slide-menu__overlay').css('display', 'block')
    return

  closeSearchFilter = ->
    $('#JsSearch-filter').animate({width: 0}, 50)
    setTimeout (->
      $('body').removeClass 'search-slider-open'
      return
    ), 500
    $('.slide-menu__overlay').css('display', 'none')
    return

  itemLargeImage_size()
  itemThumb()

$(window).resize ->
  itemLargeImage_size()
  itemThumb()

itemThumb = ->
  image_height = $('.photor__viewport').height();
  image_thumb_height = $('.photor__thumbs').height();

itemLargeImage_size = ->
  item_width = $('.item__image-col').width();
  item_img_width = item_width - 51;
  $('.photor__viewport').css('height', item_img_width  + 'px');
  $('.photor__thumbs').css('top', item_img_width + 14 + 'px');
  if ( $(window).width() < 767 )
    $('.item__img-collection').css('height', item_img_width  + 'px');
    $('.photor__thumbs').css('bottom', 12 + 'px');
    $('.photor__thumbs').css('top', 'unset');
  else
    $('.item__img-collection').css('height', '');