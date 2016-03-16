class AddSourceIdToEvidences < ActiveRecord::Migration
  def change
    add_column :evidences, :source_id, :integer
  end
end
