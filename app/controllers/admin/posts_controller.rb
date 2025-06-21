class Admin::PostsController < AdminController
  def index
    posts = Post.all
    render Views::Admin::Posts::Index.new(posts: posts)
  end

  def show
    post = Post.find(params.expect(:id))
    render Views::Admin::Posts::Show.new(post: post)
  end

  def new
    post = Post.new
    render Views::Admin::Posts::New.new(post: post), layout: "post_form"
  end

  def edit
    post = Post.find(params.expect(:id))
    render Views::Admin::Posts::Edit.new(post: post), layout: "post_form"
  end

  def create
    post = Post.new(post_params)

    respond_to do |format|
      if post.save
        format.html { redirect_to [ :admin, post ], notice: "Post was successfully created." }
        format.json { render :show, status: :created, location: post }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: post.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    post = Post.find(params.expect(:id))
    respond_to do |format|
      if post.update(post_params)
        format.html { redirect_to [ :admin, post ], notice: "Post was successfully updated." }
        format.json { render :show, status: :ok, location: post }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: post.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    post = Post.find(params.expect(:id))
    post.destroy!

    respond_to do |format|
      format.html { redirect_to admin_posts_path, status: :see_other, notice: "Post was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

    def post_params
      params.expect(post: [ :title, :body ])
    end
end
