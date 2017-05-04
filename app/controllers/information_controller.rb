class InformationController < ApplicationController
  def index
    @informations = Information.all
    
    @phoneGlobal = @informations.where(key: 'phone-global').pluck(:value).first
    @facebookGlobal = @informations.where(key: 'facebook-global').pluck(:value).first
    @instagramGlobal = @informations.where(key: 'instagram-global').pluck(:value).first
    @websiteGlobal = @informations.where(key: 'website-global').pluck(:value).first
    @contatoEmailGlobal = @informations.where(key: 'contato-email-global').pluck(:value).first
    @youtubePlaylist = @informations.where(key: 'youtube').pluck(:value).first
    
    @pensoes = @informations.where(key: 'pensao-tipo')
    @hoteis = @informations.where(key: 'hoteis-nome')
  end
  
  def update
    @success = true
    
    @success &= Information.where(key: 'phone-global').first_or_create.update_attributes(value: params[:'phone-global'])
    @success &= Information.where(key: 'facebook-global').first_or_create.update_attributes(value: params[:'facebook-global'])
    @success &= Information.where(key: 'instagram-global').first_or_create.update_attributes(value: params[:'instagram-global'])
    @success &= Information.where(key: 'website-global').first_or_create.update_attributes(value: params[:'website-global'])
    @success &= Information.where(key: 'contato-email-global').first_or_create.update_attributes(value: params[:'contato-email-global'])
    @success &= Information.where(key: 'youtube').first_or_create.update_attributes(value: params[:youtube])
    
    params[:'pensao-tipo'].each do |pensao|
      if !pensao[:id].blank? && pensao[:destroy] == "true"
        @success &= Information.where(id: pensao[:id]).destroy_all
      elsif pensao[:id].blank?
        @success &= Information.create(key: 'pensao-tipo', value: pensao[:name])
      end
    end
    
    params[:'hoteis-nome'].each do |hotel|
      if !hotel[:id].blank? && hotel[:destroy] == "true"
        @success &= Information.where(id: hotel[:id]).destroy_all
      elsif hotel[:id].blank?
        @success &= Information.create(key: 'hoteis-nome', value: hotel[:name])
      end
    end
    
    informations = Information.where(key: ['pensao-tipo', 'hoteis-nome'])
    
    @pensoes = informations.where(key: 'pensao-tipo')
    @hoteis = informations.where(key: 'hoteis-nome')
  end
end
