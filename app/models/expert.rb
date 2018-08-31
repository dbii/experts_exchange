require 'open-uri'

class Expert < ApplicationRecord

  has_many :topics

  validates :name, presence: true, uniqueness: true
  validates :url, presence: true

  after_validation :generate_short_url
  after_create :get_topics

  UNDESIRED_CONTENT = ['more', 'view', 'search', 'contents']

  def get_topics
    page = Nokogiri::HTML(open(url))

    page.css('h1').each do |element|
      content = element.content
      next if content.blank? || UNDESIRED_CONTENT.include?(content.downcase)
      topics.create(tag: 'h1', content: content)
    end
    page.css('h2').each do |element|
      content = element.content
      next if content.blank? || UNDESIRED_CONTENT.include?(content.downcase)
      topics.create(tag: 'h3', content: content)
    end
    page.css('h3').each do |element|
      content = element.content
      next if content.blank? || UNDESIRED_CONTENT.include?(content.downcase)
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
    word_atoms = a_topic.split
    friend_ids = Friendship.where(expert_1_id: id).map{|f| f.expert_2_id} + Friendship.where(expert_2_id: id).map{|f| f.expert_1_id}
    matching_topics = Topic.includes(:expert).where.not("experts.id": id).where.not("experts.id": friend_ids)
    word_atoms.each do |atom|
      matching_topics = matching_topics.where("content ilike ?", "%#{atom}%")
    end
    matching_topics.map{|t| t.expert }
  end

end
