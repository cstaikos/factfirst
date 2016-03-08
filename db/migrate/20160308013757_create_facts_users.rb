class CreateFactsUsers < ActiveRecord::Migration
  def change
    create_table :facts_users do |t|
      t.integer :fact_id
      t.integer :user_id
    end
  end
end
