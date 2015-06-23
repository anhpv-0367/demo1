class CommentsController < ApplicationController
	before_action :correct_user,   only: :destroy
	def create
      @micropost = Micropost.find(params[:micropost_id])
      @comment = current_user.comments.build(comment_params)
      @comment.micropost = @micropost

      @comment.save
      respond_to do |format|
      	format.html { redirect_to request.referrer }
      	format.js
      end
   	end
   	
	def destroy
	  @micropost = @comment.micropost
	  @comment.destroy
	  flash[:success] = "comment deleted"
      respond_to do |format|
      	format.html { redirect_to request.referrer }
      	format.js
	  end
    end

	private
	def comment_params
            params.require(:comment).permit(:content)
    end

    def correct_user
      @comment = Comment.find_by(params[:comment_id])
      redirect_to root_url if @comment.nil?
    end
end
