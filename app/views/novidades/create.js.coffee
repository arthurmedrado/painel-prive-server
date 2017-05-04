Ladda.stopAll()
$('#createNovidade form .form-group').removeClass('has-error has-warning').addClass('has-success')
$('#createNovidade form .form-group .help-block').html('')
$('#createNovidade form .form-group input').attr('readonly', false)

<% if @novidade.valid? && @novidade.persisted? %>

<% if @novidade.promocao? %>
$('#promocoes .row').append "<%= escape_javascript(render @novidade) %>"
<% elsif @novidade.gastronomia? %>
$('#gastronomia .row').append "<%= escape_javascript(render @novidade) %>"
<% elsif @novidade.programacao? %>
$('#programacao .row').append "<%= escape_javascript(render @novidade) %>"
<% end %>

$('#createNovidade').modal('hide')
swal('Sucesso!', 'Novidade cadastrada com sucesso!', 'success').then(->
  $('#novidade\\:<%= @novidade.id %>')[0].scrollIntoView()
  return
, ->
  $('#novidade\\:<%= @novidade.id %>')[0].scrollIntoView()
  return
)

<% else %>

$('#createNovidade form .form-group').addClass('has-success')
<% @novidade.errors.each do |k, v| %>
$('#createNovidade form .form-group input#<%= k %>').parent().addClass('has-error')
$('#createNovidade form .form-group input#<%= k %> ~ .help-block').html('<%= v %>')
<% end %>

swal(
  type: 'error'
  title: 'Erro!'
  text: 'Verifique os dados e tente novamente!'
  timer: 2000
).then().catch(swal.noop)

<% end %>
