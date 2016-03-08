require 'rails_helper'

RSpec.describe Evidence, type: :model do


  describe "#upvotes" do
    context "when adding an upvote to evidence" do
      it "how many upvotes the peice of evidence has(should be 1 in this case)" do
        evidence = create(:evidence)
        create(:vote, upvote: true, evidence_id: evidence.id)
        expect(evidence.upvotes).to eq 1
      end
    end
  end

  describe "#downvotes" do
    context "when adding a downvote to evidence" do
      it "returns evidence downvotes count including the newly created downvote" do
        evidence = create(:evidence)
        create(:vote, upvote: false, evidence_id: evidence.id)
        expect(evidence.downvotes).to eq 1
      end
    end
  end

end

