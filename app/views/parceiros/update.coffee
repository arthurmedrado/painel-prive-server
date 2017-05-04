Ladda.stopAll()
$('#editParceiro form .form-group').removeClass('has-error has-warning').addClass('has-success')
$('#editParceiro form .form-group .help-block').html('')
$('#editParceiro form .form-group input').attr('readonly', false)

<% if @parceiro.valid? && @parceiro.persisted? %>

$('#parceiro\\:<%= @parceiro.id %>').replaceWith "<%= escape_javascript(render @parceiro) %>"

$('#editParceiro').modal('hide')
swal('Sucesso!', 'Parceiro atualizado com sucesso!', 'success').then(->
  $('#parceiro\\:<%= @parceiro.id %>')[0].scrollIntoView()
  return
, ->
  $('#parceiro\\:<%= @parceiro.id %>')[0].scrollIntoView()
  return
)

<% else %>

$('#editParceiro form .form-group').addClass('has-success')
<% @parceiro.errors.each do |k, v| %>
$('#editParceiro form .form-group #<%= k %>').parent().addClass('has-error')
$('#editParceiro form .form-group #<%= k %> ~ .help-block').html('<%= v %>')
<% end %>

<%# if @parceiro.descricao.empty? %>
# $('#editParceiro form .form-group textarea#descricao').parent().addClass('has-warning')
# $('#editParceiro form .form-group textarea#descricao ~ .help-block').html('Descrição não é obrigatoria, porém é interessante informar!')
<%# end %>

swal(
  type: 'error'
  title: 'Erro!'
  text: 'Verifique os dados e tente novamente!'
  timer: 2000
).then().catch(swal.noop)

<% end %>
