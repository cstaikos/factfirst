require 'rails_helper'

RSpec.describe Fact, type: :model do


  let!(:fact) { create(:fact) }

  after(:all) do
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
      expect(fact.score).to eq 0
    end
  end

  describe "#supporting_evidence" do
    context "when adding supporting evidence to fact" do
      it "returns the created supporting evidence" do
        evidence = create(:supporting_evidence, fact_id: fact.id)
        expect(fact.supporting_evidence.first).to eq evidence
      end
    end
  end

  describe "#refuting_evidence" do
    context "when adding refuting evidence to fact" do
      it "returns the created refuting evidence" do
        evidence = create(:refuting_evidence, fact_id: fact.id)
        expect(fact.refuting_evidence[0]).to eq evidence
      end
    end
  end

  describe "#update_score" do
    context "when there are equal upvotes for supporting and refuting evidence" do
      it "returns a fact score of 50" do
        evidence_1 = create(:evidence, support: true, fact_id: fact.id)
        evidence_2 = create(:evidence, support: false, fact_id: fact.id)
        vote_1 = create(:vote, upvote: true, evidence_id: evidence_1.id)
        vote_2 = create(:vote, upvote: true, evidence_id: evidence_2.id)
        fact.update_score
        expect(fact.score).to eq 50
      end
    end
  end

end










