class Api::V1::PostsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
    @posts = Post.order(created_at: :desc)
    render json: { status: 'SUCCESS', message: 'Loaded posts', data: @posts }
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      head :ok
    else
      render json: @post.errors, status: :unprocessable_entity
    end
  end

  private
    def post_params
      params.permit(:title, :body)
    end
end