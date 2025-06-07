class User < ApplicationRecord
  belongs_to :family
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :family_id, presence: true
end
