class ExpertsController < ApplicationController

  before_action :require_user, only: [:new, :create, :edit, :update, :friends, :add_friend, :remove_friend]
  before_action :get_expert, only: [:show, :edit, :update, :friends, :add_friend, :remove_friend, :search_experts]

  def index
    @experts = Expert.all
  end

  def show
    @friends = Friendship.where(expert_1_id: @expert.id, expert_2_id: params[:friend_id]).or(Friendship.where(expert_2_id: @expert.id, expert_1_id: params[:friend_id]))
  end

  def new
    @expert = Expert.new
  end

  def create
    @expert = Expert.create(expert_params)
    redirect_to @expert
  end

  def edit
  end

  def update
    @expert.update(expert_params)
    redirect_to @expert
  end

  def friends
    @experts = Expert.where.not(id: @expert.id)
  end

  def add_friend
    Friendship.create(expert_1_id: @expert.id, expert_2_id: params[:friend_id])
    redirect_to @expert
  end

  def remove_friend
    friendship = Friendship.where(expert_1_id: @expert.id, expert_2_id: params[:friend_id]).or(Friendship.where(expert_2_id: @expert.id, expert_1_id: params[:friend_id])).first
    if friendship
      friendship.destroy
    end
    redirect_to @expert
  end

  def search_experts
    @topic_experts = @expert.topic_experts(params[:q])
  end

  private

  def get_expert
    @expert = Expert.find(params[:id])
  end

  def expert_params
    params
        .fetch(:expert, {})
        .permit(
            :name,
            :url,
        )
  end
end
