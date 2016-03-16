class Evidence < ActiveRecord::Base
  belongs_to :user
  belongs_to :fact
  belongs_to :source
  has_many :votes

  validates :url, presence: true
  validates_inclusion_of :support, in: [true, false]


  def upvotes
    votes.where(upvote: true).count
  end

  def downvotes
    votes.where(upvote: false).count
  end
end
