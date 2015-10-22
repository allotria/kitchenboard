
# Tellprox API key
tellprox_api_key = "a8e23d31f9caa5fc6e4cd0872f923a86"
tellprox_sensor_id = "111"

# Populate the multi-graph with some initial points
tempValues = []
humValues = []
(1..5).each do |i|
  tempValues << { x: i, y: 0 }     # graph 1 initialization
  humValues << { x: i, y: 0 }     # graph 2 initialization
end
last_x = tempValues.last[:x]

SCHEDULER.every '1m', :first_in => 0 do |job|
  http = Net::HTTP.new("localhost", 8080)
  http.use_ssl = false
  response = http.request(Net::HTTP::Get.new("/json/sensor/info?key=#{tellprox_api_key}&id=#{tellprox_sensor_id}"))
  sensorData = JSON.parse(response.body)


  # now = Date.now() / 1000 | 0 # javascript

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
  humValues.shift
  last_x += 1
  tempValues << { x: last_x, y: temp }         # this is where you'd add a data element for graph 1
  humValues << { x: last_x, y: hum }         # this is where you'd add a data element for graph 2
  # send_event('tempHum1', points: [tempValues, humValues])
  send_event('mygaugeHum', current: hum.to_f)
  send_event('drinnenTemp', points: tempValues)
end

# SCHEDULER.every '5s' do
#   tempValues.shift
#   humValues.shift
#   last_x += 1
#   tempValues << { x: last_x, y: rand(50) }         # this is where you'd add a data element for graph 1
#   humValues << { x: last_x, y: rand(50) }         # this is where you'd add a data element for graph 2
#   send_event('tempHum1', points: [tempValues, humValues])
# end