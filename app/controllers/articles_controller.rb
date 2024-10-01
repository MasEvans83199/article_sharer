class ArticlesController < ApplicationController
  include Pundit 

  before_action :set_article, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index, :show]

  def index
    Rails.logger.debug "Received sort parameter: #{params[:sort]}"
    sort_order = params[:sort] == 'old_to_new' ? 'asc' : 'desc'
    @articles = Article.order(created_at: sort_order).page(params[:page]).per(10)
    Rails.logger.debug "Executing query: #{Article.order(created_at: sort_order).to_sql}"
  end  

  def show
    authorize @article
    @article.increment!(:views) if @article
  end

  def new
    @article = Article.new
    authorize @article 
  end

  def create
    @article = current_user.articles.build(article_params) 
    authorize @article 
    if @article.save
      redirect_to @article, notice: 'Article was successfully created.'
    else
      render :new
    end
  end

  def edit
    authorize @article
  end

  def update
    authorize @article
    if @article.update(article_params)
      redirect_to @article, notice: 'Article was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    authorize @article
    @article.destroy
    redirect_to articles_path
  end  


  private
    def set_article
      @article = Article.find(params[:id])
    end

    def article_params
      params.require(:article).permit(:title, :link, :body)
    end
end
