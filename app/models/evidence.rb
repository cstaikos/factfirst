class Evidence < ActiveRecord::Base
  belongs_to :user
  belongs_to :fact
  has_many :votes

  validates :url, presence: true, uniqueness: { case_sensitive: false }
  validates_inclusion_of :support, in: [true, false]


  def upvotes
    votes.where(upvote: true).count
  end

  def downvotes
    votes.where(upvote: false).count
  end
end
