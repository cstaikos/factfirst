class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :facts
  has_many :comments
  has_many :evidences
  has_many :votes

  # NOTE: This is a potential place where we could refactor for efficiency. Instead of iterating through all of a users' votes, we could check to see if a vote with id user exists for that piece of evidence.
  def already_voted?(evidence)
    votes.where(evidence_id: evidence.id).exists?
  end
end
