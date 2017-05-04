# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(
  document
).on('click', 'form#login button.submit', ->
  Ladda.create(this).start()
  form = $(this).parents('form')
  form.find('input').attr('readonly', true)
  form.submit()
)
