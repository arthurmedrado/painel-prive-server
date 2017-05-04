Ladda.stopAll()
swal('Sucesso!', 'Novidade removido com sucesso.', 'success')
$('#destroyNovidade').modal('hide')
$('#novidade\\:<%= params[:novidade_id] %>').remove()
