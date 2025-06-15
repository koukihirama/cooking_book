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
  end

  def update
  end

  def destroy
  end

  private

  def recipe_params
    params.require(:recipe).permit(:title, :ingredients, :instructions, :difficulty, :image, :tag_names)
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
