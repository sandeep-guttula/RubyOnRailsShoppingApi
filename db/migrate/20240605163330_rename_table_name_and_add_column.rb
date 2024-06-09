class RenameTableNameAndAddColumn < ActiveRecord::Migration[7.2]
  def change
    rename_table :names, :users
    add_column :users, :name, :string
  end
end
