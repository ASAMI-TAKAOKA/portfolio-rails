class Api::V1::UsersController < ApplicationController
  # ログイン済みのユーザーしかアクセスさせない
  # before_action :authenticate_active_user

  # def index
    # @users = User.all
    # render json: { status: 'SUCCESS',
    #   message: 'Loaded users',
    #   users: @users.as_json(only: [:id, :name, :email, :created_at]),
    # }
  # end
end
