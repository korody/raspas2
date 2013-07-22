class UserProfilesController < ApplicationController

  def create
    @user = UserProfile.create user_params
    if @user.save
      @author = Author.create(profile: @user, name: @user.email[/[^@]+/].gsub(".", " ").gsub("_", " ").titleize) 
      sign_in @author
      redirect_to authors_raspas_path(@author.username)
    else
      render 'authors/new'
    end
  end

  private

  def user_params
    params.require(:user_profile).permit(:email, :password)
  end

end
