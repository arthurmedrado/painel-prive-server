# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(
  document
).on('click', '#destroyEvento form button.submit, #createEvento form button.submit', ->
  Ladda.create(this).start()
  form = $(this).parents 'form'
  form.find('input').attr 'readonly', true
  form.submit()

).on('show.bs.modal', '#createEvento', ->
  $(this).find('.form-group').removeClass('has-error has-success has-warning').find('input, textarea').val ''
  $(this).find('.help-block').html ''

).on('shown.bs.modal', '#createEvento, #editEvento', ->
  $(this).find('.form-group input#name').focus()

).on('click', '#eventos .evento-item .actions .destroy', ->
  $('#destroyEvento').modal 'show'
  evento = $(this).parents('.evento-item')

  $('#destroyEvento .evento-id').val evento.data('id')
  $('#destroyEvento .evento-name').html evento.data('titulo')

).on('click', '#eventos .evento-item .actions .update', ->
  $('#editEvento').modal 'show'
  evento = $(this).parents('.evento-item')
  $('#editEvento input.evento-id').val evento.data('id')
  $('#editEvento input#titulo').val evento.data('titulo')
  $('#editEvento input#data').val evento.data('data')
  $('#editEvento input#telefone').val evento.data('telefone')
  $('#editEvento input#email').val evento.data('email')
  $('#editEvento input#site').val evento.data('site')
  $('#editEvento input#longitude').val evento.data('longitude')
  $('#editEvento input#latitude').val evento.data('latitude')
  $('#editEvento textarea#descricao').val evento.data('descricao')
)
