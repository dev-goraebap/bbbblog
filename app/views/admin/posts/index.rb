class Views::Admin::Posts::Index < Views::Base
  def initialize(posts:)
    @posts = posts
  end

  def view_template
    # 알림 메시지
    p(style: "color: green") { helpers.notice }

    # 타이틀 설정
    helpers.content_for :title, "Posts"

    # 헤더
    h1 { "Posts" }

    # 게시물 목록
    div(id: "posts") do
      @posts.each do |post|
        # 게시물 렌더링 (partial)
        render Views::Admin::Posts::Post.new(post: post)

        p do
          link_to "Show this post", [ :admin, post ]
        end
      end
    end

    # 새 게시물 링크
    link_to "New post", helpers.new_admin_post_path
  end

  # 링크 헬퍼 메서드
  def link_to(text, url, **options)
    a(href: url, **options) { text }
  end
end
