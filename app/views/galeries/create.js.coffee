Ladda.stopAll()
$('#addGallery form .form-group').removeClass('has-error has-warning').addClass('has-success')
$('#addGallery form .form-group .help-block').html('')
$('#addGallery form .form-group input').attr('readonly', false)

<% if @galeria.valid? && @galeria.persisted? %>

<% if @galeria.hotel? %>
$('#galerias #hoteis .row').append "<%= escape_javascript(render partial: 'galeries/hotel', locals: { hotel: @galeria }) %>"
<% elsif @galeria.parque? %>
$('#galerias #parques .row').append "<%= escape_javascript(render partial: 'galeries/parque', locals: { parque: @galeria }) %>"
<% end %>
$('body > .alerts').after "<%= escape_javascript(render partial: 'modals/gallery/gallery_modal', locals: { gallery: @galeria }) %>"

$('#addGallery').modal('hide')
swal('Sucesso!', 'Galeria cadastrado com sucesso!', 'success').then(->
  $('#galeria\\:<%= @galeria.id %>')[0].scrollIntoView()
  return
, ->
  $('#galeria\\:<%= @galeria.id %>')[0].scrollIntoView()
  $('#openGallery-<%= @galeria.id %>').modal('show')
  return
)

<% else %>

$('#addGallery form .form-group').addClass('has-success')
<% @galeria.errors.each do |k, v| %>
$('#addGallery form .form-group input#<%= k %>').parent().addClass('has-error')
$('#addGallery form .form-group input#<%= k %> ~ .help-block').html('<%= v %>')
<% end %>

swal(
  type: 'error'
  title: 'Erro!'
  text: 'Verifique os dados e tente novamente!'
  timer: 2000
).then().catch(swal.noop)

<% end %>
