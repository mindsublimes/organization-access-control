class Organization < ApplicationRecord
  has_many :memberships
  has_many :users, through: :memberships

  # Optional: Age-based participation
  # attr_accessor :min_age, :max_age
end
