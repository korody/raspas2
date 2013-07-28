class OriginsController < ApplicationController
 
  layout 'origins_sidebar'

  def index
    @origins = Origin.all(order: :title)
  end

  def show
    @origin = Origin.find(params[:id])
    @raspas = @origin.raspas.limit(3)
  end

  def new
  end

  def edit
    @origin = Origin.find(params[:id])
  end

  def update
    @origin = Origin.find(params[:id])
    if @origin.update_attributes(origin_params)
      flash[:success] = "atualizado"
      redirect_to @origin
    else
      render :edit
    end
  end

  private

  def origin_params
    params.require(:origin).permit(:title, :original_title, :publication, :content, :info, :video, :link, :origin_type, :author_tokens, :genre_tokens)
  end

end
