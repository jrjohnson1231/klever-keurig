# myapp.rb
require 'sinatra'
require 'sinatra-websocket'

set :server, 'thin'
set :sockets, []

get '/' do
  if !request.websocket?
    puts params
    EM.next_tick { settings.sockets.each{|s| s.send(params[:message] || 'Got a message') } }
    return 'Hello, world!'
  else
    request.websocket do |ws|
      ws.onopen do
	ws.send('Hello!')
        settings.sockets << ws
      end
      ws.onclose do
        settings.sockets.delete(ws)
      end
    end
  end
end
