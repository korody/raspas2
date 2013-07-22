class AuthorsController < ApplicationController
  
  layout 'authors_sidebar', except: [:new, :edit]

  def index
    @authors = Author.all(order: :name)
  end

  def show
    @author = Author.where(username: params[:username]).first
    @raspas = @author.raspas
    @wall = @author.wall
  end

  def new
    @user = UserProfile.create
  end

  def create
    @user = UserProfile.create
    # @author = UserProfile.create(user_params)
    # @user_profile = UserProfile.create!(email: @author.email)
    # @author.update_attributes(profile: @user_profile)
    # if @user.save
      # @author = @user.author.build(author_params) 
    #   sign_in @user
    #   redirect_to authors_raspas_path(@author.username)
    # else
    #   render 'new'
    # end
  end

  def edit
    @user = Author.find(params[:id])
  end

  def update
    @author = current_user
    @author.attributes = author_params
    # if @author.email.present? && @author.password_digest.present?
    #   @author.become_user
    # end
    if @author.update_attributes(author_params)
      flash[:success] = "atualizado"
      redirect_to authors_raspas_path(@author.username)
    else
      render 'edit'
    end
  end

  def destroy
    Author.find(params[:id]).destroy
    redirect_to root_path
  end

  private

  def author_params
    params.require(:author).permit(:name, :username, :bio, :has_job, :profile => :email )
  end
end
