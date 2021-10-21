class FavoritesController < ApplicationController
    def create
        favorite = current_user.favorites.create(movie_id: params[:movie_id])
        redirect_to movie_path( params[:movie_id])
    end
    def destroy
        favorite = current_user.favorites.find_by(id: params[:id])
        movie_id = favorite.movie_id
        favorite.destroy
        redirect_to movie_path(movie_id)
    end
end
