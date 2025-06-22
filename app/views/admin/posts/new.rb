class Views::Admin::Posts::New < Views::Base
  def initialize(post:, tags: [])
    @post = post
    @tags = tags
  end

  def view_template
    # 페이지 제목 설정
    helpers.content_for :title, "New Post"

    div(class: "px-4 py-10 sm:px-6 sm:py-10 lg:px-8") do
      div(class: "mx-auto max-w-4xl") do
        h1(class: "text-3xl font-bold tracking-tight text-gray-900") { "Create New Post" }

        div(class: "mt-6") do
          # 폼 렌더링
          render Views::Admin::Posts::Form.new(post: @post, tags: @tags, mode: "new")
        end
      end
    end
  end
end
