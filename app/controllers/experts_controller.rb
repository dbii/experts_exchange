class ExpertsController < ApplicationController

  before_action :require_user

  def index
    @experts = Expert.all
  end

  def show
    @expert = Expert.find(params[:id])
  end

  def new
    @expert = Expert.new
  end

  def create
    Expert.create(expert_params)
    redirect_to @expert
  end

  def edit
    @expert = Expert.find(params[:id])
  end

  def update
    @expert = Expert.find(params[:id])
    @expert.update(expert_params)
    redirect_to @expert
  end

  private

  def expert_params
    params
        .fetch(:expert, {})
        .permit(
            :name,
            :url,
        )
  end
end
