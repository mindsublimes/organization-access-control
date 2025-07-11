class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :memberships
  has_many :organizations, through: :memberships
  has_many :group_memberships
  has_many :groups, through: :group_memberships

  validate :age_must_be_valid
  validate :parental_consent_for_minors

  def age
    return unless date_of_birth
    now = Time.zone.now.to_date
    now.year - date_of_birth.year - ((now.month > date_of_birth.month || (now.month == date_of_birth.month && now.day >= date_of_birth.day)) ? 0 : 1)
  end

  private

  def age_must_be_valid
    errors.add(:date_of_birth, "can't be in the future") if date_of_birth && date_of_birth > Date.today
  end

  def parental_consent_for_minors
    if date_of_birth && age && age < 18 && !parental_consent
      errors.add(:parental_consent, "is required for minors")
    end
  end
end
