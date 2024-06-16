class ArticlesController < ApplicationController
  before_action :authenticate_user!, only: [:destroy, :edit, :update, :new]
  before_action :set_article, only: %i[show edit update destroy]

  # GET /articles or /articles.json
  def index
    @articles = if params[:slug]
      Article.where(slug: params[:slug]).order(id: :desc)
    else
      Article.order(id: :desc)
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

    sort_order = params[:sort] == 'oldest' ? :asc : :desc
    @comments = @article.comments.order(created_at: sort_order)
    
    respond_to do |format|
      format.html
      format.turbo_stream
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
        format.html { redirect_to article_url(@article), notice: "Artykuł utworzony." }
        format.json { render :show, status: :created, location: @article }
      else
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

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_article
    if params[:slug]
      @article = Article.find_by(slug: params[:slug])
    elsif params[:id]
      @article = Article.find(params[:id])
    else
      raise ActiveRecord::RecordNotFound, "Nie znaleziono"
    end
  end

  # Only allow a list of trusted parameters through.
  def article_params
    params.require(:article).permit(:title, :content, :article_image)
  end
end
