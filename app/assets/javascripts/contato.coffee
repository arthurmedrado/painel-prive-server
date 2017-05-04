# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(
  document
).on('click', '#createContato form button.submit', ->
  Ladda.create(this).start()
  form = $(this).parents 'form'
  form.find('input').attr 'readonly', true
  form.submit()
).on('show.bs.modal', '#createContato', ->
  $(this).find('.form-group').removeClass('has-error has-success has-warning').find('input, textarea').val ''
  $(this).find('.help-block').html ''
).on('shown.bs.modal', '#createContato', ->
  $(this).find('.form-group input#name').focus()
)
