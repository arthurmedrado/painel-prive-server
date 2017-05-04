class EventosController < ApplicationController

  def index
    @eventos = Evento.all
  end

  def create
    @evento = Evento.create(titulo: params[:titulo], telefone: params[:telefone], email: params[:email], descricao: params[:descricao], data: params[:data], longitude: params[:longitude], latitude: params[:latitude], site: params[:site])
  end

  def update
    @evento = Evento.where(id: params[:evento_id]).first
    unless @evento.nil?
      @evento.update_attributes(titulo: params[:titulo], telefone: params[:telefone], email: params[:email], descricao: params[:descricao], data: params[:data], longitude: params[:longitude], latitude: params[:latitude], site: params[:site])
    end
  end

  def destroy
    Evento.where(id: params[:evento_id]).first.destroy
  end
end
