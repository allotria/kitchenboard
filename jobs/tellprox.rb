require 'json'
require 'open-uri'

apiKey = 'a8e23d31f9caa5fc6e4cd0872f923a86'
baseUrl = 'http://localhost:8080/json/device/'

post '/tellstick/turnon' do
  puts "Turn on #{params['deviceId']}"
  open(baseUrl + 'turnon?key=' + apiKey + '&id=' + params['deviceId'])

end

post '/tellstick/turnoff' do
  puts "Turn off #{params['deviceId']}"
  open(baseUrl + 'turnoff?key=' + apiKey + '&id=' + params['deviceId'])

end