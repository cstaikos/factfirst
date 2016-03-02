class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.boolean :upvote
      t.integer :evidence_id
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
