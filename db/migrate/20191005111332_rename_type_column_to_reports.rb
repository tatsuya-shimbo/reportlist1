class RenameTypeColumnToReports < ActiveRecord::Migration[5.2]
  def change
    rename_column :reports, :type, :teaching
  end
end
