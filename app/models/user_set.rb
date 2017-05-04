class UserSet < ApplicationRecord

  validates :topic, uniqueness: true
  validates :team_size, presence: true
  validates :team_size, numericality: true

  has_many :members

end
