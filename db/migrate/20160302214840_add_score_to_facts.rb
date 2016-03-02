class AddScoreToFacts < ActiveRecord::Migration
  def change
    add_column :facts, :score, :integer
  end
end
