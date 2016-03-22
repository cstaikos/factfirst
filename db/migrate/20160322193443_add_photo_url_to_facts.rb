class AddPhotoUrlToFacts < ActiveRecord::Migration
  def change
    add_column :facts, :photo_url, :string
  end
end
