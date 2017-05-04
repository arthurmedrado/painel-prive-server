# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

@App.loadFileUpload = () ->
  $('#addGalleryImage #fileupload').fileupload
    dataType: 'json'
    dropZone: $('.dragndrop')
    add: (e, data) ->
      if $('.dragndrop').hasClass('working')
        return false
      $('.dragndrop .loading').css width: '0%'
      $('.dragndrop').removeClass('done').addClass('working').css 'background-image', ''
      $('input[type="hidden"].image-url').val ''
      data.submit()
      return
    progress: (e, data) ->
      progress = (data.loaded / data.total * 100).toFixed(2)
      $('.dragndrop .loading').css width: "#{progress}%"
      if parseInt(progress, 10) == 100
        $('.dragndrop').removeClass('working').addClass 'done'
      return
    done: (e, data) ->
      if data.result.error
        swal title: 'Erro!', type: 'error', text: data.result.error
      else
        $('.dragndrop').css 'background-image', "url('#{data.result.displayUrl}')"
        $('input[type="hidden"].image-url').val data.result.url
        $('#addGalleryImage .submit').prop('disabled', false)
      return
    fail: (e, data) ->
      console.log e
      console.log data
      $('.dragndrop').removeClass('done').removeClass('working')
      swal(title: 'Erro!', type: 'error', text: 'Aconteceu um erro, tente novamente.').then().catch(swal.noop)
      return

$(document).on('turbolinks:load ready', ->
  App.loadFileUpload()
  
  $('.gallery').each ->
    $(this).magnificPopup
      delegate: 'a'
      type: 'image'
      tLoading: 'Carregando...'
      mainClass: 'mfp-img-mobile'
      gallery:
        enabled: true
        navigateByImgClick: true
        preload: [0, 1]
      image: tError: 'Ocorreu um erro ao carregar esta imagem!'
    return
).on('click', '#addGalleryImage form button.submit, #destroyImage form button.submit, #addGallery form button.submit, #editGalleryTitle form button.submit, #removeGallery form button.submit', ->
  Ladda.create(this).start()
  form = $(this).parents 'form'
  form.find('input').attr 'readonly', true
  form.submit()
).on('show.bs.modal', '#addGalleryImage', (e) ->
  $(this).find('.form-group').removeClass('has-error has-success has-warning')
  $(this).find('.dragndrop').removeClass('done').css('background-image': '')
  $(this).find('.dragndrop .loading').css('width': '0%')
  $(this).find('input#image-url').val ''
  $(this).find('input#gallery-id').val $(e.relatedTarget).data('gallery-id')
  $(this).find('.submit').prop('disabled', true)
).on('drop dragover', '.dragndrop', (e) ->
  # Prevent the default action when a file is dropped on the window
  e.preventDefault()
).on('click', '.dragndrop a', ->
  # Simulate a click on the file input button to show the file browser dialog
  $(this).parent().find('input#fileupload').click()
).on('show.bs.modal', '#destroyImage', (e) ->
  $(this).find('#image_id').val $(e.relatedTarget).data('image-id')
).on('show.bs.modal', '#addGallery', (e) ->
  $('.has-error, .has-warning, .has-success').removeClass('has-error has-warning has-success')
  $('.help-block').html('')
  $(this).find('input#title').val ''
  $(this).find('#category').val $(e.relatedTarget).data('category')
).on('show.bs.modal', '#editGalleryTitle, #removeGallery', (e) ->
  $('.has-error, .has-warning, .has-success').removeClass('has-error has-warning has-success')
  $('.help-block').html('')
  $(this).find('input#title').val $(e.relatedTarget).data('gallery-title')
  $(this).find('#gallery-id').val $(e.relatedTarget).data('gallery-id')
)
