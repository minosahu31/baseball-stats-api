class RenameColumnThrowToThrowsInPlayers < ActiveRecord::Migration[6.0]
  def change
    rename_column :players, :throw, :throws
  end
end
