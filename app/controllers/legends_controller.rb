class LegendsController < ApplicationController

  def create
    @legend = Author.create! { |u| u.profile = PublicProfile.create! }
    sign_in @legend
    redirect_to root_path
  end

end
