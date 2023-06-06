class Api::V1::UsersController < ApplicationController
  def index
    @users = User.all
    render json: { status: 'SUCCESS',
      message: 'Loaded users',
      users: @users.as_json(only: [:id, :name, :email, :created_at]),
    }
    # render json: @users.as_json(only: [:id, :name, :email, :created_at])
  end
end
