class ArticlesController < ApplicationController
  before_action :set_article, only: %i[ show edit update destroy ]

  # お知らせ一覧ページ
  def index
    @articles = Article.all.order(:created_at)
  end

  # お知らせ詳細ページ
  def show
  end

  # お知らせ新規投稿ページ
  def new
    @article = Article.new
  end

  # お知らせ編集ページ
  def edit
  end

  # お知らせ新規投稿（作成）
  def create
    @article = current_user.articles.new(article_params)
    if @article.save
      flash[:success] = "お知らせ投稿完了致しました"
      redirect_to employee_articles_path
    else
      flash.now[:danger] = '投稿出来ませんでした。'  # 4/25訂正
      render :new
    end
  end

  # お知らせ新規投稿（更新）
  def update
    if @article.update(article_params)
      flash[:success] = "お知らせ内容を更新致しました"
      redirect_to employee_articles_path
    else
      flash.now[:danger] = '投稿出来ませんでした。'  # 4/25訂正
      render :edit
    end
  end

  # お知らせ新規投稿（削除）
  def destroy
    if @article.destroy!
      flash[:warning] = "記事を削除しました。"
      redirect_to employee_articles_path
    else
      redirect_to :index
    end
  end

  private
    # ログインユーザーのidをセット
    def set_article
      @article = current_user.articles.find(params[:id])
    end

    # お知らせ記事投稿内容
    def article_params
      params.require(:article).permit(:title, :content, :author, :created_at)
    end
end
