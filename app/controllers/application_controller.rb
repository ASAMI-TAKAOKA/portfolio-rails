class ApplicationController < ActionController::Base
        include DeviseTokenAuth::Concerns::SetUserByToken
        before_action :configure_permitted_parameters, if: :devise_controller?
        skip_before_action :verify_authenticity_token, if: :devise_controller?

        private
        def configure_permitted_parameters
                devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :nickname, :password, :email])
                devise_parameter_sanitizer.permit(:account_update, keys: [:name, :nickname, :password, :email])
        end
end