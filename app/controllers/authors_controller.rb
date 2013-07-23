# encoding: utf-8
class AuthorsController < ApplicationController
  
  layout 'authors_sidebar', except: [:new, :edit, :update]

  def index
    @authors = Author.all(order: :name)
  end

  def show
    @author = Author.where(username: params[:username]).first
    @raspas = @author.raspas
  end

  def feed
    @author = Author.where(username: params[:username]).first
    @wall = @author.wall
  end

  def new
    @profile = UserProfile.new
  end

  def create
    @author = Author.create(author_params)
  end

  def edit
    @author = Author.find(params[:id])
    @profile = @author.profile
  end

  # def update
  #   author = Author.find(params[:id])
  #   @profile = author.profile
  #   # @author.attributes = author_params
  #   # if @author.email.present? && @author.password_digest.present?
  #   #   @author.become_user
  #   # end
  #   if @profile.author.update_attributes(author_params)
  #     flash[:success] = "atualizado"
  #     redirect_to authors_raspas_path(current_user.username)
  #   else
  #     render 'edit'
  #   end
  # end

  private

  def author_params
    params.require(:author).permit(:name, :username, :bio, :has_jobs, :profile, :dob, :social, :website )
  end
end
