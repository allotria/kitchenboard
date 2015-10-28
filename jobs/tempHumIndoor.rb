
# Tellprox API key
tellprox_api_key = "a8e23d31f9caa5fc6e4cd0872f923a86"
tellprox_sensor_id = "111"

# Populate the multi-graph with some initial points
tempValues = []
(1..5).each do |i|
  tempValues << { x: i, y: 0 }     # graph 1 initialization
end

last_x = tempValues.last[:x]

SCHEDULER.every '1m', :first_in => 0 do |job|
  http = Net::HTTP.new("localhost", 8080)
  http.use_ssl = false
  response = http.request(Net::HTTP::Get.new("/json/sensor/info?key=#{tellprox_api_key}&id=#{tellprox_sensor_id}"))
  sensorData = JSON.parse(response.body)

  lastUpdate = sensorData["lastUpdated"]
  temp = 0
  hum = 0

  sensorData["data"].each do |x|
    name = x["name"]
    value = x["value"]

    if "temp".eql?(name)
      temp = value
    elsif "humidity".eql?(name)
      hum = value
    end
  end

  tempValues.shift
  last_x += 1
  tempValues << { x: last_x, y: temp }         # this is where you'd add a data element for graph 1
  # send_event('tempHum1', points: [tempValues, humValues])
  send_event('drinnenHum', current: hum.to_f)
  send_event('drinnenTemp', points: tempValues)

   # send_event('drinnenHum', current: 60)
   # send_event('drinnenTemp', points: tempValues)
end

