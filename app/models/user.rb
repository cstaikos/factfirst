class User < ActiveRecord::Base

  require 'digest/md5' # For generating gravatar hashes

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable,
         :registerable,
         :recoverable,
         :rememberable,
         :trackable,
         :validatable,
         :omniauthable, :omniauth_providers =>  [:google_oauth2, :facebook]

  has_many :facts
  has_many :evidences
  has_many :votes
  has_many :evidence_votes, through: :evidences, source: :votes
  has_and_belongs_to_many :favorites, class_name: 'Fact'

  validates :display_name, presence: true, uniqueness: true
  

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


  def self.find_for_oauth(access_token, signed_in_resource=nil)
    data = access_token.info
    user = User.where(:provider => access_token.provider, :uid => access_token.uid ).first
    if user
      return user
    else
      registered_user = User.where(:email => access_token.info.email).first
      if registered_user
        return registered_user
      else
        user = User.create(display_name: data["name"],
                           provider:access_token.provider,
                           email: data["email"],
                           uid: access_token.uid ,
                           password: Devise.friendly_token[0,20],
        )
      end
    end
  end

  # Added for facebook oauth
  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
      user.display_name = auth.info.name   # assuming the user model has a name
      # user.image = auth.info.image # assuming the user model has an image
    end
  end

  #Add for facebook oauth
  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
        user.email = data["email"] if user.email.blank?
      end
    end
  end


end
