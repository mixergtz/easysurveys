$(document).on 'click', 'form .remove_fields', (event) ->
  $(this).next('input[type=hidden]').val(true)
  $(this).parent('fieldset').hide()
  event.preventDefault()

$(document).on 'click', 'form .add_fields', (event) ->
  time = new Date().getTime()
  regexp = new RegExp($(this).data('id'), 'g')
  $(this).before($(this).data('fields').replace(regexp, time))
  event.preventDefault()
