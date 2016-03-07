require 'rails_helper'

RSpec.describe Fact, type: :model do

  # before(:each) do
  #   # Fact.delete_all
  #   @fact = create(:fact)
  #   @evidence = create(:evidence)
  #   @vote = create(:vote)
  # end

  after(:all) do
    Fact.delete_all
    Evidence.delete_all
    p Fact.all
    p Evidence.all
  end

  #
  # it "has has properties defined in factory" do
  #   expect(Fact.count).to eq 1
  # end
  #
  # it "has a higher score when associated evidence is upvoted" do
  #   @evidence.fact_id = @fact.id
  #   @evidence.support = true
  #   @vote.evidence_id = @evidence.id
  #   @vote.upvote = true
  #   expect(@fact.score).to eq 1
  # end

  describe "#set_defaults" do
    it "sets the default fact score to 0" do
      fact = create(:fact)
      expect(fact.score).to eq 0
    end
  end

  describe "#supporting_evidence" do
    it "returns fact supporting evidence collection with newly created evidence included" do
      fact = create(:fact)
      evidence = create(:evidence, support: true, fact_id: fact.id)
      expect(fact.supporting_evidence[0]).to eq evidence
    end
  end

  describe "#refuting_evidence" do
    it "returns fact refuting evidence collection with newly created evidence included" do
      fact = create(:fact)
      evidence = create(:evidence, support: false, fact_id: fact.id)
      expect(fact.refuting_evidence[0]).to eq evidence
    end
  end

  describe "#update_score" do
    it "verifies that 1 upvote for refuting evidence and 1 upvote for supporting evidence results in a fact
truthiness score of 50" do
      fact = create(:fact)
      evidence_1 = create(:evidence, support: true, fact_id: fact.id)
      evidence_2 = create(:evidence, support: false, fact_id: fact.id)
      vote_1 = create(:vote, upvote: true, evidence_id: evidence_1.id)
      vote_2 = create(:vote, upvote: true, evidence_id: evidence_2.id)
      fact.update_score
      expect(fact.score).to eq 50
    end
  end

end










