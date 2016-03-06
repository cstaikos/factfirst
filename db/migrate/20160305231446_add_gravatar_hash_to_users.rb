class AddGravatarHashToUsers < ActiveRecord::Migration
  def change
    add_column :users, :gravatar_hash, :string
  end
end
