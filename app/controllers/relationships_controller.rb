class RelationshipsController < ApplicationController
  before_action :authenticate

  def create
    @author = Author.find(params[:author_id])
    current_user.fan!(@author)
    respond_to do |format|
      format.html { redirect_to :back }
      format.js
    end
  end

  def destroy
    @author = Author.find(params[:author_id])
    current_user.unfan!(@author)
    respond_to do |format|
      format.html { redirect_to :back }
      format.js { render 'create' }
    end
  end

end