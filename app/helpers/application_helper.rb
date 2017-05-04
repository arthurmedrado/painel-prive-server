module ApplicationHelper
  
  def pagetitle
    if @pagetitle.nil?
      basetitle
    else
      "#{@pagetitle} - #{basetitle}"
    end
  end
  
  def developed_by_url
    'http://anfeli.com.br'
  end
  
private
  def basetitle
    'Administração app Prive'
  end
  
end
