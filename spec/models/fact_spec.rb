require 'rails_helper'
# require 'spec_helper'

RSpec.describe Fact, type: :model do

  before(:each) do
    @fact = create(:fact)
  end


  it "has a default score of 0 " do
    expect(@fact.score).to eq 0
  end




  # it "has been created properly" do
  #   expect(@fact.body).to eq "Test Fact"
  # end

end








# it "creates a new fact" do
#   user = User.create
#   fact = Fact.create
#   expect(fact.user_id).to eq(user.id)
# end

