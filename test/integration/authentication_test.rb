require "test_helper"

class AuthenticationTest < ActionDispatch::IntegrationTest
  def setup
    @user = active_user
    @params = { auth: { email: @user.email, password: "password" } }
    @access_lifetime = UserAuth.access_token_lifetime
    @session_key = UserAuth.session_key.to_s
    @access_token_key = "token"
  end

  # ポストapi
  def posts_api(token)
    get api("/posts"), xhr: true, headers: auth(token)
  end

  # 認証メソッドテスト
  test "authenticate_user_method" do
    login(@params)
    access_token = res_body[@access_token_key]

    # 有効なtokenでアクセスできているか
    posts_api(access_token)
    assert_response 200
    assert response.body.present?

    # 有効期限切れは401が返っているか
    travel_to (@access_lifetime.from_now) do
      # アクセス前のcookieは存在するか
      assert_not cookies[@session_key].blank?

      # レスポンスは想定通りか
      posts_api(access_token)
      assert_response 401
      assert_not response.body.present?

      # cookieは削除されているか
      assert cookies[@session_key].blank?
    end

    # 不正なtokenが投げられた場合
    invalid_token = "a." + access_token
    posts_api(invalid_token)

    assert_response 401
    assert_not response.body.present?
  end
end
