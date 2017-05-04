class Post < ApplicationRecord
  belongs_to :user
  
  validates_presence_of :message
  
  def public_info
    { user: (user || User.new).public_info.reject{|k, v| k == :auth_token},
      message: message || '',
      date: created_at.to_i,
      id: id
    }
  end
end
