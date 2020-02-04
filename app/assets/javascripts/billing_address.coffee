$(document).ready ->
  zip_code_validation = (zc1, zc2, e) ->
    z1 = zc1.val();
    z2 = zc2.val();
    z = z1+'-'+z2;
    reg = /^\d{3}-\d{4}$/;
    if reg.test(z)
      $('.js-zip-code-validation').empty();
    else
      e.preventDefault();
      $('.js-zip-code-validation').empty();
      $('.js-zip-code-validation').append('<ul class="parsley-errors-list filled"> この値は無効です</ul>');

  $('.js-address').on 'click', (e) ->
    $('.js-zip-code-validation').empty();
    if $('#zip_code_1').val() == '' || $('#zip_code_2').val() == ''
      $('.js-zip-code-validation').empty();
      $('.js-zip-code-validation').append('<ul class="parsley-errors-list filled"> この値は必須です。</ul>')
    if $('form').parsley().validate()
      if $('#zip_code_1').val() == '' || $('#zip_code_2').val() == ''
        e.preventDefault();
        $('.js-zip-code-validation').empty();
        $('.js-zip-code-validation').append('<ul class="parsley-errors-list filled"> この値は必須です。</ul>')
      else
        zip_code_validation($('#zip_code_1'),$('#zip_code_2'), e)

  $('#zip_code_1').on 'keyup', (e) ->
    if $(this).val().length == 3
      if $('#zip_code_2').val() == ''
        $('#zip_code_2').focus();
    if $(this).val() != '' && $('#zip_code_2').val() != ''
      $('.js-zip-code-validation').empty();
      zip_code_validation($('#zip_code_1'),$('#zip_code_2'), e);

  $('#zip_code_2').on 'keyup', (e) ->
    if $(this).val() != '' && $('#zip_code_1').val() != ''
      $('.js-zip-code-validation').empty();
      zip_code_validation($('#zip_code_1'),$('#zip_code_2'), e);
