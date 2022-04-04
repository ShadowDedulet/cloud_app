class AddOptionsToOrders < ActiveRecord::Migration[6.1]
  def change
    add_column :orders, :options, :json
  end
end
