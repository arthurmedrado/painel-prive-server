Ladda.stopAll()
$('#editEvento form .form-group').removeClass('has-error has-warning').addClass('has-success')
$('#editEvento form .form-group .help-block').html('')
$('#editEvento form .form-group input').attr('readonly', false)

<% if @evento.valid? && @evento.persisted? %>

$('#evento\\:<%= @evento.id %>').replaceWith "<%= escape_javascript(render @evento) %>"

$('#editEvento').modal('hide')
swal('Sucesso!', 'Evento atualizado com sucesso!', 'success').then(->
  $('#evento\\:<%= @evento.id %>')[0].scrollIntoView()
  return
, ->
  $('#evento\\:<%= @evento.id %>')[0].scrollIntoView()
  return
)

<% else %>

$('#editEvento form .form-group').addClass('has-success')
<% @evento.errors.each do |k, v| %>
$('#editEvento form .form-group #<%= k %>').parent().addClass('has-error')
$('#editEvento form .form-group #<%= k %> ~ .help-block').html('<%= v %>')
<% end %>

<%# if @evento.descricao.empty? %>
# $('#editEvento form .form-group textarea#descricao').parent().addClass('has-warning')
# $('#editEvento form .form-group textarea#descricao ~ .help-block').html('Descrição não é obrigatoria, porém é interessante informar!')
<%# end %>

swal(
  type: 'error'
  title: 'Erro!'
  text: 'Verifique os dados e tente novamente!'
  timer: 2000
).then().catch(swal.noop)

<% end %>
