class ApplicationController < ActionController::Base
        # include DeviseTokenAuth::Concerns::SetUserByToken
        # Cookieを扱う
        include ActionController::Cookies
        skip_before_action :verify_authenticity_token
        # 認可を行う
        include UserAuthenticateService

        # CSRF対策で用いられるメソッド これだと上手くいかない
        # protect_from_forgery

        # CSRF対策
        before_action :xhr_request?
        # before_action :configure_permitted_parameters, if: :devise_controller?
        before_action :snake2camel_params
        # skip_before_action :verify_authenticity_token, if: :devise_controller?

        # フロントからのRequestのkeysをcamelCaseからsnake_caseへ変換
        def snake2camel_params
          params.deep_transform_keys!(&:underscore)
        end

        private
          def configure_permitted_parameters
            devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :nickname, :password, :email])
            devise_parameter_sanitizer.permit(:account_update, keys: [:name, :nickname, :password, :email])
          end

          # XMLHttpRequestでない場合は403エラーを返す
          def xhr_request?
            # リクエストヘッダ X-Requested-With: 'XMLHttpRequest' の存在を判定
            return if request.xhr?
            render status: :forbidden, json: { status: 403, error: "Forbidden" }
          end

          # Internal Server Error
          def response_500(msg = "Internal Server Error")
            render status: 500, json: { status: 500, error: msg }
          end
end