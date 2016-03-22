class Fact < ActiveRecord::Base
  belongs_to :user
  belongs_to :category
  has_many :evidences, dependent: :destroy
  has_and_belongs_to_many :favorited_users, class_name: 'User'
  has_many :votes, through: :evidences

  after_create :set_defaults

  validates :category, presence: true
  validates :body, presence: true

  require 'rmagick'
  require 'rvg/rvg'

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

      sum += if evidence.support
               evidence.upvotes * evidence.source.wot_factor.to_f  # upvotes on supporting evidence are good for a fact
             else
               evidence.downvotes * evidence.source.wot_factor.to_f # downvotes on refuting evidence are good for
               # a fact
             end
    end

    self.score = (vote_sums.to_f / total_votes.to_f * 100).round

    self.score = 100 if self.score > 100

    save

    update_image

    save
  end


  def update_image

    canvas = Magick::ImageList.new((Rails.env.production? ? "public/imagemagick/" : "app/assets/images/") + "base.png")

    footer_drawer = Magick::Draw.new
    footer_drawer.pointsize = 18
    footer_drawer.gravity = Magick::CenterGravity
    footer_text = "Based on #{total_votes} votes over #{evidences.count} pieces of evidence\n\nAgree? Disagree? Join the conversation and change this image!\nVisit www.truthometer.co/facts/#{id} to get started"
    footer_drawer.annotate(canvas, 645,865,0,0,footer_text) {
      self.fill = 'white'
    }

    fact_body_drawer = Magick::Draw.new
    fact_body_drawer.pointsize = 34
    fact_body_drawer.gravity = Magick::ForgetGravity
    body_text = fit_text(self.body, 375)
    fact_body_drawer.annotate(canvas, 0,0,300,150, body_text) {
      self.fill = 'black'
    }

    score_drawer = Magick::Draw.new
    score_drawer.pointsize = 50
    score_drawer.gravity = Magick::CenterGravity
    score_drawer.annotate(canvas, 290,600,0,0, self.score.to_s) {
      self.fill = 'black'
    }

    rvg = Magick::RVG.new(640, 480)
    needle = Magick::Image.read((Rails.env.production? ? "public/imagemagick/" : "app/assets/images/") + "needle.png").first
    rvg.image(needle)
    # 417

    rvg.rotate(-162, 146, 227) # 0%
    rvg.rotate( ( (self.score.to_f / 100) * 257), 146, 227)
    # rvg.rotate(257, 146, 227) # 100%
    needle = rvg.draw

    canvas.composite!(needle, 0, 0, Magick::OverCompositeOp)

    canvas.write((Rails.env.production? ? "public/imagemagick/fact_photos/" : "app/assets/images/fact_photos/") + "#{self.id}.png")

    if Rails.env.production?
      s3 = Aws::S3::Resource.new(region: 'us-east-1')
      file = "public/imagemagick/fact_photos/#{self.id}.png"
      bucket = "fact_photos"
      name = File.basename file
      obj = s3.bucket(bucket).object(name)

      if obj.upload_file(file)
        puts "Uploaded #{file} to bucket #{bucket}"
        self.photo_url = obj.public_url
      else
        puts "Could not upload #{file} to bucket #{bucket}!"
      end

    end

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
