Ladda.stopAll()
swal('Sucesso!', 'Imagem removido com sucesso.', 'success')
$('#destroyImage').modal('hide')
$('#image\\:<%= params[:image_id] %>').remove()
