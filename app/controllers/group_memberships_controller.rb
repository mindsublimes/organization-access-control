class GroupMembershipsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_group
  before_action :set_group_membership, only: [:update, :destroy]

  def index
    @group_memberships = @group.group_memberships.includes(:user)
  end

  def create
    user = User.find_by(email: params[:email])
    if user && !@group.users.include?(user)
      @group.group_memberships.create(user: user, role: :member)
      redirect_to group_group_memberships_path(@group), notice: 'Member added.'
    else
      redirect_to group_group_memberships_path(@group), alert: 'User not found or already a member.'
    end
  end

  def update
    if @group_membership.update(role: params[:role])
      redirect_to group_group_memberships_path(@group), notice: 'Role updated.'
    else
      redirect_to group_group_memberships_path(@group), alert: 'Could not update role.'
    end
  end

  def destroy
    @group_membership.destroy
    redirect_to group_group_memberships_path(@group), notice: 'Member removed.'
  end

  private

  def set_group
    @group = Group.find(params[:group_id])
  end

  def set_group_membership
    @group_membership = @group.group_memberships.find(params[:id])
  end
end
