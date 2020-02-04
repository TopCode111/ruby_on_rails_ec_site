$(document).ready ->
  $(document).on 'change', '.quantity-select', ->
    disable_selected_options();

  $('#item_seller_id').on 'change', ->
    $('#item_seller_id option:selected').attr('selected', true);

  $('#item_brand_id').on 'change', ->
    $('#item_brand_id option:selected').attr('selected', true);
