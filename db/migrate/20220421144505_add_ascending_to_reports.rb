class AddAscendingToReports < ActiveRecord::Migration[6.1]
  def change
    add_column :reports, :ascending, :boolean
  end
end
