class RemoveGravatarHashFromUsers < ActiveRecord::Migration
  def change
    remove_column :users, :gravatar_hash
  end
end
