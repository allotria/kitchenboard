require 'json'
require 'rubygems'
require 'ohai'

get '/functions/halt' do
  # output = %x[ echo hello ]
  stdin, stdout, stderr = Open3.popen3('halt')
  if stdout.gets
    send_event('systemText', { "text": "#{stdout.gets}" })
  end

  stderr
end

SCHEDULER.every '10s', :first_in => 0 do |job|

  # @ohai = Ohai::System.new
  # @ohai.all_plugins
  #
  # sysinf = "foo"
  #
  # interfaces = @ohai["network"]["interfaces"]
  # interfaces.each do | intf |
  #   puts intf
  #   adr = intf[:adresses]
  #   if adr[:family] == "inet"
  #     sysinf += adr
  #   end
  # end

  # send_event('systemText', { "text": "#{sysinf}" })
  send_event('systemText', { "text": "foo" })
end