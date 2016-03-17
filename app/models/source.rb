class Source < ActiveRecord::Base
  has_many :evidences

  after_create :get_wot

  require 'httparty'

  def get_wot
    response = HTTParty.get("http://api.mywot.com/0.4/public_link_json2?hosts=#{domain}/&key=#{ENV['wot_key']}")
    json = JSON.parse(response.body)

    scores = json[domain]['0']

    self.wot_trust = scores[0].to_i
    self.wot_confidence = scores[1].to_i
    self.save

  end

end
