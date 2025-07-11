require 'csv'

class OrganizationsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_organization, only: [:show, :edit, :update, :destroy, :analytics, :export_members]

  def index
    @organizations = Organization.all
    # For analytics demo: count members
    @analytics = @organizations.map { |org| [org, org.memberships.count] }.to_h
  end

  def show
    authorize @organization
    @members = @organization.memberships.includes(:user)
  end

  def new
    @organization = Organization.new
    authorize @organization
  end

  def create
    @organization = Organization.new(organization_params)
    authorize @organization
    if @organization.save
      Membership.create(user: current_user, organization: @organization, role: :admin)
      redirect_to @organization, notice: 'Organization created.'
    else
      render :new
    end
  end

  def edit
    authorize @organization
  end

  def update
    authorize @organization
    if @organization.update(organization_params)
      redirect_to @organization, notice: 'Organization updated.'
    else
      render :edit
    end
  end

  def destroy
    authorize @organization
    @organization.destroy
    redirect_to organizations_path, notice: 'Organization deleted.'
  end

  def analytics
    authorize @organization
    @member_count = @organization.memberships.count
    @recent_members = @organization.memberships.order(created_at: :desc).limit(10)
    @recent_activities = @organization.memberships.order(updated_at: :desc).limit(10)
    # For demo: member count over time (last 7 days)
    @member_growth = (0..6).map do |days_ago|
      [days_ago.days.ago.to_date, @organization.memberships.where('created_at <= ?', days_ago.days.ago.end_of_day).count]
    end.reverse
  end

  def export_members
    authorize @organization
    members = @organization.memberships.includes(:user)
    csv = CSV.generate(headers: true) do |csv|
      csv << ["Email", "Role", "Joined At"]
      members.each do |m|
        csv << [m.user.email, m.role, m.created_at]
      end
    end
    send_data csv, filename: "organization-#{@organization.id}-members.csv"
  end

  private

  def set_organization
    @organization = Organization.find(params[:id])
  end

  def organization_params
    params.require(:organization).permit(:name, :min_age, :max_age)
  end
end
