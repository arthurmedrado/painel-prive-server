class NovidadesController < ApplicationController

  def index
    @pushes = Push.all.order(created_at: :desc)
    
    novidades = Novidade.all.order(created_at: :desc)
    
    @promocoes = novidades.where(categoria: :promocao)
    @gastronomia = novidades.where(categoria: :gastronomia)
    @programacao = novidades.where(categoria: :programacao)
  end

  def create
    @novidade = Novidade.create(name: params[:name], descricao: params[:descricao], categoria: params[:categoria])
  end

  def update
    @novidade = Novidade.where(id: params[:novidade_id]).first
    unless @novidade.nil?
      @novidade.update_attributes(name: params[:name], descricao: params[:descricao], categoria: params[:categoria])
    end
  end

  def destroy
    Novidade.where(id: params[:novidade_id]).first.destroy
  end

end
