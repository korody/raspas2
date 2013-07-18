# encoding: utf-8
class SessionsController < ApplicationController

  layout 'raspas_sidebar'

  def new
  end

  def create
    author = Author.find_by(email: params[:email])
    if author && author.authenticate(params[:password])
      sign_in author
      redirect_to authors_raspas_path(author.username)
    else
      flash.now[:error] = "pera que deu pêra!"
      render 'new'
    end
  end

  def destroy
    sign_out
    redirect_to root_path
  end

end
