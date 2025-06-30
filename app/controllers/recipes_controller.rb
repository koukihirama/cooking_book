class RecipesController < ApplicationController
  #ユーザーがログインしていない場合、ログインページへリダイレクト
  before_action :authenticate_user!
  #show, edit, update, destroy の前に @recipe をセット
  before_action :set_recipe, only: %i[show edit update destroy]
  #edit, update, destroy の前に、そのレシピが自分のものかどうかチェック。
  before_action :authorize_user!, only: %i[edit update destroy]

  def new
    @recipe = Recipe.new
    @recipes = current_user.family.recipes.order(created_at: :desc)
  end

  def index
  @recipes = Recipe.includes(:user, :tags)
                   .with_attached_image
                   .where(family_id: current_user.family_id)
                   .order(created_at: :desc)
  end

  def create
    @recipe = current_user.recipes.build(recipe_params)
    @recipe.family_id = current_user.family_id
  if @recipe.save
    redirect_to @recipe, notice: "レシピを投稿しました"
  else
    render :new
  end
end

  def show
    redirect_to recipes_path, alert: "アクセスできません" unless @recipe.family_id == current_user.family_id
  end

  def edit
    @tag_names = @recipe.tags.pluck(:name).join(",") # 既存タグを文字列に
  end

  def update
  tag_names = params[:recipe].delete(:tag_names)

  ActiveRecord::Base.transaction do
    if @recipe.update!(recipe_params)
      @recipe.tags = tag_names.to_s.split(",").map(&:strip).uniq.reject(&:blank?).map do |tag_name|
        Tag.find_or_create_by!(name: tag_name)
      end
    end
  end

  redirect_to @recipe, notice: "レシピを更新しました。"
rescue ActiveRecord::RecordInvalid
  render :edit, status: :unprocessable_entity
end

  def destroy
    @recipe = current_user.recipes.find(params[:id])
    @recipe.destroy
    redirect_to recipes_path, notice: "レシピを削除しました。"
  end

  private

  def recipe_params
  params.require(:recipe).permit(:title, :ingredients, :instructions, :difficulty, :image, :tag_names, :required_time)
  end

  def set_recipe
    @recipe = Recipe.find(params[:id])
  end

  def authorize_user!
    redirect_to recipes_path, alert: "権限がありません" unless @recipe.user == current_user
  end
end
