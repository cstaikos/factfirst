class Fact < ActiveRecord::Base
  belongs_to :user
  belongs_to :category
  has_many :evidences
  has_many :comments
  has_and_belongs_to_many :favorited_users, class_name: 'User'

  accepts_nested_attributes_for :evidences, reject_if: :all_blank, allow_destroy: true

  after_create :set_defaults

  validates :category, presence: true
  validates :body, presence: true

   require 'RMagick'

  def set_defaults
    self.score = 0
    save
    update_image
  end

  def supporting_evidence
    evidences.where(support: true)
  end

  def refuting_evidence
    evidences.where(support: false)
  end

  def total_votes
    evidences.inject(0) do |sum, evidence|
      sum += evidence.upvotes + evidence.downvotes
    end
  end

  def update_score
    return if total_votes == 0

    vote_sums = evidences.inject(0) do |sum, evidence|
      sum += if evidence.support
               evidence.upvotes # upvotes on supporting evidence are good for a fact
             else
               evidence.downvotes # downvotes on refuting evidence are good for a fact
             end
    end

    self.score = (vote_sums.to_f / total_votes.to_f * 100).round

    save

    update_image
  end


  def update_image

    canvas = Magick::ImageList.new('app/assets/images/base.gif')

    drawer = Magick::Draw.new

    drawer.font_family = 'helvetica'
    drawer.pointsize = 22
    drawer.gravity = Magick::CenterGravity

    drawer.annotate(canvas, 0,0,0,0, self.body) {
      self.fill = 'darkred'
    }

    drawer.annotate(canvas, 50,50,0,0, self.score.to_s) {
      self.fill = 'darkred'
    }

    canvas.write("app/assets/images/fact_photos/#{self.id}.png")

  end


end
