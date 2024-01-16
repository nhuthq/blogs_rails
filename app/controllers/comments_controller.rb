class CommentsController < ApplicationController

  before_action :authenticate_author!, except: %i[index show]
  before_action :set_comment, only: %i[show edit update destroy]

  def index
  end

  def show
  end

  def new
  end

  def edit
  end

  def create
    @post = Post.find(params[:id])
    @comment = @post.comments.create(post_params)
    if @comment.save
      format.html { redirect_to post_url(@post), notice: 'Comment was successfully added.' }
      format.json { render :show, status: :created, location: @post }
    else
      format.html { render :new, status: :unprocessable_entity }
      format.json { render json: @post.errors, status: :unprocessable_entity }
    end
  end

  def update
  end

  def destroy
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_comment
    @post = Post.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def comment_paramss
    params.require(:comment).permit(:name, :content)
  end
end
