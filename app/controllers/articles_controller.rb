class ArticlesController < ApplicationController

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)
    if @article.save
      flash[:notice] = "Successfully created new article"
      redirect_to articles_path
    else
      render 'new'
    end
  end

  def edit

  end

  def update

  end

  def show
<<<<<<< HEAD
    @article = Article.find(params[:id])
=======
    @articles = Article.all
>>>>>>> cf9400abfc60e28f41b625f755aadd6e02533abe

  end

  def destroy

  end

  def index
    @articles = Article.all

  end

  private
    def article_params
      params.require(:article).permit(:title, :description)
    end


end
