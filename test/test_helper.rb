Rails.env ||= 'test'
require_relative "../config/environment"
require "rails/test_help"

class ActiveSupport::TestCase
  # Run tests in parallel with specified workers
  parallelize(workers: :number_of_processors)

  # アクティブなユーザーを返す
  def active_user
    User.find_by(activated: true)
  end

  # api path
  def api(path = "/")
    "/api/v1#{path}"
  end

  # 認可ヘッダ
  def auth(token)
    { Authorization: "Bearer #{token}" }
  end

  # 引数のparamsでログインを行う
  def login(params)
    post api("/auth_token"), xhr: true, params: params
  end

  # ログアウトapi
  def logout
    delete api("/auth_token"), xhr: true
  end

  # レスポンスJSONをハッシュで返す
  def res_body
    JSON.parse(@response.body)
  end

  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...
end
