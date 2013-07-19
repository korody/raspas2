class OriginsController < ApplicationController
 
  layout 'origins_sidebar'

  def index
    @origins = Origin.all(order: :title)
  end

  def show
    @origin = Origin.find(params[:id])
  end

  def new
  end

  def edit
  end
end
