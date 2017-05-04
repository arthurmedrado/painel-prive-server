Ladda.stopAll()
swal('Sucesso!', 'Push removido com sucesso.', 'success')
$('#destroyPush').modal('hide')
$('#push\\:<%= params[:push_id] %>').remove()
