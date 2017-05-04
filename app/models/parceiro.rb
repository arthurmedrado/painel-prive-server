class Parceiro < ApplicationRecord
  validates_presence_of :name, message: 'Deve ser informado!'
  #validates_presence_of :telefone, message: 'Deve ser informado!'
  validates_presence_of :site, message: 'Deve ser informado!'
  validates_presence_of :longitude, message: 'Deve ser informado!'
  validates_presence_of :latitude, message: 'Deve ser informado!'

  # validates_presence_of :descricao1, message: 'Deve ser informado!'
  # validates_presence_of :descricao2, message: 'Deve ser informado!'
  #validates_presence_of :descricao3, message: 'Deve ser informado!'
  #validates_presence_of :descricaoMapa, message: 'Deve ser informado!'

  #validates_presence_of :imagem, message: 'Deve ser informado!'

  def as_json(options={})
    {
      name: name,
      descriptionFull: descricao1,
      descriptionSmall: descricaoMapa,
      descriptionLeft: descricao2,
      descriptionRight: descricao3,
      phoneReadable: telefone,
      phone: telefone.gsub(/[^+0-9]/i, ''),
      website: site,
      faceook:facebook,
      instagram: instagram,
      imageUrlString: imagem,
      lat: latitude,
      lon: longitude
    }
  end
end
