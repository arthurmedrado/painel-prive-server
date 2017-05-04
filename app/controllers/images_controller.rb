class ImagesController < ApplicationController
  def upload
    tempfile = params[:image]
    mime = `file --mime-type --brief #{tempfile.path}`
    
    if mime =~ /image/
      url = save_advert_media(tempfile)
      render json: { url: url, displayUrl: url }
    else
      render json: { error: 'Formato de arquivo inválido! Tente novamente usando outro arquivo.' }
    end
  end
  
  def create
    @image = Image.create(gallery_id: params[:'gallery-id'], url: params[:'image-url'])
  end
  
  def destroy
    Image.where(id: params[:image_id]).destroy_all
  end
  
private
  def save_advert_media(tempfile)
    ext = tempfile.original_filename.split('.').last
    new_filename = Digest::SHA256.hexdigest("#{Time.now.to_i}-#{current_admin.name}-#{current_admin.id}-#{current_admin.name}-#{Time.now.to_i}-#{tempfile.original_filename}")
    path = "/uploads/#{new_filename}.#{ext}"
    
    File.open("#{CDN_ROOT}#{path}", 'wb') do |f|
      f.write tempfile.read
    end
    
    "#{CDN_URL}#{path}"
  end
end
