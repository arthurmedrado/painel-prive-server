Ladda.stopAll()
$('#createEvento form .form-group').removeClass('has-error has-warning').addClass('has-success')
$('#createEvento form .form-group .help-block').html('')
$('#createEvento form .form-group input').attr('readonly', false)

<% if @evento.valid? && @evento.persisted? %>

$('#eventos').append "<%= escape_javascript(render @evento) %>"

$('#createEvento').modal('hide')
swal('Sucesso!', 'Evento cadastrado com sucesso!', 'success').then(->
  $('#evento\\:<%= @evento.id %>')[0].scrollIntoView()
  return
, ->
  $('#evento\\:<%= @evento.id %>')[0].scrollIntoView()
  return
)

<% else %>

$('#createEvento form .form-group').addClass('has-success')
<% @evento.errors.each do |k, v| %>
$('#createEvento form .form-group input#<%= k %>').parent().addClass('has-error')
$('#createEvento form .form-group input#<%= k %> ~ .help-block').html('<%= v %>')
<% end %>

swal(
  type: 'error'
  title: 'Erro!'
  text: 'Verifique os dados e tente novamente!'
  timer: 2000
).then().catch(swal.noop)

<% end %>
