require 'rails_helper'

RSpec.describe Fact, type: :model do


  let!(:fact) { create(:fact) }

  describe "#set_defaults" do
    context "when creating a new fact" do
      it "returns the expected default fact score value of 0" do
        expect(fact.score).to eq 0
      end
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
        fact.reload # This is necessary to make the test pass. Why?
        fact.update_score
        expect(fact.score).to eq 50
      end
    end
  end

end










