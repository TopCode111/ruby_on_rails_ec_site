$(document).ready ->
  validate_security_card = (sc, cvc, e) ->
    if sc == ''
      e.preventDefault();
      $('.error-security-card').empty();
      $('#card_verification').addClass('is-invalid');
      $('.error-security-card').append('<ul class="parsley-errors-list filled">セキュリティコードが入力されていません</ul>');
      false
    else
      reg = /^[0-9]{3,3}$/;
      if reg.test(sc)
        cvc.val(sc);
        $('.error-security-card').empty();
        $('#card_verification').removeClass('is-invalid');
        true
      else
        e.preventDefault();
        $('#card_verification').addClass('is-invalid');
        $('.error-security-card').empty();
        $('.error-security-card').append('<ul class="parsley-errors-list filled">セキュリティコードが間違っています</ul>');
        false

  validate_card_no = (c1, c2, c3, c4, card, e) ->
    if c1 == '' && c2 == '' && c3 == '' && c4 == ''
      e.preventDefault();
      $('.error-card-no').empty();
      $('#card_no1').addClass('is-invalid');
      $('#card_no2').addClass('is-invalid');
      $('#card_no3').addClass('is-invalid');
      $('#card_no4').addClass('is-invalid');
      $('.error-card-no').append('<ul class="parsley-errors-list filled">カード番号が入力されていません</ul>');
      false
    else if c1 != '' || c2 != '' || c3 != '' || c4 != ''
      c = c1 + c2 + c3 + c4
      card.val(c);
      card_valid = false
      vc_card = card.validateCreditCard (result) ->
        if result.valid
          $('.error-card-no').empty();
          $('#card_no1').removeClass('is-invalid');
          $('#card_no2').removeClass('is-invalid');
          $('#card_no3').removeClass('is-invalid');
          $('#card_no4').removeClass('is-invalid');
          card_valid = true;
        else
          e.preventDefault();
          $('.error-card-no').empty();
          $('#card_no1').addClass('is-invalid');
          $('#card_no2').addClass('is-invalid');
          $('#card_no3').addClass('is-invalid');
          $('#card_no4').addClass('is-invalid');
          $('.error-card-no').append('<ul class="parsley-errors-list filled">カード番号が間違っています</ul>');
          card_valid = false;
      return vc_card = card_valid

  validate_card_expiration = (exp_mon, exp_year, expiry_month, expiry_year, e) ->
    if exp_mon == '' || exp_year == ''
      e.preventDefault();
      $('.error_expiration').empty();
      $('#exp_month').addClass('is-invalid');
      $('#exp_year').addClass('is-invalid');
      $('.error_expiration').append('<ul class="parsley-errors-list filled">カードの有効期限が入力されていません</ul>');
      return false
    else if exp_mon != '' || exp_year != ''
      minMonth = new Date().getMonth() + 1;
      minYear = new Date().getFullYear();
      month = parseInt(exp_mon, 10);
      year = parseInt(exp_year, 10);
      if year == minYear && month < minMonth
        e.preventDefault();
        $('.error_expiration').empty();
        $('#exp_month').addClass('is-invalid');
        $('#exp_year').addClass('is-invalid');
        $('.error_expiration').append('<ul class="parsley-errors-list filled">カードの有効期限が間違っています</ul>');
        return false
      else
        expiry_month.val(exp_mon);
        expiry_year.val(exp_year);
        $('.error_expiration').empty();
        $('#exp_month').removeClass('is-invalid');
        $('#exp_year').removeClass('is-invalid');
        return true

  check_expiration = (exp_mon, exp_year) ->
    if exp_mon != '' || exp_year != ''
      minMonth = new Date().getMonth() + 1;
      minYear = new Date().getFullYear();
      month = parseInt(exp_mon, 10);
      year = parseInt(exp_year, 10);
      if year == minYear && month < minMonth
        $('.error_expiration').empty();
        $('#exp_month').addClass('is-invalid');
        $('#exp_year').addClass('is-invalid');
        $('.error_expiration').append('<ul class="parsley-errors-list filled">カードの有効期限が間違っています</ul>');
      else
        $('.error_expiration').empty();
        $('#exp_month').removeClass('is-invalid');
        $('#exp_year').removeClass('is-invalid');

  $('.js-payment_submit').on 'click', (e) ->
    card_no_valid = validate_card_no($('input#card_no1').val(), $('input#card_no2').val(), $('input#card_no3').val(), $('input#card_no4').val(), $('input#card_no'), e);
    security_code_valid = validate_security_card($('input#card_verification').val(), $('input#cvc'), e);
    expiration_valid = validate_card_expiration($('#exp_month').val(), $('#exp_year').val(), $('input#expiry_month'), $('input#expiry_year'), e);
    if card_no_valid && security_code_valid && expiration_valid
      $('<div class="loading "></div>').prependTo('body')
      $("input.form-control").attr('disabled', true);
      $("select.form-control").attr('disabled', true);
      $(this ).attr('disabled', true);
      form = $('.payment_form')
      Stripe.card.createToken form, (status, response) ->
        form = $('.payment_form')
        token = response.id
        if response.error
          form.find('.stripe-error').text response.error.message
          $('.js-payment_submit').prop 'disabled', false
        else
          $(this).attr('disabled', true);
          form.append $('<input type="hidden" name="stripeToken" />').val(token)
          $('input[data-stripe], select[data-stripe]').remove()
          form.get(0).submit()
        return
      false



  $('input#card_no1').on 'keyup', (e) ->
    $('.error-card-no').empty();
    if $(this).val().length == 4
      if $('input#card_no2').val() == ''
        $('input#card_no2').focus();
    validate_card_no($('input#card_no1').val(), $('input#card_no2').val(), $('input#card_no3').val(), $('input#card_no4').val(), $('input#card_no'), e);

  $('input#card_no2').on 'keyup', (e) ->
    $('.error-card-no').empty();
    if $(this).val().length == 4
      if $('input#card_no3').val() == ''
        $('input#card_no3').focus();
    validate_card_no($('input#card_no1').val(), $('input#card_no2').val(), $('input#card_no3').val(), $('input#card_no4').val(), $('input#card_no'), e);

  $('input#card_no3').on 'keyup', (e) ->
    $('.error-card-no').empty();
    if $(this).val().length == 4
      if $('input#card_no4').val() == ''
        $('input#card_no4').focus();
    validate_card_no($('input#card_no1').val(), $('input#card_no2').val(), $('input#card_no3').val(), $('input#card_no4').val(), $('input#card_no'), e);

  $('input#card_no4').on 'keyup', (e) ->
    $('.error-card-no').empty();
    validate_card_no($('input#card_no1').val(), $('input#card_no2').val(), $('input#card_no3').val(), $('input#card_no4').val(), $('input#card_no'), e);

  $('input#card_verification').on 'keyup', (e) ->
    $('.error-security-card').empty();
    validate_security_card($('input#card_verification').val(), $('input#cvc'), e);

  $('select#exp_month').on 'change', (e) ->
    $('.error_expiration').empty();
    check_expiration($('#exp_month').val(), $('#exp_year').val());

  $('select#exp_year').on 'change', (e) ->
    $('.error_expiration').empty();
    check_expiration($('#exp_month').val(), $('#exp_year').val());


$(window).on 'load',  ->
  $('<div class="loading "></div>').remove();
