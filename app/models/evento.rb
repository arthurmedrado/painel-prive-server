class Evento < ApplicationRecord
  validates_presence_of :titulo, message: 'Deve ser informado!'
  validates_presence_of :telefone, message: 'Deve ser informado!'
  validates_presence_of :data, message: 'Deve ser informado!'
  validates_presence_of :site, message: 'Deve ser informado!'
  validates_presence_of :longitude, message: 'Deve ser informado!'
  validates_presence_of :latitude, message: 'Deve ser informado!'
  #validates_presence_of :descricao, message: 'Deve ser informado!'

  validates_format_of :email, with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i, message: 'Formato inválido!'
  validates_presence_of :email, message: 'Deve ser informado!'

  def as_json(options={})
    {
        title: titulo,
        date: data,
        message: descricao,
        email: email,
        phone: telefone.gsub(/[^+0-9]/i, ''),
        website: site,
        lat: latitude,
        lon: longitude
    }
  end

end
