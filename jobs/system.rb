require 'json'
require 'rubygems'

get '/functions/halt' do
  stdin, stdout, stderr = Open3.popen3('sudo halt')
  if stdout.gets
    send_event('systemText', "{ 'text': '#{stdout.gets}' }")
  end

  'Halting' unless stderr.gets
end

get '/functions/reboot' do
  stdin, stdout, stderr = Open3.popen3('sudo reboot')
  if stdout.gets
    send_event('systemText', "{ 'text': '#{stdout.gets}' }")
  end

  'Rebooting' unless stderr.gets
end

SCHEDULER.every '10m', :first_in => 0 do |job|

  ips = %x[ hostname -I ]
  send_event('systemText', "{ 'text': 'IP adresses: #{ips}' }")
end