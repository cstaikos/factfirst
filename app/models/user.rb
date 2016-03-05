class User < ActiveRecord::Base

  require 'digest/md5' # For generating gravatar hashes

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :facts
  has_many :comments
  has_many :evidences
  has_many :votes

  def already_voted?(evidence)
    votes.where(evidence_id: evidence.id).exists?
  end

  def gravatar_hash
    Digest::MD5.hexdigest(email)
  end

end
