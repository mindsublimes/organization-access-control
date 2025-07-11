class GroupMembership < ApplicationRecord
  belongs_to :user
  belongs_to :group
  enum :role, { member: 'member', admin: 'admin' }, prefix: true, scopes: false, enum_type: :string
end
