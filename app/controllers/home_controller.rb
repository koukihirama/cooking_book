class HomeController < ApplicationController
  def index
    @recent_recipes = Recipe.order(created_at: :desc).limit(3)
    @tags = Tag.limit(10)
  end
end
