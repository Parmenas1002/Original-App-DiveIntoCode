class CommentsController < ApplicationController
  before_action :set_movie, only: [:create, :edit, :update]
  def create
    @comment = @movie.comments.build(comment_params)
    @comment.user = current_user
    respond_to do |format|
      if @comment.save
        format.js { render :index }     
        flash.now[:notice] = 'Comment add with success'  
      else
        format.js { render :index }     
        flash.now[:error] = 'Please add text to comment'   
      end
    end
  end
  def edit
    @comment = @movie.comments.find(params[:id])
    respond_to do |format|
      format.js { render :edit }
    end
  end
  def update
    @comment = @movie.comments.find(params[:id])
      respond_to do |format|
        if @comment.update(comment_params)
          flash.now[:notice] = 'Comment update with success'
          format.js { render :index}
        else
          flash.now[:error] = 'Please add text to our comment'
          format.js { render :edit}
        end
      end
  end
  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    respond_to do |format|
      flash.now[:notice] = 'Comment delete with success'
      format.js { render :index }
    end
  end
  private
  def comment_params
    params.require(:comment).permit(:blog_id, :content,:user_id)
  end
  def set_movie
    @movie = Movie.find(params[:movie_id])
  end

end
