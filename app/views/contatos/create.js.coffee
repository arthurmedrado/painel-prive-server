Ladda.stopAll()
$('#createContato form .form-group').removeClass('has-error has-warning').addClass('has-success')
$('#createContato form .form-group .help-block').html('')
$('#createContato form .form-group input').attr('readonly', false)

<% if @contato.valid? && @contato.persisted? %>

$('#contatos').append "<%= escape_javascript(render @contato) %>"

$('#createContato').modal('hide')
swal('Sucesso!', 'Contato cadastrado com sucesso!', 'success').then(->
  $('#contato\\:<%= @contato.id %>')[0].scrollIntoView()
  return
, ->
  $('#contato\\:<%= @contato.id %>')[0].scrollIntoView()
  return
)

<% else %>

$('#createContato form .form-group').addClass('has-success')
<% @contato.errors.each do |k, v| %>
$('#createContato form .form-group input#<%= k %>').parent().addClass('has-error')
$('#createContato form .form-group input#<%= k %> ~ .help-block').html('<%= v %>')
<% end %>

swal(
  type: 'error'
  title: 'Erro!'
  text: 'Verifique os dados e tente novamente!'
  timer: 2000
).then().catch(swal.noop)

<% end %>
