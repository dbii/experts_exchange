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
end
