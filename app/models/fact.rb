class Fact < ActiveRecord::Base
  belongs_to :user
  has_many :evidences

  accepts_nested_attributes_for :evidences, reject_if: :all_blank, allow_destroy: true

  def supporting_evidence
    evidences.where(support: true)
  end

  def refuting_evidence
    evidences.where(support: false)
  end
end
