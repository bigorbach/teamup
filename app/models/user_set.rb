class UserSet < ApplicationRecord
  BALANCE =[
    [false, "Randomized"],
    [true, "Balanced"]
  ]

  validates :topic, uniqueness: true
  validates :skill, presence: true
  validates :team_size, presence: true
  validates :team_size, numericality: true
  validates :balance, inclusion: { in: [true, false] }

  has_many :members

end
