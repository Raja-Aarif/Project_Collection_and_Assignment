class AddPriorityColToProjects < ActiveRecord::Migration[5.1]
  def change
     add_column :projects, :priority, :boolean, default: false
  end
end

