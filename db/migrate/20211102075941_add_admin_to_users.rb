class AddAdminToUsers < ActiveRecord::Migration[6.1]
  def change
    aadd_column :users, :admin, :boolean, default: false
  end
end
