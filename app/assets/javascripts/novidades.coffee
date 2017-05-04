# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(
  document
).on('click', '#destroyNovidade form button.submit, #createNovidade form button.submit', ->
  Ladda.create(this).start()
  form = $(this).parents 'form'
  form.find('input').attr 'readonly', true
  form.submit()

).on('show.bs.modal', '#createNovidade', (e) ->
  $(this).find('.form-group').removeClass('has-error has-success has-warning').find('input, textarea, select').val ''
  $(this).find('.help-block').html ''
  $(this).find('.categoria').val $(e.relatedTarget).data('category')
  console.log e
).on('shown.bs.modal', '#createNovidade, #editNovidade', ->
  $(this).find('.form-group input#name').focus()

).on('click', '.novidade-item .actions .destroy', ->
  $('#destroyNovidade').modal 'show'
  novidade = $(this).parents('.novidade-item')

  $('#destroyNovidade .novidade-id').val novidade.data('id')
  $('#destroyNovidade .novidade-name').html novidade.data('name')

).on('click', '.novidade-item .actions .update', ->
  $('#editNovidade').modal 'show'
  novidade = $(this).parents('.novidade-item')

  $('#editNovidade input.novidade-id').val novidade.data('id')
  $('#editNovidade input#name').val novidade.data('name')
  $('#editNovidade textarea#descricao').val novidade.data('descricao')
)
