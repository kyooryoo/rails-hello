class AddAttributesToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :email, :string
    add_column :users, :created_at, :datetime
    add_column :users, :updated_at, :datetime
  end
end
