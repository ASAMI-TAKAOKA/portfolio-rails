class ApplicationController < ActionController::Base
        include DeviseTokenAuth::Concerns::SetUserByToken
        before_action :configure_permitted_parameters, if: :devise_controller?
        before_action :snake2camel_params
        skip_before_action :verify_authenticity_token, if: :devise_controller?

        # フロントからのRequestのkeysをcamelCaseからsnake_caseへ変換
        def snake2camel_params
                params.deep_transform_keys!(&:underscore)
        end

        private
        def configure_permitted_parameters
                devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :nickname, :password, :email])
                devise_parameter_sanitizer.permit(:account_update, keys: [:name, :nickname, :password, :email])
        end
end