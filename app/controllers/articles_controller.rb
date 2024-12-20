class ArticlesController < ApplicationController
  before_action :authenticate_user!, only: [:destroy, :edit, :update, :new]
  before_action :set_article, only: %i[show edit update destroy]

  # GET /articles or /articles.json
  def index
    @top_articles = Article.top_articles.where(publish: true).order(Arel.sql("top_article_number IS NULL, top_article_number ASC"))

    @articles = if params[:category] == "articles" || params[:category] == "top_article" || params[:category].blank?
      Article.where(category: ["articles", "top_article"], publish: true).distinct.order(id: :desc).limit(20)
    else
      Article.where(category: params[:category], publish: true).order(id: :desc).limit(20)
    end
  end

  # GET /articles/1 or /articles/1.json
  def show
    @article = Article.find_by!(slug: params[:slug])

    session_key = "viewed_article_#{@article.id}"

    unless session[session_key]
      @article.increment!(:views_count)
      session[session_key] = true
    end

    if params[:sort]
      session[:comment_sort_order] = params[:sort]
    end

    sort_order = (session[:comment_sort_order] == "newest") ? :desc : :asc
    @comments = @article.comments.order(created_at: sort_order)

    respond_to do |format|
      format.html
      format.turbo_stream do
        render turbo_stream: [
          turbo_stream.replace("comments", partial: "articles/comments", locals: {comments: @comments}),
          turbo_stream.replace("sort_controls", partial: "articles/sort_controls", locals: {article: @article})
        ]
      end
    end
  rescue ActiveRecord::RecordNotFound
    redirect_to articles_path, alert: "Article not found."
  end

  # GET /articles/new
  def new
    @article = Article.new
  end

  # GET /articles/1/edit
  def edit
  end

  # POST /articles or /articles.json
  def create
    @article = Article.new(article_params)

    respond_to do |format|
      if @article.save
        Rails.logger.info("Article created successfully: #{@article.title}")
        format.html { redirect_to article_url(@article), notice: "Artykuł utworzony." }
        format.json { render :show, status: :created, location: @article }
      else
        Rails.logger.error("Failed to create article: #{@article.errors.full_messages}")
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /articles/1 or /articles/1.json
  def update
    respond_to do |format|
      if @article.update(article_params)
        format.html { redirect_to article_url(@article), notice: "Artykuł zaktualizowany" }
        format.json { render :show, status: :ok, location: @article }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /articles/1 or /articles/1.json
  def destroy
    @article.destroy

    respond_to do |format|
      format.html { redirect_to articles_url, notice: "Usunięto artykuł." }
      format.json { head :no_content }
    end
  end

  def like
    @article = Article.find_by!(slug: params[:slug])
    session_key = "liked_article_#{@article.id}"

    unless session[session_key]
      @article.likes.create
      session[session_key] = true
    end

    respond_to do |format|
      format.html { redirect_to @article, notice: "Dziękuję za polubienie!" }
      format.turbo_stream do
        render turbo_stream: turbo_stream.replace("like_button_#{@article.id}",
          partial: "shared/like_button", locals: {article: @article})
      end
    end
  end

  def load_more
    offset = params[:offset].to_i
    limit = 6

    @articles = if params[:category].present?
      Article.where(category: params[:category])
        .order(created_at: :desc)
        .offset(offset)
        .limit(limit)
    else
      Article.order(created_at: :desc)
        .offset(offset)
        .limit(limit)
    end

    Rails.logger.info("Fetched Articles IDs: #{@articles.pluck(:id).join(", ")}") # Debugging line

    if params[:category].present?
      more_articles = Article.where(category: params[:category])
        .count > offset + limit
    end
    more_articles ||= Article.count > offset + limit

    render partial: "articles/more_articles", locals: {articles: @articles, more_articles: more_articles}
  end

  private

  def set_article
    if params[:slug]
      @article = Article.find_by(slug: params[:slug])
    elsif params[:id]
      @article = Article.find(params[:id])
    else
      raise ActiveRecord::RecordNotFound, "Nie znaleziono"
    end
    unless @article.publish? || current_user&.admin?
      redirect_to articles_path, alert: "Artykuł nie jest dostępny."
    end
  end
  
  def article_params
    params.require(:article).permit(:title, :content, :article_image, :category, :publish, :description)
  end
end
