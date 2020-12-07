class AddColumnThrowToPlayerAndRemoveTableThrow < ActiveRecord::Migration[6.0]
  def change
    # drop_table :throws
    add_column :players, :throw, :string
  end
end
