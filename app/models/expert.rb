require 'open-uri'

class Expert < ApplicationRecord

  has_many :topics

  validates :name, presence: true, uniqueness: true
  validates :url, presence: true

  after_create :get_topics
  after_create :generate_short_url

  def get_topics
    page = Nokogiri::HTML(open(url))

    page.css('h1').each do |element|
      content = element.content
      next if content.blank?
      topics.create(tag: 'h1', content: content)
    end
    page.css('h2').each do |element|
      content = element.content
      next if content.blank?
      topics.create(tag: 'h3', content: content)
    end
    page.css('h3').each do |element|
      content = element.content
      next if content.blank?
      topics.create(tag: 'h3', content: content)
    end
  end

  def generate_short_url
    bitly = Bitly.new(ENV["SHORTENER_USERNAME"],ENV["SHORTENER_API_KEY"])
    response = bitly.shorten(url)
    self.short_url = response.short_url
  end
end
