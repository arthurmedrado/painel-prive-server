class Gallery < ApplicationRecord
  has_many :images, dependent: :destroy
  
  validates_presence_of :category
  
  def as_json(options = {})
    {
      title: title,
      images: images.pluck(:url).uniq
    }
  end
  
  def hotel?
    category == 'hotel'
  end
  
  def parque?
    category == 'parque'
  end
  
  def fidelidade?
    category == 'fidelidade'
  end
end
