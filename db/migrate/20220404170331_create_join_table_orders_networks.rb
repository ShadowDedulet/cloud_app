class CreateJoinTableOrdersNetworks < ActiveRecord::Migration[6.1]
  def change
    create_join_table :orders, :networks do |t|
      # t.index [:order_id, :network_id]
      # t.index [:network_id, :order_id]
    end
  end
end
