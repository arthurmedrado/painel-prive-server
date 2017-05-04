Ladda.stopAll()
swal('Sucesso!', 'Parceiro removido com sucesso.', 'success')
$('#destroyParceiro').modal('hide')
$('#parceiro\\:<%= params[:parceiro_id] %>').remove()
