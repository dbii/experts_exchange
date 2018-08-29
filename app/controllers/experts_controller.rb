class ExpertsController < ApplicationController

  #before_action :require_user, only: [:new, :create, :edit, :update, :friends, :add_friend, :remove_friend]
  before_action :get_expert, only: [:show, :edit, :update, :friends, :add_friend]

  def index
    @experts = Expert.all
  end

  def show
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

  end

  def remove_friend

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
