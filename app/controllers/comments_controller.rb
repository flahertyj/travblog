class CommentsController < ApplicationController
  def create
    @blog = Blog.find(params[:blog_id])
    @comment = @blog.comments.create(comment_params)

    respond_to do |format|
      if @comment.save
        format.html { redirect_to "/blogs/#{params[:blog_id]}" }
      else
        # format.html { render action: "new" }
        format.html { redirect_to "/blogs/#{params[:blog_id]}", notice: "Blog was not successfully created - #{@comment.errors.full_messages.to_sentence}" }
      end
    end
  end

  def destroy
    @blog = Blog.find(params[:blog_id])
    @comment = @blog.comments.find(params[:id])

    respond_to do |format|
      if @comment.destroy
        format.html { redirect_to "/blogs/#{params[:blog_id]}" }
      else
        # format.html { render action: "new" }
        format.html { redirect_to "/blogs/#{params[:blog_id]}", notice: 'Blog was not successfully created.' }
      end
    end
  end

  private
    def comment_params
      params.require(:comment).permit(:commenter, :body)
    end
end
