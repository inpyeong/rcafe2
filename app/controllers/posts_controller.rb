class PostsController < ApplicationController
  before_action :set_bulletin
  before_action :set_post, only: %i[ show edit update destroy ]

  # GET /posts or /posts.json
  def index
    @posts = @bulletin.present? ? @bulletin.posts.all : Post.all
  end

  # GET /posts/1 or /posts/1.json
  def show
  end

  # GET /posts/new
  def new
    @posts = @bulletin.present? ? @bulletin.posts.new : Post.new
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts or /posts.json
  def create
    @post = @bulletin.present? ? @bulletin.posts.new(post_params) : Post.new(post_params)

    respond_to do |format|
      if @post.save
        format.html { redirect_to (@bulletin.present? ? [@post.bulletin, @post] : @post), notice: 'Post was successfully created.' }
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
        format.html { redirect_to (@bulletin.present? ? [@post.bulletin, @post] : @post), notice: 'Post was successfully updated.' }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1 or /posts/1.json
  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to (@bulletin.present? ? bulletin_posts_url : posts_url), notice: 'Post was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_bulletin
      @bulletin = Bulletin.find(params[:bulletin_id]) if params[:bulletin_id].present?
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_post
      if @bulletin.present?
        @post = @bulletin.posts.find(params[:id])
      else
        @post = Post.find(params[:id])
      end
    end

    # Only allow a list of trusted parameters through.
    def post_params
      params.require(:post).permit(:title, :content)
    end
end
