class ChangeWotScoreToWotTrustAndAddWotConfidence < ActiveRecord::Migration
  def change
    rename_column :sources, :wot_score, :wot_trust
    add_column :sources, :wot_confidence, :integer
  end
end
