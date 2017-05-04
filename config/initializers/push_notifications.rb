APNS.port = 2195 
APNS.pem  = Rails.root.join('keys', 'anfeli.prive.pem')

if Rails.env.production?
  APNS.host = 'gateway.push.apple.com'
else
  APNS.host = 'gateway.sandbox.push.apple.com'
end

# APNS.send_notification(device_token, alert: 'Teste Push', badge: 200, other: { image_url: 'https://cdn.prive.anfeli.com.br/images/fidelidade/1491230257_Cupons1.jpg' } )
