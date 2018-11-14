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
    @article = Article.find(params[:id])

  end

  def update

  end

  def show
    @article = Article.find(params[:id])

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
