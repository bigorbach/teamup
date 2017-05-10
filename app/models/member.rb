class Member < ApplicationRecord
  validates :skill_strength, numericality: true
  validates :name, presence: true

  # belongs_to :team
  belongs_to :user
  belongs_to :user_set
end
