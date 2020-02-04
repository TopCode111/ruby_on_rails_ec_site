$(document).ready ->
  $ ->
    $('form').parsley()
    $.listen 'parsley:field:validated', (fieldInstance) ->
      if fieldInstance.$element.is(':hidden')
        fieldInstance._ui.$errorsWrapper.css 'display', 'none'
        fieldInstance.validationResult = true
        return true
    $sections = $('.form-section')

    navigateTo = (index) ->
      $sections.removeClass('current').eq(index).addClass 'current'
      $('.form-navigation .previous').toggle index > 0
      atTheEnd = index >= $sections.length - 1
      $('.form-navigation .next').toggle !atTheEnd
      $('.form-navigation [type=submit]').toggle atTheEnd
      return

    curIndex = ->
      $sections.index $sections.filter('.current')

    $('.form-navigation .previous').click ->
      navigateTo curIndex() - 1
      $('.login-link').show();
      return
    $('.form-navigation .next').click ->
      $('.js-parsley-validate').parsley().whenValidate().done ->
        navigateTo curIndex() + 1
        $('.email').text($('#user_email').val());
        $('.name').text($('#user_profile_last_name').val() + $('#user_profile_first_name').val());
        password = $('#user_password').val().length;
        $('.password').text(("*").repeat(password));
        $('.login-link').hide();
      return
    $sections.each (index, section) ->
      $(section).find(':input').attr 'data-parsley-group', 'block-' + index
      return
    navigateTo 0

  $('.js-parsley-validate').keydown (e) ->
    if e.keyCode == 13
      e.preventDefault()
      return false
    return
