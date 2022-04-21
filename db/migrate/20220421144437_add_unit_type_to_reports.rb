class AddUnitTypeToReports < ActiveRecord::Migration[6.1]
  def change
    add_column :reports, :unit_type, :integer
  end
end
