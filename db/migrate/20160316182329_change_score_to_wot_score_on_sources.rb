class ChangeScoreToWotScoreOnSources < ActiveRecord::Migration
  def change
    rename_column :sources, :score, :wot_score
  end
end
