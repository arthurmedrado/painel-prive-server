class Api::V0::ApiController < Api::ApiBaseController

  def update_token
    Device.where(token: params[:token], os: 'ios').first_or_create
    head 204
  end

  def data
    @informations = Information.all
    @novidades = Novidade.all
    @galerias = Gallery.all
    
    render status: 200, json: {
      videos: @informations.where(key: 'youtube').pluck(:value).uniq,
      phone_number_readable: @informations.where(key: 'phone-global').pluck(:value).first,
      phone_number: @informations.where(key: 'phone-global').pluck(:value).first.gsub(/[^+0-9]/i, ''),
      instagram_username: @informations.where(key: 'facebook-global').pluck(:value).first,
      facebook_profile: @informations.where(key: 'instagram-global').pluck(:value).first,
      website: @informations.where(key: 'website-global').pluck(:value).first,
      contact_email: @informations.where(key: 'contato-email-global').pluck(:value).first,
      pensao_tipo: @informations.where(key: 'pensao-tipo').pluck(:value).uniq,
      hoteis_nome: @informations.where(key: 'hoteis-nome').pluck(:value).uniq,
      galeria_hoteis: @galerias.where(category: 'hotel').includes(:images),
      galeria_parques: @galerias.where(category: 'parque').includes(:images),
      galeria_fidelidade: @galerias.where(category: 'fidelidade').includes(:images),
      eventos: Evento.all,
      pushes: Push.all.order(created_at: :desc),
      title_programacao: @informations.where(key: 'programacao-title-global').pluck(:value).first,
      programacao: @novidades.where(categoria: :programacao),
      title_gastronomia: @informations.where(key: 'gastronomia-title-global').pluck(:value).first,
      gastronomia: @novidades.where(categoria: :gastronomia),
      title_promocoes: @informations.where(key: 'promocoes-title-global').pluck(:value).first,
      promocoes: @novidades.where(categoria: :promocao),
      parceiros: Parceiro.all,
    }
  end

  # User registration (facebook)
  def login
    profile_picture = "http://graph.facebook.com/#{params[:fb_id]}/picture?type=large"

    @user = User.where(fb_id: params[:fb_id]).limit(1).first
    if @user.nil?
      @user = User.create(name: params[:name], email: params[:email], fb_id: params[:fb_id], profile: profile_picture)
      if @user.valid? && @user.persisted?
        render status: 200, json: { status: 200, data: @user.public_info, auth: @user.auth_token }
      else
        render status: 200, json: { status: 412, data: { key: 'ERROR_INVALID_DATA', debug: 'Informações invalidas', errors: @user.errors } }
      end
    else
      @user.update_attributes(name: params[:name], email: params[:email], profile: profile_picture)
      render status: 200, json: { status: 200, data: @user.public_info, auth: @user.auth_token }
    end
  end

end
