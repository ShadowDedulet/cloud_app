class AddVmRefToHdds < ActiveRecord::Migration[6.1]
  def change
    add_reference :hdds, :vm, null: false, foreign_key: true
  end
end
