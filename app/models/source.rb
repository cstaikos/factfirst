class Source < ActiveRecord::Base
  has_many :evidences

  after_create :set_defaults

  def set_defaults

  end

  def get_wot
    url = "http://api.mywot.com/0.4/public_link_json2?hosts=wired.com/&key=#{ENV['WOT_KEY']}"

  end

end
