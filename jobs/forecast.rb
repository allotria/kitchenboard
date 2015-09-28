require 'net/https'
require 'json'

# Forecast API Key from https://developer.forecast.io
forecast_api_key = "910a008072d229929fc84e8d5857b099"

# Latitude, Longitude for location
# Stockholm
# forecast_location_lat = "59.32922"
# forecast_location_long = "18.06866"

# Home, Eskilstuna
forecast_location_lat = "59.368939"
forecast_location_long = "16.491008"


# Unit Format
# "us" - U.S. Imperial
# "si" - International System of Units
# "uk" - SI w. windSpeed in mph
forecast_units = "si"

forecast_lang = "de"

# Which report blocks to exclude from the API call. Comma separated list (w/o blanks)
# of the following block names: currently, minutely, hourly, daily, alerts, flags
forecast_exclude = "minutely,alerts,flags"

SCHEDULER.every '10m', :first_in => 0 do |job|
  http = Net::HTTP.new("api.forecast.io", 443)
  http.use_ssl = true
  http.verify_mode = OpenSSL::SSL::VERIFY_PEER
  response = http.request(Net::HTTP::Get.new("/forecast/#{forecast_api_key}/#{forecast_location_lat},#{forecast_location_long}?units=#{forecast_units}&lang=#{forecast_lang}&exclude=#{forecast_exclude}"))
  forecast = JSON.parse(response.body)  
  forecast_current_temp = forecast["currently"]["temperature"].round
  forecast_current_icon = forecast["currently"]["icon"]
  forecast_current_desc = forecast["currently"]["summary"]

  forecast_next_desc  = forecast["hourly"]["summary"]
  forecast_next_icon  = forecast["hourly"]["icon"]

  forecast_later_desc   = forecast["daily"]["summary"]
  forecast_later_icon   = forecast["daily"]["icon"]
  send_event('forecast', { current_temp: "#{forecast_current_temp}&deg;", current_icon: "#{forecast_current_icon}", current_desc: "#{forecast_current_desc}", next_icon: "#{forecast_next_icon}", next_desc: "#{forecast_next_desc}", later_icon: "#{forecast_later_icon}", later_desc: "#{forecast_later_desc}"})
end