class Views::Admin::Posts::New < Views::Base
  def initialize(post: nil)
    @post = post
  end

  def view_template
    helpers.content_for :title, "Editing Posts"
    h2 { "게시물 생성" }
    render Views::Admin::Posts::Form.new(post: @post)
  end
end
