Ladda.stopAll()
$('#editNovidade form .form-group').removeClass('has-error has-warning').addClass('has-success')
$('#editNovidade form .form-group .help-block').html('')
$('#editNovidade form .form-group input').attr('readonly', false)

<% if @novidade.valid? && @novidade.persisted? %>

$('#novidade\\:<%= @novidade.id %>').replaceWith "<%= escape_javascript(render @novidade) %>"

$('#editNovidade').modal('hide')
swal('Sucesso!', 'Novidade atualizada com sucesso!', 'success').then(->
  $('#novidade\\:<%= @novidade.id %>')[0].scrollIntoView()
  return
, ->
  $('#novidade\\:<%= @novidade.id %>')[0].scrollIntoView()
  return
)

<% else %>

$('#editNovidade form .form-group').addClass('has-success')
<% @novidade.errors.each do |k, v| %>
$('#editNovidade form .form-group #<%= k %>').parent().addClass('has-error')
$('#editNovidade form .form-group #<%= k %> ~ .help-block').html('<%= v %>')
<% end %>

<%# if @novidade.descricao.empty? %>
# $('#editNovidade form .form-group textarea#descricao').parent().addClass('has-warning')
# $('#editNovidade form .form-group textarea#descricao ~ .help-block').html('Descrição não é obrigatoria, porém é interessante informar!')
<%# end %>

swal(
  type: 'error'
  title: 'Erro!'
  text: 'Verifique os dados e tente novamente!'
  timer: 2000
).then().catch(swal.noop)

<% end %>
