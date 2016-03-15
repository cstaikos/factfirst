class AddIndexes < ActiveRecord::Migration
  def change
    add_index :evidences, :user_id
    add_index :evidences, :fact_id
    add_index :facts, :score
    add_index :facts, :created_at
    add_index :facts, :user_id
    add_index :facts, :category_id
    add_index :votes, :evidence_id
    add_index :votes, :user_id
  end
end
