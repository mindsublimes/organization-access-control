class Membership < ApplicationRecord
  belongs_to :user
  belongs_to :organization

  enum :role, { member: 'member', admin: 'admin' }, prefix: true, scopes: false, enum_type: :string
end
