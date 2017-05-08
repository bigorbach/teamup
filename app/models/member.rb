class Member < ApplicationRecord
  validates :skill_strength, numericality: true

  # belongs_to :team
  belongs_to :user
end
