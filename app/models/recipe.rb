class Recipe < ApplicationRecord
  before_validation :normalize_required_time

  belongs_to :family

  has_many :recipe_tags, dependent: :destroy
  has_many :tags, through: :recipe_tags

  has_one_attached :image
  attr_accessor :tag_names

  validates :title, :ingredients, :instructions, presence: true

  private

  def normalize_required_time
    if required_time.is_a?(String)
      # 全角数字を半角に変換
      self.required_time = required_time.tr('０-９', '0-9')
    end
  end
end
