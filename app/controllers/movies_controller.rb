class MoviesController < ApplicationController
  before_action :set_movie, only: %i[show]
  before_action :authenticate_user!, only: [:show]
  def index
    @movies = Movie.limit(4)
    if user_signed_in?
      redirect_to dashboard_path
    end
  end
  def show
    @favorite = current_user.favorites.find_by(movie_id: @movie.id)
    @comments = @movie.comments
    @comment = @movie.comments.build
  end
  def dashboard 
    if params[:movie].present?
      @movies = Movie.search_with_key(params[:movie][:name]).page params[:page]
    else
      @movies = Movie.all.page params[:page]
    end 
  end
  private   
  def set_movie
      @movie = Movie.find(params[:id])
  end
end
