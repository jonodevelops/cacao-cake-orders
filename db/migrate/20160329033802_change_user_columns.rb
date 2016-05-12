class ChangeUserColumns < ActiveRecord::Migration
  def change
  	remove_column :users, :first_name, :string
  	remove_column :users, :last_name, :string
  	remove_column :users, :hashed_password, :string

  	add_column :users, :password_digest, :string, null: :false
  	add_column :users, :admin, :boolean, default: :false, null: :false
  	add_belongs_to :users, :location, index: true, null: :false

  end
end
