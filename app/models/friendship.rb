class Friendship < ApplicationRecord
  belongs_to :expert_1, :class_name => "Expert", :foreign_key => "expert_1_id"
  belongs_to :expert_2, :class_name => "Expert", :foreign_key => "expert_2_id"

  validates :expert_1_id, :expert_2_id, presence: true
  validate  :no_identity_friendship

  def no_identity_friendship
    errors.add :expert_2, "can't be friends with themselves." if expert_1_id == expert_2_id
  end
end
