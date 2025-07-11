class MembershipsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_organization
  before_action :set_membership, only: [:update, :destroy]

  def index
    @memberships = @organization.memberships.includes(:user)
    authorize @organization, :show?
  end

  def create
    authorize @organization, :manage?
    user = User.find_by(email: params[:email])
    if user && !@organization.users.include?(user)
      @organization.memberships.create(user: user, role: :member)
      redirect_to organization_memberships_path(@organization), notice: 'Member added.'
    else
      redirect_to organization_memberships_path(@organization), alert: 'User not found or already a member.'
    end
  end

  def update
    authorize @organization, :manage?
    if @membership.update(role: params[:role])
      redirect_to organization_memberships_path(@organization), notice: 'Role updated.'
    else
      redirect_to organization_memberships_path(@organization), alert: 'Could not update role.'
    end
  end

  def destroy
    authorize @organization, :manage?
    @membership.destroy
    redirect_to organization_memberships_path(@organization), notice: 'Member removed.'
  end

  private

  def set_organization
    @organization = Organization.find(params[:organization_id])
  end

  def set_membership
    @membership = @organization.memberships.find(params[:id])
  end
end
