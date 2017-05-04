class AdminController < ApplicationController
  def index
    self.pagetitle = 'Administradores'
    @admins = Admin.all
  end

  def create
    @admin = Admin.create(name: params[:name], username: params[:username], password: params[:password])
  end

  def stats
    self.pagetitle = 'Estatisticas'
  end
end
