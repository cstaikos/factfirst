require 'rails_helper'

RSpec.describe User, type: :model do

  let!(:user) { create(:user) }

  describe "#evidence_quality" do
    context "when a user has equal upvotes and downvotes on submitted evidence" do
      it "returns an evidence quality of 50" do
        evidence_1 = create(:evidence, user_id: user.id)
        evidence_2 = create(:evidence, user_id: user.id)
        vote_1 = create_list(:vote, 5, upvote: true, evidence_id: evidence_1.id)
        vote_2 = create_list(:vote, 5, upvote: false, evidence_id: evidence_2.id)
        user.reload
        expect(user.evidence_quality).to eq 50
      end
    end

    context "when a user has twice as many upvotes as downvotes on submitted evidence" do
      it "returns an evidence quality of 66.6666" do
        evidence_1 = create(:evidence, user_id: user.id)
        evidence_2 = create(:evidence, user_id: user.id)
        vote_1 = create_list(:vote, 10, upvote: true, evidence_id: evidence_1.id)
        vote_2 = create_list(:vote, 5, upvote: false, evidence_id: evidence_2.id)
        user.reload
        expect(user.evidence_quality).to eq 66.6666.round(2)
      end
    end

    context "when a user has twice as many downvotes as upvtes on submitted evidence" do
      it "returns an evidence quality of 33.3333" do
        evidence_1 = create(:evidence, user_id: user.id)
        evidence_2 = create(:evidence, user_id: user.id)
        vote_1 = create_list(:vote, 5, upvote: true, evidence_id: evidence_1.id)
        vote_2 = create_list(:vote, 10, upvote: false, evidence_id: evidence_2.id)
        user.reload
        expect(user.evidence_quality).to eq 33.3333.round(2)
      end
    end

    context "when a user has only upvotes on submitted evidence" do
      it "returns an evidence quality of 100" do
        evidence_1 = create(:evidence, user_id: user.id)
        evidence_2 = create(:evidence, user_id: user.id)
        vote_1 = create_list(:vote, 5, upvote: true, evidence_id: evidence_1.id)
        vote_2 = create_list(:vote, 5, upvote: true, evidence_id: evidence_2.id)
        user.reload
        expect(user.evidence_quality).to eq 100
      end
    end

    context "when a user has only downvotes on submitted evidence" do
      it "returns an evidence quality of 0" do
        evidence_1 = create(:evidence, user_id: user.id)
        evidence_2 = create(:evidence, user_id: user.id)
        vote_1 = create_list(:vote, 5, upvote: false, evidence_id: evidence_1.id)
        vote_2 = create_list(:vote, 5, upvote: false, evidence_id: evidence_2.id)
        user.reload
        expect(user.evidence_quality).to eq 0
      end
    end

  end

end
