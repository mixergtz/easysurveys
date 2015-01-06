$(document).on 'click', 'form .remove_fields', (event) ->
  $(this).next('input[type=hidden]').val(true)
  $(this).parent('fieldset').hide()
  event.preventDefault()

$(document).on 'click', 'form .add_fields', (event) ->
  time = new Date().getTime()
  regexp = new RegExp($(this).data('id'), 'g')
  $(this).before($(this).data('fields').replace(regexp, time))
  event.preventDefault()

$('#survey_logo').bind 'change', ->
  size_in_megabytes = @files[0].size / 1024 / 1024
  alert "Maximum file size is 1MB. Please choose a smaller file."  if size_in_megabytes > 1
  return
