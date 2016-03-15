class AddForeignKeys < ActiveRecord::Migration
  def change
    add_foreign_key :evidences, :users
    add_foreign_key :evidences, :facts
    add_foreign_key :facts, :users
    add_foreign_key :facts, :categories
    add_foreign_key :votes, :evidences
    add_foreign_key :votes, :users
  end
end
