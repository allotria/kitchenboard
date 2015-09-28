# this is just the dummy sample using random data to illustrate
# replace the random data with your real data... wherever you get it from

# Populate the multi-graph with some initial points
points1 = []
points2 = []
(1..10).each do |i|
  points1 << { x: i, y: rand(50) }     # graph 1 initialization
  points2 << { x: i, y: rand(50) }     # graph 2 initialization
end
last_x = points1.last[:x]

SCHEDULER.every '1m' do
  points1.shift
  points2.shift
  last_x += 1
  points1 << { x: last_x, y: rand(50) }         # this is where you'd add a data element for graph 1
  points2 << { x: last_x, y: rand(50) }         # this is where you'd add a data element for graph 2
  send_event('tempHum1', points: [points1, points2])
end