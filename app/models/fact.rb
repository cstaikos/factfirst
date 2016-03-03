class Fact < ActiveRecord::Base
  belongs_to :user
  has_many :evidences

  accepts_nested_attributes_for :evidences, reject_if: :all_blank, allow_destroy: true

  after_create :set_defaults

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
    num_votes = evidences.inject(0) do |sum, evidence|
      sum += evidence.upvotes + evidence.downvotes
    end

    return if num_votes == 0

    vote_sums = evidences.inject(0) do |sum, evidence|
      if evidence.support
        sum += evidence.upvotes #upvotes on supporting evidence are good for a fact
      else
        sum += evidence.downvotes #downvotes on refuting evidence are good for a fact
      end
    end

    self.score = (vote_sums.to_f / num_votes.to_f * 100).round
  
    self.save
  end

end
