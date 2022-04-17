require 'bunny'
require './app/services/change_vm_status_service'

connection = Bunny.new('amqp://guest:guest@rabbitmq')
connection.start

channel = connection.create_channel(nil, 16)
queue = channel.queue('vm_status', auto_delete: true)

puts('subscribing..')
queue.subscribe do |_delivery_info, _metadata, payload|
  ChangeVmStatusService.call(payload)
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
