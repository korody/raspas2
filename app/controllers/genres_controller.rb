# encoding: utf-8
class GenresController < ApplicationController
  respond_to :html, :json

  def index
    @genres = Genre.order(:name)
    genre_list = @genres.where("name ilike ?", "%#{params[:q]}%").map {|g| {id: g.id, name: g.name} } 
    genre_query = genre_list.empty? ? [{id: "<<<#{params[:q]}>>>", name: "NOVO GÊNERO: \"#{params[:q]}\""}] : genre_list
    respond_with(@genre) do |format|
      format.json { render json: genre_query }
    end
  end

  def show
  end

  def create
    @genre = Genre.new genre_params
  end

  private

  def genre_params
    params.require(:genre).permit(:name)
  end

end
