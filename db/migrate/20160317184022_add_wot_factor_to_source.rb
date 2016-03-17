class AddWotFactorToSource < ActiveRecord::Migration
  def change
    add_column :sources, :wot_factor, :decimal
  end
end
