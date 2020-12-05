class RemoveColumnThrowIdFromPlayer < ActiveRecord::Migration[6.0]
  def change
    remove_column :players, :throw_id
  end
end
