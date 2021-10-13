class CommentsController < ApplicationController
  # allow only authenticated users to delete comments,
  http_basic_authenticate_with name: "dhh", password: "secret", only: :destroy

  def create
    # side-effect of the nesting
    @article = Article.find(params[:article_id])
   
    # automatically link the comment so that it belongs to that particular article
    @comment = @article.comments.create(comment_params)
   
    # helper calls the show action of the ArticlesController which
    # renders the show.html.erb template.
    redirect_to article_path(@article) 
  end

  def destroy
    @article = Article.find(params[:article_id])
    @comment = @article.comments.find(params[:id])
    @comment.destroy
    redirect_to article_path(@article)
  end
 
  private
    def comment_params
      params.require(:comment).permit(:commenter, :body)
    end
end
