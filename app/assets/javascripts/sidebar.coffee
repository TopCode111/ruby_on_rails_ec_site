$(document).ready ->
  checkpath = window.location.pathname
  $("li.sidebar_active a").each ->
    if $(this).attr('href') == checkpath
      $(this).addClass('sub-active')




