require 'websocket-client-simple'

ws = WebSocket::Client::Simple.connect 'ws://stark-crag-25677.herokuapp.com'

ws.on :message do |msg|
  puts msg.data
end

ws.on :open do
  ws.send 'hello!!!'
end

ws.on :close do |e|
  puts e
  exit 1
end

ws.on :error do |e|
  puts e
end

loop do
  ws.send STDIN.gets.strip
end
