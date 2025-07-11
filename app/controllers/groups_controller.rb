class GroupsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_group, only: [:show, :edit, :update, :destroy, :join, :leave]

  def index
    @groups = Group.all.select do |group|
      (group.min_age.nil? || current_user.age >= group.min_age) &&
      (group.max_age.nil? || current_user.age <= group.max_age)
    end
  end

  def show
    @members = @group.group_memberships.includes(:user)
  end

  def new
    @group = Group.new
  end

  def create
    @group = Group.new(group_params)
    if @group.save
      GroupMembership.create(user: current_user, group: @group, role: :admin)
      redirect_to @group, notice: 'Group created.'
    else
      render :new
    end
  end

  def edit; end

  def update
    if @group.update(group_params)
      redirect_to @group, notice: 'Group updated.'
    else
      render :edit
    end
  end

  def destroy
    @group.destroy
    redirect_to groups_path, notice: 'Group deleted.'
  end

  def join
    unless @group.users.include?(current_user)
      @group.group_memberships.create(user: current_user, role: :member)
    end
    redirect_to @group, notice: 'Joined group.'
  end

  def leave
    membership = @group.group_memberships.find_by(user: current_user)
    membership&.destroy
    redirect_to groups_path, notice: 'Left group.'
  end

  private

  def set_group
    @group = Group.find(params[:id])
  end

  def group_params
    params.require(:group).permit(:name, :min_age, :max_age)
  end
end
