class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :facts
  has_many :comments
  has_many :evidences
  has_many :votes

  def already_voted?(evidence)
    votes.each do |vote|
      return true if vote.evidence_id == evidence.id
    end
    false
  end
end
