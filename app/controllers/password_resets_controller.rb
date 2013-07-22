# encoding: utf-8
class PasswordResetsController < ApplicationController

  def new    
  end

  def create
    user = UserProfile.find_by_email(params[:email])
    if user 
      user.send_password_reset
      flash[:success] = "Enviamos instruções para seu e-mail."
      redirect_to signin_path
    else
      flash[:notice] = "Não esqueceu de nada?"
      render :new
    end
  end

  def edit
    @user = UserProfile.find_by_reset_token!(params[:id])
  end

  def update
    @user = UserProfile.find_by_reset_token!(params[:id])
    if @user.reset_token_sent_at < 2.hours.ago
      flash[:error] = "Foi passear perdeu o lugar. Repita o processo por favor."
      redirect_to new_password_reset_path
    elsif @user.update_attributes(params[:user])
      sign_in @user
      redirect_to root_path
    else
      render :edit
    end
  end

end
