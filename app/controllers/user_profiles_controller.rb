# encoding: utf-8
class UserProfilesController < ApplicationController

  def create
    @profile = UserProfile.create user_params
    if @profile.save
      @author = Author.create!(profile: @profile, name: @profile.email[/[^@]+/].gsub(".", " ").gsub("_", " ").titleize) 
      sign_in @author
      redirect_to authors_raspas_path(@author.username)
    else
      render 'authors/new'
    end
  end

  def edit
    @profile = UserProfile.find(params[:id])
  end

  def update
    @profile = UserProfile.find(params[:id])
    if @profile.update_attributes(user_params)
      flash[:success] = "atualizado"
      redirect_to authors_raspas_path(current_user.username)
    else
      render 'authors/edit'
    end
  end

  def destroy
    UserProfile.find(params[:id]).destroy
    flash[:success] = "Obrigado por honrar-nos com suas raspas! Até logo."
    redirect_to root_path
  end

  private

  def user_params
    params.require(:user_profile).permit(:email, :password, author_attributes: [:id, :name, :username, :dob, :has_jobs, :social, :website, :bio])
  end

end
