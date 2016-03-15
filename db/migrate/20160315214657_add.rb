class Add < ActiveRecord::Migration
  def change
    add_column :evidences, :description, :text
    add_column :evidences, :title, :string
  end
end
