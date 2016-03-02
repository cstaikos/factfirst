class CreateEvidences < ActiveRecord::Migration
  def change
    create_table :evidences do |t|
      t.string :url
      t.boolean :support
      t.integer :user_id
      t.integer :fact_id

      t.timestamps null: false
    end
  end
end
