class RemoveAndAddFieldsToUser < ActiveRecord::Migration
  def change
    remove_column :users, :info
    add_column :users, :login, :string
    add_column :users, :password, :string
  end
end
