class User < ApplicationRecord
  before_save :generate_auth_token
  has_many :posts

  validates_presence_of :name
  validates_presence_of :email
  validates_format_of :email, with: /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/
  validates_presence_of :fb_id
  validates_uniqueness_of :fb_id
  validates_presence_of :profile

  class << self
    def authenticate(auth_token)
      return nil if auth_token.nil?
      where(auth_token: auth_token).first
    end
  end

  def public_info
    { auth_token: auth_token,
      profile: profile,
      name: name
    }
  end

  def generate_auth_token
    unless auth_token.present?
      self.auth_token = OpenSSL::Digest.new('sha256').hexdigest("Prive-#{Time.current}-user.auth_token").downcase
    end
  end

end
