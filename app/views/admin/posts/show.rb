class Views::Admin::Posts::Show < Views::Base
  def initialize(post: nil)
    @post = post
  end

  def view_template
  end
end
