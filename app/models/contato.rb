class Contato < ApplicationRecord
  validates_presence_of :nome, message: 'Deve ser informado!'
  validates_presence_of :telefone, message: 'Deve ser informado!'
  validates_presence_of :descricao, message: 'Deve ser informado!'

  validates_format_of :email, with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i, message: 'Formato inválido!'
  validates_presence_of :email, message: 'Deve ser informado!'

end
