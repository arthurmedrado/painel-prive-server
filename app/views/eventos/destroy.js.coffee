Ladda.stopAll()
swal('Sucesso!', 'Evento removido com sucesso.', 'success')
$('#destroyEvento').modal('hide')
$('#evento\\:<%= params[:evento_id] %>').remove()
