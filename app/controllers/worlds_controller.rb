class WorldsController < ApplicationController
  before_action :authenticate_user!
  # before_action :validate_subscription

  def index
    render :index, locals: { worlds: current_user.worlds }
  end

  def new
    render :new, locals: { world: current_user.worlds.build }
  end

  def edit
    world = World.find_by(id: params[:id], user: current_user)
    render :edit, locals: { world: world }
  end

  def update
    world = World.find_by(id: params[:id], user: current_user)
    world.update(world_params) if params[:world].present?
    world.save!
    redirect_to worlds_path, notice: 'World updated'
  end

  def create
    world = World.new(world_params)
    world.user = current_user

    if world.save
      redirect_to worlds_path, notice: 'World saved'
    else
      render :new, locals: { world: world }
    end
  end

  def destroy
    world = World.find(params[:id])
    world.destroy
    redirect_to worlds_path, notice: 'World deleted'
  end

  private

  def world_params
    params.require(:world).permit(:name, :description, :rarity_modifier, :price_modifier)
  end
end
