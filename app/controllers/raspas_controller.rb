# encoding: utf-8
class RaspasController < ApplicationController
  before_action :authenticate, only: [:edit, :update, :create]
  before_action :authorized_user, only: [:edit, :update, :destroy]

  layout 'raspas_sidebar'

  def index
    @raspas = Raspa.all(limit: 40)
    # @trending = Topic.trending
    # @presenter = Raspas::IndexPresenter.new(current_user)
  end

  def show
    @raspa = Raspa.find(params[:id])
  end

  def new
    @new_raspa = Raspa.new
  end

  def create
    @new_raspa = current_user.raspas.build(raspa_params)
    if @new_raspa.save
      flash.now[:success] = "Obrigado #{current_user.name}! Sua raspa foi criada."
      redirect_to root_path
    else
      render 'edit'
    end
    # @new_raspa = Raspa.create(raspa_params)
    # some_user = @new_raspa.from_user.present? ? User.where(name: @new_raspa.from_user).first_or_create! : User.find(3) 
    # if @new_raspa.valid?
    #   if some_user.guest?
    #     sign_in(some_user)
    #     redirect_to root_path
    #   else
    #     redirect_to signin_path, notice: "Olá #{some_user.name}! É você mesmo?"
    #   end
    #   @new_raspa.assign_user
    #   @new_raspa.save
    # else
    #   render 'edit'
    # end
  end

  def edit
    @new_raspa = Raspa.find(params[:id])
  end

  def update
    @raspa = Raspa.find(params[:id])
    @raspa.update_attributes! raspa_params
    redirect_to @raspa
  end

  def destroy
    current_user.raspas.find(params[:id]).destroy
    flash[:notice] = "destroyed!"
    redirect_to authors_raspas_path(current_user.username)
  end

  private

  def raspa_params
    params.require(:raspa).permit(:quote, :note, :author_id)
  end

  def authorized_user
    @raspa = current_user.raspas.find_by_id(params[:id])
    redirect_to root_path if @raspa.nil?
  end

end
