class AddIndexOnCostToOrders < ActiveRecord::Migration[6.1]
  def change
    add_index :orders, :cost
  end
end
