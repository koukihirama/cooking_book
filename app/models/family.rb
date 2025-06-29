class Family < ApplicationRecord
    has_many :users, dependent: :destroy

    has_many :recipes

    before_create :generate_code

    private
    def generate_code
      self.code ||= SecureRandom.urlsafe_base64(10)
    end
end
