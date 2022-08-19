class PostsController < ApplicationController
  before_action :set_post, only: %i[ show edit update destroy upvote downvote]

  def downvote 
    if current_user.voted_down_on? @post
        @post.unvote_by current_user
    else
      @post.downvote_by current_user     
    end
    respond_to do |format|
      format.html do
        redirect_to @post 
      end
      format.turbo_stream do 
        render turbo_stream: turbo_stream.replace(@post, partial: 'posts/post', locals: { post: @post } )
      end
    end  
  end


  def upvote 
    if current_user.voted_up_on? @post
        @post.unvote_by current_user
    else
      @post.upvote_by current_user     
    end
    respond_to do |format|
      # format.html do
      #   redirect_to @post 
      # end
      format.turbo_stream do 
        render turbo_stream: turbo_stream.replace(@post, partial: 'posts/post', locals: { post: @post } )
      end
    end 
        # @post = Post.find(params[:id])
        # if current_user.voted_up_on? @post 
        #   @post.unvote_by current_user
        # else
        #   @post.upvote_by current_user 
        # end  
        # respond_to do |format|
        #   format.js { render 'vote' }
        # end  
  end

  # GET /posts or /posts.json
  def index
    if current_user.subscription_status == "active"
      @posts = Post.all.order(id: :desc)
    else
      @posts = Post.free.order(id: :desc)
    end
  end

  # GET /posts/1 or /posts/1.json
  def show
    if @post.premium? && current_user.subscription_status != "active"
       redirect_to posts_path, alert: "Only for active subscribers"
    end
  end

  # GET /posts/new
  def new
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts or /posts.json
  def create
    @post = Post.new(post_params)

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
    @post.destroy

    respond_to do |format|
      format.html { redirect_to posts_url, notice: "Post was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def post_params
      params.require(:post).permit(:title, :content, :premium)
    end
end
