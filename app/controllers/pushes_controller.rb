class PushesController < ApplicationController
  
  def create
    @push = Push.create(title: params[:title], message: params[:message] || '')
  end
  
  def destroy
    @push = Push.where(id: params[:push_id]).first
    @push.destroy
  end
end
