class PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_group
  before_action :set_post, only: [:show, :edit, :update, :destroy]

  def index
    @posts = @group.posts.where('(min_age IS NULL OR min_age <= ?) AND (max_age IS NULL OR max_age >= ?)', current_user.age, current_user.age)
  end

  def show
    unless (@post.min_age.nil? || current_user.age >= @post.min_age) && (@post.max_age.nil? || current_user.age <= @post.max_age)
      redirect_to group_posts_path(@group), alert: 'You are not allowed to view this post.'
    end
  end

  def new
    @post = @group.posts.new
  end

  def create
    @post = @group.posts.new(post_params)
    @post.user = current_user
    if @post.save
      redirect_to [@group, @post], notice: 'Post created.'
    else
      render :new
    end
  end

  def edit; end

  def update
    if @post.update(post_params)
      redirect_to [@group, @post], notice: 'Post updated.'
    else
      render :edit
    end
  end

  def destroy
    @post.destroy
    redirect_to group_posts_path(@group), notice: 'Post deleted.'
  end

  private

  def set_group
    @group = Group.find(params[:group_id])
  end

  def set_post
    @post = @group.posts.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :body, :min_age, :max_age)
  end
end
