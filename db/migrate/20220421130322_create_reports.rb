class CreateReports < ActiveRecord::Migration[6.1]
  def change
    create_table :reports do |t|
      t.integer :report_type
      t.integer :vm_amount
      t.json :output

      t.timestamps
    end
  end
end
