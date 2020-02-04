$(document).ready ->
  subcategory_list = (that) ->
    $.ajax
      url: "/sub_category_list"
      type: "GET"
      dataType: "script"
      data:
        category_id: that.val();
  
  if $(".js_search_category").val() == '' || $(".js_search_category").val() == undefined
    $(".js_search_subcategory").parent().hide();
  else
    subcategory_list($(".js_search_category"));

  $(".js_search_category").on "change", ->
    if $(this).val() != ""
      $(".js_search_subcategory").empty().trigger('chosen:updated');
      subcategory_list($(this));
    else
      $(".js_search_subcategory").parent().hide();
      $(".js_search_subcategory").empty().trigger('chosen:updated');
