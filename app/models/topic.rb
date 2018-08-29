class Topic < ApplicationRecord
  belongs_to :expert

  validates :expert_id, :tag, :content, presence: true

end
