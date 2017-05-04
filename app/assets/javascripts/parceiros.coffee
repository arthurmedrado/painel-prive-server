# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(
  document
).on('click', '#destroyParceiro form button.submit, #createParceiro form button.submit', ->
  Ladda.create(this).start()
  form = $(this).parents 'form'
  form.find('input').attr 'readonly', true
  form.submit()

).on('show.bs.modal', '#createParceiro', ->
  $(this).find('.form-group').removeClass('has-error has-success has-warning').find('input, textarea').val ''
  $(this).find('.help-block').html ''

).on('shown.bs.modal', '#createParceiro, #editParceiro', ->
  $(this).find('.form-group input#name').focus()

).on('click', '#parceiros .parceiro-item .actions .destroy', ->
  $('#destroyParceiro').modal 'show'
  parceiro = $(this).parents('.parceiro-item')

  $('#destroyParceiro .parceiro-id').val parceiro.data('id')
  $('#destroyParceiro .parceiro-name').html parceiro.data('name')

).on('click', '#parceiros .parceiro-item .actions .update', ->
  $('#editParceiro').modal 'show'
  parceiro = $(this).parents('.parceiro-item')

  $('#editParceiro input.parceiro-id').val parceiro.data('id')
  $('#editParceiro input#name').val parceiro.data('name')
  $('#editParceiro input#telefone').val parceiro.data('telefone')
  $('#editParceiro input#site').val parceiro.data('site')
  $('#editParceiro input#longitude').val parceiro.data('longitude')
  $('#editParceiro input#latitude').val parceiro.data('latitude')
  $('#editParceiro textarea#descricaoMapa').val parceiro.data('descricaomapa')
  $('#editParceiro textarea#descricao1').val parceiro.data('descricao1')
  $('#editParceiro textarea#descricao2').val parceiro.data('descricao2')
  $('#editParceiro textarea#descricao3').val parceiro.data('descricao3')
  $('#editParceiro input#imagem').val parceiro.data('imagem')
)
