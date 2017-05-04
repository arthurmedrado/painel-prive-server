# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

addPension = (value) ->
  return if value.isEmpty()
  
  tmpl = $.templates('#template\\:pensao')
  $('#pensoes ul').append tmpl(name: value)
  
addHotel = (value) ->
  return if value.isEmpty()
  
  tmpl = $.templates('#template\\:hotel')
  $('#hoteis ul').append tmpl(name: value)

$(
  document
).on('click', '#pensoes .add', ->
  input = $(this).parents('#pensoes').find('input#pensao-tipo-field')
  
  addPension input.val()
  input.val('').focus()
).on('keydown', '#pensoes input#pensao-tipo-field', (e) ->
  return true if e.keyCode != 13
  
  input = $(this).parents('#pensoes').find('input#pensao-tipo-field')
  
  addPension input.val()
  input.val('').focus()
  
  e.preventDefault()
  return false
).on('click', '#pensoes .close', ->
  el = $(this).parents('li')
  
  if el.find('input#pensao-tipo__id').val().isEmpty()
    el.remove()
  else
    el.addClass('to-destroy')
    el.find('input#pensao-tipo__destroy').val('true')
).on('click', '#hoteis .add', ->
  input = $(this).parents('#hoteis').find('input#hoteis-nome-field')
  
  addHotel input.val()
  input.val('').focus()
).on('keydown', '#hoteis input#hoteis-nome-field', (e) ->
  return true if e.keyCode != 13
  
  input = $(this).parents('#hoteis').find('input#hoteis-nome-field')
  
  addHotel input.val()
  input.val('').focus()
  
  e.preventDefault()
  return false
).on('click', '#hoteis .close', ->
  el = $(this).parents('li')
  
  if el.find('input#hoteis-nome__id').val().isEmpty()
    el.remove()
  else
    el.addClass('to-destroy')
    el.find('input#hoteis-nome__destroy').val('true')
)
