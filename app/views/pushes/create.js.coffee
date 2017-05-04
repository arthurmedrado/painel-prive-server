Ladda.stopAll()
$('#createPush form .form-group').removeClass('has-error has-warning').addClass('has-success')
$('#createPush form .form-group .help-block').html('')
$('#createPush form .form-group input').attr('readonly', false)

<% if @push.valid? && @push.persisted? %>

$('#pushes .row').append "<%= escape_javascript(render @push) %>"

$('#createPush').modal('hide')
swal('Sucesso!', 'Push cadastrado com sucesso!', 'success').then(->
  $('#push\\:<%= @push.id %>')[0].scrollIntoView()
  return
, ->
  $('#push\\:<%= @push.id %>')[0].scrollIntoView()
  return
)

<% else %>

$('#createPush form .form-group').addClass('has-success')
<% @push.errors.each do |k, v| %>
$('#createPush form .form-group #<%= k %>').parent().addClass('has-error')
$('#createPush form .form-group #<%= k %> ~ .help-block').html('<%= v %>')
<% end %>

swal(
  type: 'error'
  title: 'Erro!'
  text: 'Verifique os dados e tente novamente!'
  timer: 2000
).then().catch(swal.noop)

<% end %>
