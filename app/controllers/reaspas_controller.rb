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
end
