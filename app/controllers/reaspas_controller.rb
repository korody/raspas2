# encoding: utf-8
class ReaspasController < ApplicationController
  before_action :authenticate
  respond_to :html, :js

  def create
    @raspa = Raspa.find_by(id: params[:raspa_id])
    current_user.recite!(@raspa)
    respond_with(@reaspa)
  end

  def destroy
    @raspa = Raspa.find(params[:raspa_id])
    current_user.uncite!(@raspa)
    respond_with(@reaspa) do |format|
      format.js { render 'create' }
    end
  end

  # def create
  #   raspa = Raspa.find_by(id: params[:raspa_id])
  #   @reaspa = current_user.reaspas.build(
  #     raspa: raspa)
  #     if @reaspa.save
  #       flash[:notice] = "recitado!"
  #       redirect_to root_url
  #     else
  #       flash[:error] = "pera que deu pêra!"
  #       redirect_to root_url
  #   end
  # end

  # def destroy
  #   @reaspa = current_user.reaspas.find(params[:id])
  #   @reaspa.destroy
  #   flash[:notice] = "ufaned!"
  #   redirect_to authors_raspas_path(current_user.username)
  # end

end
