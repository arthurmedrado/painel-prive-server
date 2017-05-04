class ContatosController < ApplicationController
  before_action :set_contato, only: [:show, :edit, :update, :destroy]

  # GET /contatos
  # GET /contatos.json
  def index
    @contatos = Contato.all
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @contatos }
    end

  end

  # GET /contatos/1
  # GET /contatos/1.json
  def show
  end

  # GET /contatos/new
  def new
    @contato = Contato.new
  end

  # GET /contatos/1/edit
  def edit
  end

  # POST /contatos
  # POST /contatos.json
  def create
    @contato = Contato.create(nome: params[:nome], telefone: params[:telefone], email: params[:email], descricao: params[:descricao])

    # respond_to do |format|
    #   if @contato.save
    #     #format.html { redirect_to @contato, notice: 'Contato was successfully created.' }
    #     format.html { redirect_to contatos_url, notice: 'Contato criado com sucesso.' }
    #     format.json { render :show, status: :created, location: @contato }
    #   else
    #     format.html { render :new }
    #     format.json { render json: @contato.errors, status: :unprocessable_entity }
    #   end
    # end
  end

  # PATCH/PUT /contatos/1
  # PATCH/PUT /contatos/1.json
  def update
    respond_to do |format|
      if @contato.update(contato_params)
        #format.html { redirect_to @contato, notice: 'Contato was successfully updated.' }
        format.html { redirect_to contatos_url, notice: 'Contato atualizado com sucesso.' }
        format.json { render :show, status: :ok, location: @contato }
      else
        format.html { render :edit }
        format.json { render json: @contato.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /contatos/1
  # DELETE /contatos/1.json
  def destroy
    @contato.destroy
    respond_to do |format|
      format.html { redirect_to contatos_url, notice: 'Contato was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_contato
      @contato = Contato.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    # def contato_params
    #   params.require(:contato).permit(:nome, :telefone, :email, :descricao)
    # end
end
