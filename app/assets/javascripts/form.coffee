 $(document).ready ->
   $('form').on 'focus', 'input[type=number]', (e) ->
      $(this).on 'wheel', (e) ->
        e.preventDefault()

    # Restore scroll on number inputs.
    $('form').on 'blur', 'input[type=number]', (e) ->
      $(this).off 'wheel'

    # Disable up and down keys.
    $('form').on 'keydown', 'input[type=number]', (e) ->
      if e.which == 38 or e.which == 40
        e.preventDefault()
