class RenameColumnStatus < ActiveRecord::Migration[5.1]
  def change
    rename_column :schools, :statust, :status
  end
end
