class PostsController < ApplicationController

  before_action :authenticate_author!, except: %i[index show]
  before_action :set_post, only: %i[show edit update destroy]
  before_action :correct_author, only: %i[edit update destroy]

  # GET /posts or /posts.json
  def index
    @posts = Post.all.order("created_at DESC")
  end

  # GET /posts/1 or /posts/1.json
  def show
    @posts = Post.find(params[:id])
  end

  # GET /posts/new
  def new
    @post = current_author.posts.build
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts or /posts.json
  def create
    @post = current_author.posts.build(post_params)

    respond_to do |format|
      if @post.save
        format.html { redirect_to post_url(@post), notice: "Post was successfully created." }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1 or /posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to post_url(@post), notice: "Post was successfully updated." }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1 or /posts/1.json
  def destroy
    @post.destroy!

    respond_to do |format|
      format.html { redirect_to posts_url, notice: "Post was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Check correct account
    def correct_author
      @friend = current_author.posts.find_by(id: params[:id])
      redirect_to posts_path, notice: 'Not Authorized To Edit This Post' if @post.nil?
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def post_params
      params.require(:post).permit(:title, :short_description, :content, :published, :published_at, :author_id)
    end
end
