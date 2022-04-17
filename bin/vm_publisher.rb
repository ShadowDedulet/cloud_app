require 'bunny'
require 'json'

connection = Bunny.new('amqp://guest:guest@rabbitmq')
connection.start

channel = connection.create_channel(nil, 16)
exchange = channel.default_exchange
queue_name = 'vm_status'

statuses = %w[unavailable created started failed removed]

exchange.publish({ 'id' => 1, 'status' => statuses.sample }.to_json, routing_key: queue_name)
