class Recipe < ApplicationRecord
  belongs_to :family

  has_many :recipe_tags, dependent: :destroy
  has_many :tags, through: :recipe_tags

  has_one_attached :image
  attr_accessor :tag_names

  validates :title, :ingredients, :instructions, presence: true
end
