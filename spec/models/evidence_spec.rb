require 'rails_helper'

RSpec.describe Evidence, type: :model do

  # before(:each) do
  #   @evidence = create(:evidence)
  #   @upvote = create(:vote)
  #   @upvote.evidence_id = @evidence.id
  #   @upvote.upvote = true
  #   @downvote = create(:vote)
  #   @downvote.upvote = false
  # end

  # after(:each) do
  #   p @upvote
  #   p @evidence
  #   p @evidence.upvotes
  # end

  # it "returns the right amount of upvotes" do
  #   @upvote.evidence_id = @evidence.id
  #   expect(@evidence.upvotes).to eq 1
  #   expect(@evidence.votes.where(upvote: true).count).to eq 1
  # end

  describe "#upvotes" do
    it "returns evidence upvotes count including the newly created upvote" do
      evidence = create(:evidence)
      create(:vote, upvote: true, evidence_id: evidence.id)
      expect(evidence.upvotes).to eq 1
    end
  end

  describe "#downvotes" do
    it "returns evidence downvotes count including the newly created downvote" do
      evidence = create(:evidence)
      create(:vote, upvote: false, evidence_id: evidence.id)
      expect(evidence.downvotes).to eq 1
    end
  end

end

