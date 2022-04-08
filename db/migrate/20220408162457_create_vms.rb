class CreateVms < ActiveRecord::Migration[6.1]
  def change
    create_table :vms do |t|
      t.string :name
      t.integer :cpu
      t.integer :ram

      t.timestamps
    end
  end
end
