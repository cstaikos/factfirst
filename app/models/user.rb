class User < ActiveRecord::Base

  require 'digest/md5' # For generating gravatar hashes

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,  :omniauthable, :omniauth_providers => [:google]

  has_many :facts
  has_many :evidences
  has_many :votes
  has_many :evidence_votes, through: :evidences, source: :votes
  has_and_belongs_to_many :favorites, class_name: 'Fact'

  validates :display_name, presence: true

  def already_voted?(evidence)
    votes.where(evidence_id: evidence.id).exists?
  end

  def gravatar_hash
    Digest::MD5.hexdigest(email)
  end

  def evidence_quality
    upvote_total = evidence_votes.inject(0) { |sum, vote| sum += (vote.upvote ? 1 : 0) }
    ((upvote_total.to_f / evidence_votes.count) * 100).round(2)
  end

end
