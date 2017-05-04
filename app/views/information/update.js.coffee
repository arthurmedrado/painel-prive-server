<% if @success %>
swal('Sucesso!', 'Dados salvos!', 'success')

$('#pensoes ul').html "<%= escape_javascript(render partial: 'information/pensao-list') %>"
$('#hoteis ul').html "<%= escape_javascript(render partial: 'information/hotel-list') %>"

<% else %>
swal('Erro!', 'Dados não salvos!', 'error')

<% end %>
