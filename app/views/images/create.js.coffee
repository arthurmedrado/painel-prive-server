Ladda.stopAll()
$('#addGalleryImage form .form-group').removeClass('has-error has-warning').addClass('has-success')
$('#addGalleryImage form .form-group .help-block').html('')
$('#addGalleryImage form .form-group input').attr('readonly', false)

<% if @image.valid? && @image.persisted? %>

$('#gallery\\:<%= @image.gallery_id %>').append "<%= escape_javascript(render @image) %>"

$('#addGalleryImage').modal('hide')
swal('Sucesso!', 'Imagem cadastrada com sucesso!', 'success').then(->
  $('#image\\:<%= @image.id %>')[0].scrollIntoView()
  return
, ->
  $('#image\\:<%= @image.id %>')[0].scrollIntoView()
  return
)

<% else %>

swal(
  type: 'error'
  title: 'Erro!'
  text: 'Ocorreu um erro inesperado, por favor tente novamente mais tarde!'
  timer: 2000
).then().catch(swal.noop)

<% end %>
