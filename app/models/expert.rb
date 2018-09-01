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
    if url.blank?
      errors.add :url, "can't be blank."
    else
      begin
        bitly = Bitly.new(ENV["SHORTENER_USERNAME"],ENV["SHORTENER_API_KEY"])
        response = bitly.shorten(url)
        self.short_url = response.short_url
      rescue BitlyError => e
        errors.add :url, e.message
      end
    end
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
    matching_topics.map{|t| t.expert }.each_with_object(Hash.new(0)) {|expert, counts| counts[expert] += 1}
  end

  # returns a path to the expert in the form of an array of experts, or false if the expert is unreachable
  def path_to_expert(target, path=[])
    path << self
    return path if target == self
    results = []
    friends.each do |friend|
      next if path.include?(friend)                     # been here before
      new_path = friend.path_to_expert(target, path.clone)
      results << new_path if new_path
    end
    return false if results.empty?                      # termination case
    return results.sort_by(&:length).first              # winner winner chicken dinner
  end
end
