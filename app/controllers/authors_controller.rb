# encoding: utf-8
class AuthorsController < ApplicationController
  respond_to :html, :json

  before_filter :authenticate, only: [:edit, :update, :destroy]
  before_filter :correct_user, only: [:edit, :update, :destroy, :feed]
  
  layout 'authors_sidebar', except: [:new, :edit, :update]

  def index
    @authors = Author.order(:name)
    author_list = @authors.where("name ilike ?", "%#{params[:q]}%").map {|a| {id: a.id, name: a.name} } 
    author_query = author_list.empty? ? [{id: "<<<#{params[:q]}>>>", name: "NOVO PENSADOR: \"#{params[:q]}\""}] : author_list
    respond_with(@author) do |format|
      format.json { render json: author_query }
    end
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
    @attachment = Attachment.new
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
    params.require(:author).permit(:name, :username, :bio, :profile, :dob, :social, :website)
  end

  def correct_user
    @author = Author.find(params[:id])
    unless @author.legend?
      redirect_to(root_path) unless current_user?(@author)
    end
  end

end
