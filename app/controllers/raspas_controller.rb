# encoding: utf-8
class RaspasController < ApplicationController
  before_action :authenticate, only: [:edit, :update, :create]
  # before_action :authorized_user, only: [:edit, :update, :destroy]

  layout 'raspas_sidebar'

  def index
    @raspas = Raspa.all(limit: 40)
    # @trending = Topic.trending
    # @presenter = Raspas::IndexPresenter.new(current_user)
  end

  def show
    @raspa = Raspa.find(params[:id])
    @commentable = @raspa
    @comments = @commentable.comments
    @comment = Comment.new
  end

  def new
    @new_raspa = Raspa.new
  end

  def create
    @new_raspa = current_user.raspas.build(raspa_params)
    unless @new_raspa.original_author.present?
      if @new_raspa.save
        flash.now[:success] = "Obrigado #{current_user.name}! Sua raspa foi criada."
        redirect_to authors_raspas_path(current_user.username)
      else
        render 'edit'
      end
    else
      @some_author = Author.where(name: @new_raspa.original_author).first_or_create(profile: PublicProfile.create!)
      @new_raspa.update_attributes(author_id: @some_author.id)
      if @new_raspa.save
        current_user.reaspas.create(raspa: @new_raspa)
        flash.now[:success] = "Você adicionou uma raspa de #{@some_author.name}! Obrigado!"
        redirect_to authors_raspas_path(@some_author.username)
      else
        render 'edit'
      end
    end
  end

  # REVISE for skinny controller

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
    params.require(:raspa).permit(:quote, :note, :author_id, :original_author, :tag_tokens, :origin_name)
  end

  def authorized_user
    @raspa = current_user.raspas.find_by_id(params[:id])
    redirect_to root_path if @raspa.nil?
  end

end
