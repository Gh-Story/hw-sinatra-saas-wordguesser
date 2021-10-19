require 'sinatra'

class MyApp < Sinatra::Base
  get '/' do
    "<!DOCTYPE html><html><head></head><body><h1>Hello World</h1><h1>Goodbye World</h1><h1>HarryP</h1></body></html>"
  end
end

