class OrganizationPolicy < ApplicationPolicy
  def show?
    user.memberships.exists?(organization: record)
  end

  def manage?
    user.memberships.exists?(organization: record, role: 'admin')
  end

  def create?
    user.present?
  end

  def update?
    manage?
  end

  def destroy?
    manage?
  end

  def analytics?
    show?
  end

  def export_members?
    manage?
  end
end 