$(document).ready ->
  $(".js-checkout_submit").on 'click', ->
    $('<div class="loading "></div>').prependTo('body')

  $('a[disabled=disabled]').click (event) ->
    event.preventDefault()
    return
  return
