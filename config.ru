$: << File.expand_path('./lib', File.dirname(__FILE__))
require_relative './secrets/keys.rb'
require 'dashing-contrib'
require 'dashing'


DashingContrib.configure


configure do
  set :auth_token, '81065ff7c938d2c726309f38a33106a5'
  set :default_dashboard, 'kitchenboard' #<==== set default dashboard like this

  helpers do
    def protected!
     # Put any authentication code you want in here.
     # This method is run before accessing any resource.
    end
  end
end

map Sinatra::Application.assets_prefix do
  run Sinatra::Application.sprockets
end

run Sinatra::Application
