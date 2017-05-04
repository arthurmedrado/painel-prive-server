class FidelidadeController < ApplicationController
  def index
    @fidelidade = Gallery.where(category: 'fidelidade').includes(:images).first
  end
end
