Ladda.stopAll()
$('#createParceiro form .form-group').removeClass('has-error has-warning').addClass('has-success')
$('#createParceiro form .form-group .help-block').html('')
$('#createParceiro form .form-group input').attr('readonly', false)

<% if @parceiro.valid? && @parceiro.persisted? %>

$('#parceiros').append "<%= escape_javascript(render @parceiro) %>"

$('#createParceiro').modal('hide')
swal('Sucesso!', 'Parceiro cadastrado com sucesso!', 'success').then(->
  $('#parceiro\\:<%= @parceiro.id %>')[0].scrollIntoView()
  return
, ->
  $('#parceiro\\:<%= @parceiro.id %>')[0].scrollIntoView()
  return
)

<% else %>

$('#createParceiro form .form-group').addClass('has-success')
<% @parceiro.errors.each do |k, v| %>
$('#createParceiro form .form-group input#<%= k %>').parent().addClass('has-error')
$('#createParceiro form .form-group input#<%= k %> ~ .help-block').html('<%= v %>')
<% end %>

swal(
  type: 'error'
  title: 'Erro!'
  text: 'Verifique os dados e tente novamente!'
  timer: 2000
).then().catch(swal.noop)

<% end %>
