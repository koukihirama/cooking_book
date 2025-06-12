require "bcrypt"
ENV["RAILS_ENV"] ||= "test"
require_relative "../config/environment"
require "rails/test_help"

# 追加：Deviseのテストヘルパーを読み込む
require "devise"

module ActiveSupport
  class TestCase
    # Run tests in parallel with specified workers
    parallelize(workers: :number_of_processors)

    # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
    fixtures :all

    # 追加：Deviseの統合テストヘルパーを使えるようにする
    include Devise::Test::IntegrationHelpers
  end
end
