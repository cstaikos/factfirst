require 'rails_helper'
# require 'spec_helper'

RSpec.describe Fact, type: :model do
  before(:each) do
    @fact = FactoryGirl.create(:fact)
  end

  it "body equal to body" do
    expect(@fact.body).to eq "This is a random fact!"
  end

  it "score equal to score" do
    expect(@fact.score).to eq 5
  end

  it "user_id equal to user_id" do
    expect(@fact.user_id).to eq 1
  end

  # it "has a valid factory" do
  #   FactoryGirl.create(:fact).should be_valid
  # end

end








# it "creates a new fact" do
#   user = User.create
#   fact = Fact.create
#   expect(fact.user_id).to eq(user.id)
# end

