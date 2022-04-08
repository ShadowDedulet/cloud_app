class CreateJoinTableProjectsVms < ActiveRecord::Migration[6.1]
  def change
    create_join_table :projects, :vms do |t|
      # t.index [:project_id, :vm_id]
      # t.index [:vm_id, :project_id]
    end
  end
end
