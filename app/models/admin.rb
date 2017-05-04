class Admin < ApplicationRecord
  attr_accessor :password
  before_save :encrypt_password

  validates_presence_of :username
  validates_uniqueness_of :username
  validates_presence_of :password, on: :create, allow_blank: false
  validates_presence_of :password, on: :update, allow_blank: true
  validates_length_of :password, within: 5..25, allow_blank: true


  def self.authenticate(username, password)
    admin = where(username: username).first
    return nil if admin.nil?
    return nil if admin.password_hash != BCrypt::Engine.hash_secret(password, admin.password_salt)
    return admin
  end

  def encrypt_password
    if password.present?
      self.password_salt = BCrypt::Engine.generate_salt
      self.password_hash = BCrypt::Engine.hash_secret(password, password_salt)
    end
  end

end
