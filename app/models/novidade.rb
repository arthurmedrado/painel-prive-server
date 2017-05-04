class Novidade < ApplicationRecord
  validates_presence_of :categoria
  validates_presence_of :name, message: 'Deve ser informado!'
  #validates_presence_of :descricao, message: 'Deve ser informado!'

  enum categoria: { promocao: 0, gastronomia: 1, programacao: 2 }

  def as_json(options={})
    {
      title: name,
      message: descricao.html_safe
    }
  end
end
