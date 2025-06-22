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
    tags = Tag.order(:name).all
    render Views::Admin::Posts::New.new(post: post, tags: tags), layout: "post_form"
  end

  def edit
    post = Post.find(params.expect(:id))
    tags = Tag.order(:name).all
    render Views::Admin::Posts::Edit.new(post: post, tags: tags), layout: "post_form"
  end

  def create
    post = Post.new(post_params)

    respond_to do |format|
      if post.save
        format.html { redirect_to [ :admin, post ], notice: "Post was successfully created." }
        format.json { render :show, status: :created, location: post }
      else
        tags = Tag.order(:name).all
        format.html {
          render Views::Admin::Posts::New.new(post: post, tags: tags),
                layout: "post_form",
                status: :unprocessable_entity
        }
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
        tags = Tag.order(:name).all
        format.html {
          render Views::Admin::Posts::Edit.new(post: post, tags: tags),
                layout: "post_form",
                status: :unprocessable_entity
        }
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
    params.require(:post).permit(:title, :body, :status, :published_at, :slug,
                                :description, :reading_time, :tag_names,
                                tag_ids: [])
  end
end
