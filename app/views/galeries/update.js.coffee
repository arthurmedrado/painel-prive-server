Ladda.stopAll()
$('#editGalleryTitle form .form-group').removeClass('has-error has-warning').addClass('has-success')
$('#editGalleryTitle form .form-group .help-block').html('')
$('#editGalleryTitle form .form-group input').attr('readonly', false)

<% if @galeria.valid? && @galeria.persisted? %>

<% if @galeria.hotel? %>
$('#galeria\\:<%= @galeria.id %>').replaceWith "<%= escape_javascript(render partial: 'galeries/hotel', locals: { hotel: @galeria }) %>"
<% elsif @galeria.parque? %>

<% end %>

$('#editGalleryTitle').modal('hide')
swal('Sucesso!', 'Galeria atualizada com sucesso!', 'success').then(->
  $('#galeria\\:<%= @galeria.id %>')[0].scrollIntoView()
  return
, ->
  $('#galeria\\:<%= @galeria.id %>')[0].scrollIntoView()
  $('#openGallery-<%= @galeria.id %>').modal('show')
  return
)

<% else %>

$('#editGalleryTitle form .form-group').addClass('has-success')
<% @galeria.errors.each do |k, v| %>
$('#editGalleryTitle form .form-group input#<%= k %>').parent().addClass('has-error')
$('#editGalleryTitle form .form-group input#<%= k %> ~ .help-block').html('<%= v %>')
<% end %>

swal(
  type: 'error'
  title: 'Erro!'
  text: 'Verifique os dados e tente novamente!'
  timer: 2000
).then().catch(swal.noop)

<% end %>
