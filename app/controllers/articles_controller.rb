class ArticlesController < ApplicationController
  # Two popular authentication add-ons for Rails are the Devise rails engine and the Authlogic gem
  # block access to the various actions if the person is not authenticated
  http_basic_authenticate_with name: "dhh", password: "secret", except: [:index, :show]

  def index
    @articles = Article.all
  end
 
  def show
    @article = Article.find(params[:id])
  end

  def new
    # add new to prevent @article to be nil in our view, and 
    # calling @article.errors.any? would throw an error.
    @article = Article.new
  end

  def edit
    @article = Article.find(params[:id])
  end

  def create
    @article = Article.new(article_params)
   
    if @article.save
      # redirect => tell the browser to issue another request
      redirect_to @article
    else
      # @article object is passed back to the new template when it is rendered
      # render => same request as the form submission
      render 'new'
    end
  end

  def update
    @article = Article.find(params[:id])
   
    if @article.update(article_params)
      redirect_to @article
    else
      render 'edit'
    end
  end

  def destroy
    @article = Article.find(params[:id])
    @article.destroy
   
    redirect_to articles_path
  end
  
  # private or protected methods put last
  private
    def article_params
      params.require(:article).permit(:title, :text)
    end
end
