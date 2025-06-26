class RecipesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_recipe, only: %i[show edit update destroy]
  before_action :authorize_user!, only: %i[edit update destroy]

  def new
    @recipe = Recipe.new
  end

  def index
    @recipes = Recipe.all
  end

  def create
    @recipe = current_user.recipes.build(recipe_params)
    if @recipe.save
      assign_tags
      redirect_to @recipe, notice: "レシピを投稿しました。"
    else
      render :new
    end
  end

  def show
  end

  def edit
    @recipe = Recipe.find(params[:id])
  @tag_names = @recipe.tags.pluck(:name).join(",") # 既存タグを文字列に
  end

  def update
  @recipe = Recipe.find(params[:id])
  tag_names = params[:recipe].delete(:tag_names)

  if @recipe.update(recipe_params)
    @recipe.tags = tag_names.to_s.split(",").map(&:strip).uniq.reject(&:blank?).map do |tag_name|
      Tag.find_or_create_by(name: tag_name)
    end
    redirect_to @recipe, notice: "レシピを更新しました。"
  else
    render :edit, status: :unprocessable_entity
  end
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

  def assign_tags
    return if params[:recipe][:tag_names].blank?

    tag_names = params[:recipe][:tag_names].split(",").map(&:strip).uniq
    tag_names.each do |name|
      tag = Tag.find_or_create_by(name: name)
      @recipe.tags << tag
    end
  end

  def set_recipe
    @recipe = Recipe.find(params[:id])
  end

  def authorize_user!
    redirect_to recipes_path, alert: "権限がありません" unless @recipe.user == current_user
  end
end
