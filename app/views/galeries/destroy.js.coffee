Ladda.stopAll()
swal('Sucesso!', 'Galeria removido com sucesso.', 'success')
$('#removeGallery').modal('hide')
$('#galeria\\:<%= params[:gallery_id] %>').remove()
