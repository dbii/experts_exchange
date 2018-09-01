require 'rails_helper'

RSpec.describe Expert, type: :model do
  context "expert" do

    it "should allow creation" do
      expert = build(:expert)
      expect(expert).to be_valid
    end

    it "should not allow creation without name" do
      expert = build(:expert, name: '')
      expect(expert).not_to be_valid
    end

    it "should not allow creation without url" do
      expert = build(:expert, url: '')
      expect(expert).not_to be_valid
    end

    it "should handle invalid urls" do
      expert = build(:expert, url: 'wombat sox')
      expect(expert).not_to be_valid
    end
  end

  context "when finding a path to a friend" do

    let!(:expert_1) { create :expert }
    let!(:expert_2) { create :expert }
    let!(:expert_3) { create :expert }
    let!(:expert_4) { create :expert }

    let!(:friendship_1_2) { create :friendship, expert_1_id: expert_1.id, expert_2_id: expert_2.id }
    let!(:friendship_2_3) { create :friendship, expert_1_id: expert_2.id, expert_2_id: expert_3.id }
    let!(:friendship_3_4) { create :friendship, expert_1_id: expert_3.id, expert_2_id: expert_4.id }

    it "should find the identity path" do
      expect(expert_1.path_to_expert(expert_1)).to eq([expert_1])
    end

    it "should find a one-step path" do
      expect(expert_1.path_to_expert(expert_2)).to eq([expert_1, expert_2])
    end

    it "should find a two-step path" do
      expect(expert_1.path_to_expert(expert_3)).to eq([expert_1, expert_2, expert_3])
    end

    it "should find a three-step path" do
      expect(expert_1.path_to_expert(expert_4)).to eq([expert_1, expert_2, expert_3, expert_4])
    end

    context "with a cycle in friendships" do

      let!(:friendship_3_1) { create :friendship, expert_1_id: expert_3.id, expert_2_id: expert_1.id }

      it "should find the shortest path without getting lost in the circle" do
        expect(expert_1.path_to_expert(expert_4)).to eq([expert_1, expert_3, expert_4])
      end
    end

    context "with an unreachable expert" do

      let!(:expert_5) { create :expert }

      it "should not find a path" do
        expect(expert_1.path_to_expert(expert_5)).to be_falsey
      end
    end
  end
end
