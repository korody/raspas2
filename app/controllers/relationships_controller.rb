class RelationshipsController < ApplicationController
  before_action :authenticate # REVISE doesn't get triggered because of remote: true in the form that calls these actions
  respond_to :html, :js

  def create
    @author = Author.find(params[:author_id])
    current_user.fan!(@author)
    respond_with(@relationship)
  end

  def destroy
    @author = Author.find(params[:author_id])
    current_user.unfan!(@author)
    respond_with(@relationship) do |format|
      format.js { render 'create' }
    end
  end

end