class AddInfoFieldToUser < ActiveRecord::Migration
  def change
    add_column :users, :info, :text
  end
end
