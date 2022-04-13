require 'bunny'
require './app/services/stop_vm_service.rb'

connection = Bunny.new('amqp://guest:guest@rabbitmq')
connection.start

channel = connection.create_channel(nil, 16)
queue = channel.queue('vm.control', auto_delete: true)

queue.subscribe do |_delivery_info, _metadata, payload|
  StopVmService.call(payload)
end

Signal.trap('INT') do
  puts 'exiting INT'
  connection.close
end

Signal.trap('TERM') do
  puts 'killing TERM'
  connection.close
end

loop do
  sleep
end
