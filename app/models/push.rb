class Push < ApplicationRecord
  validates_presence_of :title, message: 'Deve ser informado'
  # validates_presence_of :message, message: 'Deve ser informado'

  after_save :send_push

  def send_push
    data = { title: title, body: message }
    data = title if message.empty?
    
    Device.where(os: 'ios').pluck(:token).uniq.each do |device_token|
      APNS.send_notification(device_token, alert: data, badge: 0)
    end
    Device.where(os: 'android').pluck(:token).uniq.each do |device_token|
    	GCM.send_notification(device_token, { alert: { title: title, body: message } })
    end
  end

  def as_json(options={})
    {
      title: title,
      message: message,
      date: created_at.strftime('%d/%m/%Y')
    }
  end

end
