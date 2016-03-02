class Fact < ActiveRecord::Base
  belongs_to :user
  has_many :evidences
  has_many :votes, through: :evidences

  accepts_nested_attributes_for :evidences, reject_if: :all_blank, allow_destroy: true

  after_initialize :set_defaults

  def set_defaults
    self.score = 0
    self.save
  end

  def supporting_evidence
    evidences.where(support: true)
  end

  def refuting_evidence
    evidences.where(support: false)
  end

  def update_score


  end
  
end
