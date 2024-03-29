class PublicProfilesController < ApplicationController

  def create
    @profile = Author.create! { |u| u.profile = PublicProfile.create! }
    sign_in @profile
    redirect_to root_path
  end

  def edit
    @profile = PublicProfile.find(params[:id])
  end

  def update
    @profile = PublicProfile.find(params[:id])
    # @profile.update_attributes!(user_params)
    if @profile.update_attributes(public_params)
      flash[:success] = "atualizado"
      redirect_to authors_raspas_path(@profile.username)
    else
      render "authors/edit"
    end
  end

  private

  def public_params
    params.require(:public_profile).permit(:aka, :dod, author_attributes: [:id, :name, :username, :dob, :has_jobs, :social, :website, :bio])
  end

end
