class Fact < ActiveRecord::Base
  belongs_to :user
  belongs_to :category
  has_many :evidences, dependent: :destroy
  has_and_belongs_to_many :favorited_users, class_name: 'User'

  after_create :set_defaults

  validates :category, presence: true
  validates :body, presence: true

  require 'rmagick'

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

  def controversy_score
    (score - 50).abs
  end

  def update_score
    return if total_votes == 0

    vote_sums = evidences.inject(0) do |sum, evidence|

      # Calculate web of trust factor - results will be between
      # 1.2 (high trust and confidence)
      # 0.53 (low trust and high confidence)
      # where 1.0 = neutral = 70% trust at any confidence level
      # Based on evaluation found at https://www.mywot.com/wiki/API
      # To adjust the baseline, simply change out 70 for any number... be sure
      # to also adjust the default trust in source.rb if this is done.
      # (2/3 * 0.01) is a conversion factor to move trust percentage to the
      # same scale we are looking for, which is 0.53 <= factor <= 1.2
      wot_factor = 1.0 + ( ( (evidence.source.wot_trust.to_f - 70.0) * (2.0/3.0 * 0.01) * (evidence.source.wot_confidence.to_f / 100.0) ))

      # This is applied to downvotes - the result is that upvotes weigh more
      # when the trust is high, while downvotes weigh less.
      # Conversely, with a low trust score, upvotes weight less and downvotes more.
      reverse_wot_factor = 1 + (1 - wot_factor)


      sum += if evidence.support
               evidence.upvotes * wot_factor  # upvotes on supporting evidence are good for a fact
             else
               evidence.downvotes * reverse_wot_factor # downvotes on refuting evidence are good for a fact
             end
    end

    self.score = (vote_sums.to_f / total_votes.to_f * 100).round

    self.score = 100 if self.score > 100

    save

    update_image
  end


  def update_image

    canvas = Magick::ImageList.new('public/imagemagick/base.png')

    footer_drawer = Magick::Draw.new
    footer_drawer.pointsize = 18
    footer_drawer.gravity = Magick::CenterGravity
    footer_text = "Agree? Disagree? Join the conversation and change this image!\nVisit www.truthometer.co/facts/#{id} to get started"
    footer_drawer.annotate(canvas, 645,900,0,0,footer_text) {
      self.fill = 'white'
    }

    fact_body_drawer = Magick::Draw.new
    fact_body_drawer.pointsize = 34
    fact_body_drawer.gravity = Magick::ForgetGravity
    body_text = fit_text(self.body, 450)
    fact_body_drawer.annotate(canvas, 0,0,38,200, body_text) {
      self.fill = 'black'
    }

    score_drawer = Magick::Draw.new
    score_drawer.pointsize = 80
    score_drawer.gravity = Magick::CenterGravity
    score_drawer.annotate(canvas, 1067,375,0,0, self.score.to_s) {
      self.fill = 'white'
    }

    other_stats_drawer = Magick::Draw.new
    other_stats_drawer.pointsize = 18
    other_stats_drawer.gravity = Magick::ForgetGravity
    other_stats_text = "Score is based on #{total_votes} votes over #{evidences.count} pieces of evidence"
    other_stats_drawer.annotate(canvas, 0,0,42,380, other_stats_text) {
      self.fill = 'black'
    }

    canvas.write("public/imagemagick/fact_photos/#{self.id}.png")

  end

  # Checks if text fits within certain width
  def text_fit?(text, width)
    tmp_image = Magick::Image.new(width, 500)
    drawing = Magick::Draw.new
    drawing.annotate(tmp_image, 0, 0, 0, 0, text) { |txt|
      txt.gravity = Magick::NorthGravity
      txt.pointsize = 34
      txt.fill = "#ffffff"
      txt.font_family = 'helvetica'
      txt.font_weight = Magick::BoldWeight
    }
    metrics = drawing.get_multiline_type_metrics(tmp_image, text)
    (metrics.width < width)
  end

  # Adds line breaks to text to simulate word wrap
  def fit_text(text, width)
    separator = ' '
    line = ''

    if not text_fit?(text, width) and text.include? separator
      i = 0
      text.split(separator).each do |word|
        if i == 0
          tmp_line = line + word
        else
          tmp_line = line + separator + word
        end

        if text_fit?(tmp_line, width)
          unless i == 0
            line += separator
          end
          line += word
        else
          unless i == 0
            line +=  '\n'
          end
          line += word
        end
        i += 1
      end
      text = line
    end
    text
  end


end
