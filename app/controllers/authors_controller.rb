class AuthorsController < ApplicationController
  
  layout 'authors_sidebar'

  def index
    @authors = Author.all(order: :name)
  end

  def show
    @author = Author.where(username: params[:username]).first
    @wall = @author.wall
  end

  def new
    @author = Author.new
  end

  def create
    @author = Author.new(author_params)
    if @author.save
      sign_in @author
      redirect_to authors_raspas_path(@author.username)
    else
      render 'new'
    end
  end

  def edit
      @author = Author.find(params[:id])
    end

    def update
      @author = current_user
      @author.attributes = author_params
      if @author.email.present? && @author.password_digest.present?
        @author.update_attributes(claimed: 'TRUE')
      end
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
      params.require(:author).permit(:name, :email, :password, :username, :bio, :has_job, :claimed)
    end
end
