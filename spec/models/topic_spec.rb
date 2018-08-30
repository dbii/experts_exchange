require 'rails_helper'

RSpec.describe Topic, type: :model do
  context "topic" do

    it "should allow creation" do
      topic = build(:topic)
      expect(topic).to be_valid
    end

    it "should not allow creation without expert_id" do
      topic = build(:topic, expert_id: nil)
      expect(topic).not_to be_valid
    end

    it "should not allow creation without tag" do
      topic = build(:topic, tag: "")
      expect(topic).not_to be_valid
    end

    it "should not allow creation without content" do
      topic = build(:topic, content: "")
      expect(topic).not_to be_valid
    end

  end
end
