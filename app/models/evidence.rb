class Evidence < ActiveRecord::Base
  belongs_to :user
  belongs_to :fact
  has_many :votes

  def upvotes
    votes.where(upvote: true).count
  end

  def downvotes
    votes.where(upvote: false).count
  end
end
