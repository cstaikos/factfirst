class AddCategoryIdToFacts < ActiveRecord::Migration
  def change
    add_column :facts, :category_id, :integer
  end
end
