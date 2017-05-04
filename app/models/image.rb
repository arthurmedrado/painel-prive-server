class Image < ApplicationRecord
  belongs_to :gallery
  
  after_save :send_push
  
  def send_push
    return unless gallery.fidelidade?
    message = 'Tem promoção nova pra você!'
    Device.where(os: 'ios').pluck(:token).uniq.each do |device_token|
      APNS.send_notification(device_token, alert: message, badge: 0, other: { image_url: url })
    end
    Device.where(os: 'android').pluck(:token).uniq.each do |device_token|
    	GCM.send_notification(device_token, { alert: message, other: { image_url: url } })
    end
  end
  
end
