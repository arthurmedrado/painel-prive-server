# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(
  document
).on('click', '#createPush form button.submit, #destroyPush form button.submit', ->
  Ladda.create(this).start()
  form = $(this).parents 'form'
  form.find('input').attr 'readonly', true
  form.submit()
).on('show.bs.modal', '#createPush', ->
  $(this).find('.form-group').removeClass('has-error has-success has-warning').find('input, textarea').val ''
  $(this).find('.help-block').html ''
).on('shown.bs.modal', '#createPush', ->
  $(this).find('.form-group input#title').focus()
).on('click', '.push-item .actions .destroy', ->
  $('#destroyPush').modal 'show'
  push = $(this).parents('.push-item')

  $('#destroyPush .push-id').val push.data('id')
  $('#destroyPush .push-title').html push.data('title')
)
