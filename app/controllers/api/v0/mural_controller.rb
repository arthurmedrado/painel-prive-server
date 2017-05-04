class Api::V0::MuralController < Api::ApiBaseController
  before_action :restrict_access, only: [ :create ]

  def index
    page = params[:page].to_i || 0
    more_pages = ( (Post.count/30) > page )
    render json: {
      next_page: (page + 1).to_i,
      has_more: more_pages,
      posts: Post.order(created_at: :desc).includes(:user).limit(30).offset(30 * page).map(&:public_info)
    }
  end

  def latest
    timestamp = params[:timestamp].to_i || 0
    range = Time.at(timestamp)..Time.now
    render json: {
      posts: Post.where(created_at: range).order(created_at: :desc).includes(:user).map(&:public_info)
    }
  end

  def create
    @message = current_user.posts.create(message: params[:message])
    if @message.valid? && @message.persisted?
      render status: 200, json: { status: 200, data: @message.public_info }
    else
      render status: 200, json: { status: 412, data: { key: 'ERROR_INVALID_DATA', debug: 'Informações invalidas', errors: @message.errors } }
    end
  end

end
