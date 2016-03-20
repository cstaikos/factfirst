class Source < ActiveRecord::Base
  has_many :evidences

  after_create :get_wot

  require 'open_uri_redirections'
  require 'httparty'

  @@base_trust = 70

  # Use web of trust (wot) api to get trust and confidence scores for domain
  def get_wot
    response = HTTParty.get("http://api.mywot.com/0.4/public_link_json2?hosts=#{domain}/&key=#{ENV['wot_key']}")

    if response.code == 200
      json = JSON.parse(response.body)
      scores = json[domain]['0']
    end

    if scores
      self.wot_trust = scores[0].to_i
      self.wot_confidence = scores[1].to_i
    else
      # If no wot data is returned, give a baseline of 50% which will have a neutral effect
      self.wot_trust = @@base_trust
      self.wot_confidence = 100
    end

    # Calculate web of trust factor - results will be between
    # 1.2 (high trust and confidence)
    # 0.53 (low trust and high confidence)
    # where 1.0 = neutral = 70% trust at any confidence level
    # Based on evaluation found at https://www.mywot.com/wiki/API
    # (2/3 * 0.01) is a conversion factor to move trust percentage to the
    # same scale we are looking for, which is 0.53 <= factor <= 1.2
    self.wot_factor = 1.0 + ( ( (self.wot_trust.to_f - @@base_trust.to_f) * (2.0/3.0 * 0.01) * (self.wot_confidence.to_f / 100.0) ))


    self.save

  end

  def self.create_from_url(url)
    # Grab host
    host = URI(url).host

    # Check if host is a valid domain
    if PublicSuffix.valid?(host)
      domain = PublicSuffix.parse(host).domain

      # Check if source domain exists in DB - if it does, add association - if not, create it and add association
      existing_source = Source.where(domain: domain)

      if existing_source.count > 0
        source = existing_source.first
      else
        source = Source.create(domain: domain)
        source.save
      end

      return source

    else

      return false

    end

  end

end
