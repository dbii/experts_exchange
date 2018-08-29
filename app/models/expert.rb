require 'open-uri'

class Expert < ApplicationRecord

  has_many :topics

  validates :name, presence: true, uniqueness: true
  validates :url, presence: true

  after_validation :generate_short_url
  after_create :get_topics

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

  def friends
    Friendship.where(expert_1_id: id).map{|f| f.expert_2} + Friendship.where(expert_2_id: id).map{|f| f.expert_1}
  end

  def topic_experts(a_topic)
    friend_ids = [11,12,13,1]
    Topic.includes(:expert).where("content ilike ?", "%#{a_topic}%").where.not("experts.id": id).where.not("experts.id": friend_ids).map{|t| t.expert }
  end

end
