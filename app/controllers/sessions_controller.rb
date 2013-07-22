# encoding: utf-8
class SessionsController < ApplicationController

  layout 'raspas_sidebar'

  def new
  end

  def create
    user = UserProfile.find_by(email: params[:email])
    author = user.author if user
    if author && user.authenticate(params[:password])
      sign_in author
      redirect_to authors_raspas_path(author.username)
    else
      flash.now[:error] = "pera que deu pêra!"
      render 'new'
    end
  end
  # REVISE create method

  def destroy
    sign_out
    redirect_to root_path
  end

end
