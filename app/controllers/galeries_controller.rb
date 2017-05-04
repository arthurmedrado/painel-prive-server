class GaleriesController < ApplicationController
  def index
    @galerias = Gallery.where(category: ['hotel', 'parque']).includes(:images)
    
    @hoteis = @galerias.where(category: 'hotel')
    @parques = @galerias.where(category: 'parque')
  end
  
  def create
    @galeria = Gallery.create(title: params[:title], category: params[:category])
  end
  
  def update
    @galeria = Gallery.where(id: params[:gallery_id]).first
    @galeria.update_attributes(title: params[:title])
  end
  
  def destroy
    @galeria = Gallery.where(id: params[:gallery_id]).first
    @galeria.destroy
  end
end
