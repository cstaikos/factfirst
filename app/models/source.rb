class Source < ActiveRecord::Base
  has_many :evidences

  after_create :set_defaults

  def set_defaults

  end

  def get_wot_score

  end

end
