class Source < ActiveRecord::Base
  has_many :evidences

  after_create :get_wot

  require 'httparty'

  # Use web of trust (wot) api to get trust and confidence scores for domain
  def get_wot
    response = HTTParty.get("http://api.mywot.com/0.4/public_link_json2?hosts=#{domain}/&key=#{ENV['wot_key']}")
    json = JSON.parse(response.body)

    scores = json[domain]['0']
    if scores
      self.wot_trust = scores[0].to_i
      self.wot_confidence = scores[1].to_i
    else
      # If no wot data is returned, give a baseline of 50% which will have a neutral effect
      self.wot_trust = 50
      self.wot_confidence = 100
    end
    self.save

  end

end
