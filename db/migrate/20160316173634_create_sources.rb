class CreateSources < ActiveRecord::Migration
  def change
    create_table :sources do |t|
      t.string :domain
      t.integer :score

      t.timestamps null: false
    end
  end
end
