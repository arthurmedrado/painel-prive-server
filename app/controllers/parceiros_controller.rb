class ParceirosController < ApplicationController

  def index
    @parceiros = Parceiro.all
  end

  def create
    @parceiro = Parceiro.create(name: params[:name], telefone: params[:telefone], descricao1: params[:descricao1], descricao2: params[:descricao2], descricao3: params[:descricao3], descricaoMapa: params[:descricaoMapa], longitude: params[:longitude], latitude: params[:latitude], imagem: params[:imagem],
    site: params[:site])
  end

  def update
    @parceiro = Parceiro.where(id: params[:parceiro_id]).first
    unless @parceiro.nil?
      @parceiro.update_attributes(name: params[:name], telefone: params[:telefone], descricao1: params[:descricao1], descricao2: params[:descricao2], descricao3: params[:descricao3], descricaoMapa: params[:descricaoMapa], longitude: params[:longitude], latitude: params[:latitude], imagem: params[:imagem],
      site: params[:site])
    end
  end

  def destroy
    Parceiro.where(id: params[:parceiro_id]).first.destroy
  end

end
