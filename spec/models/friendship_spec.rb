require 'rails_helper'

RSpec.describe Friendship, type: :model do

  let(:expert_1) { create :expert }
  let(:expert_2) { create :expert }
  let(:valid_attributes) { { expert_1_id: expert_1.id, expert_2_id: expert_2.id } }

  context "when creating a friendship" do
    it "is valid with expected valid attributes" do
      expect(Friendship.new(valid_attributes)).to be_valid
    end

    it "requires expert 1" do
      expect(Friendship.new(valid_attributes.merge(expert_1_id: nil))).not_to be_valid
    end

    it "requires expert 2" do
      expect(Friendship.new(valid_attributes.merge(expert_2_id: nil))).not_to be_valid
    end
  end
end
