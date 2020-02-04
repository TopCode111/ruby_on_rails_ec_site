#= require arctic_admin/base
#= require admin_item
#= require jquery
#= require chosen-jquery
#= require cocoon
#= require item
#= require items

$(document).ready ->

  $('.chosen-select').chosen
    allow_single_deselect: true
    no_results_text: 'No results found/matched'
    width: '450px'

  $('.user_password_confirmation').prop( "disabled", true );
  $('#user_password').change ->
    if $(this).val().length > 0 && $(this).val().length >= 8
      $('.inline-errors').remove();
      $('.user_password_confirmation').prop( "disabled", false );
    else
      $('.inline-errors').remove();
      $('#user_password_input').append( "<p class='inline-errors'>8 文字以上で入力してください。</p>");
    return

  $('.user_password_confirmation').change ->
    password = $('#user_password').val()
    conf_password = $('.user_password_confirmation').val()
    if password == conf_password
      $('.inline-errors').remove();
    else
      $('.inline-errors').remove();
      $('#user_password_confirmation_input').append( "<p class='inline-errors'>値が違います。</p>");

  $('#edit_user').submit ->
    password = $('#user_password').val();
    password_confirmation = $('.user_password_confirmation').val();
    if password == ''
      $('.inline-errors').remove();
      $('#user_password_input').append( "<p class='inline-errors'>この値は必須です。</p>");
      return false;
    else if password_confirmation == ''
      $('.inline-errors').remove();
      $('#user_password_confirmation_input').append( "<p class='inline-errors'>この値は必須です。</p>");
      return false;
    else if password.length < 8
      $('.inline-errors').remove();
      $('#user_password_input').append( "<p class='inline-errors'>8 文字以上で入力してください。</p>");
      return false;
    else if password != password_confirmation
      $('.inline-errors').remove();
      $('#user_password_confirmation_input').append( "<p class='inline-errors'>値が違います。</p>");
      return false;
    else
      return true;

  window.disable_selected_options = ->
    arr = $('.quantity select.quantity-select').map(->
      @value
    ).get()
    new_arr = arr.filter((v) ->
      v != ''
    )
    if new_arr.length > 0
      $('.quantity select option[value=' + new_arr[0] + ']').siblings().removeAttr 'disabled'
      i = 0
      while i < new_arr.length
        $('.quantity select option[value=' + new_arr[i] + ']').attr 'disabled', 'disabled'
        i++
      j = 0
      while j < arr.length
        val = $('.quantity select.quantity-select')[j].value
        id = $('.quantity select.quantity-select')[j].id
        if val != ''
          $('#'+id+' option[value='+val+']').removeAttr 'disabled'
        j++

  disable_selected_options();

  $('#quantities').on 'cocoon:after-insert', ->
    disable_selected_options()

  if $(".button-click .image .nested-fields fieldset").length < 1
    $(".button-click .image .has_many_add").click();




