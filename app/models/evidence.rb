class Evidence < ActiveRecord::Base
  belongs_to :user
  belongs_to :fact
  belongs_to :source
  has_many :votes


  validates :url, presence: true
  # validates_inclusion_of :support, in: [true, false]

  require 'open_uri_redirections'

  def upvotes
    votes.where(upvote: true).count
  end

  def downvotes
    votes.where(upvote: false).count
  end

  # Grab metadata from evidence url - 5 second limit on request, otherwise save empty title/description
  def grab_metadata
    begin

      timeout(5) do
        begin
          doc = Nokogiri::HTML(open(self.url, allow_redirections: :safe))

          og_title = doc.css("meta[property='og:title']")
          og_description = doc.css("meta[property='og:description']")

          self.title = og_title.first.attributes["content"] if og_title.length > 0
          self.description = og_description.first.attributes["content"] if og_description.length > 0
        rescue Exception
        end


      end

    rescue Timeout::Error
      puts 'Timeout error'
    end

  end

  def already_used_for_fact?(fact)
    if fact.evidences.where(fact_id: fact.id, url: self.url) != []
        return true
      end
    end
  end
