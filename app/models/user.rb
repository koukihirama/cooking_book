class User < ApplicationRecord
  belongs_to :family
  has_many :recipes, dependent: :destroy
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :family_id, presence: true
end
