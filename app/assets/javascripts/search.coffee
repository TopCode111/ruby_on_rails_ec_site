$(document).ready ->
  $('.dropdown-menu a[data-toggle="tab"]').click (e) ->
    e.stopPropagation()
    $(this).tab 'show'
    return

  $('.tab-content div:first').addClass 'active show'

  $(".category_route").on "click", ->
    route = $(this).attr("aria-controls");
    $(this).prop("href", "/category/" + route);

(($) ->
  $ ->
    $(document).off 'click.bs.tab.data-api', '[data-hover="tab"]'
    $(document).on 'mouseenter.bs.tab.data-api', '[data-toggle="tab"], [data-hover="tab"]', ->
      $(this).tab 'show'
      return
    return
  return
) jQuery
