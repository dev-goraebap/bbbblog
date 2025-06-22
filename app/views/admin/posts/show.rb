class Views::Admin::Posts::Show < Views::Base
  def initialize(post:)
    @post = post
  end

  def view_template
    # 알림 메시지
    p(class: "text-green-600") { helpers.notice }

    article(class: "px-4 py-8 mx-auto max-w-4xl") do
      header(class: "mb-8") do
        h1(class: "text-4xl font-bold") { @post.title }
        div(class: "mt-2 text-gray-600") do
          span { "Status: #{@post.status}" }
          span(class: "mx-2") { "•" }
          span { "Published: #{@post.published_at&.strftime("%B %d, %Y") || "Not published"}" }
          span(class: "mx-2") { "•" }
          span { "Reading time: #{@post.reading_time || 0} min" }
        end

        # 태그 표시
        if @post.tags.any?
          div(class: "mt-3 flex flex-wrap gap-2") do
            @post.tags.each do |tag|
              span(class: "inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-medium bg-blue-100 text-blue-800") do
                tag.name
              end
            end
          end
        end
      end

      div(class: "prose max-w-none") do
        raw(@post.body.to_s.html_safe)
      end

      div(class: "mt-8 flex gap-4") do
        a(href: helpers.edit_admin_post_path(@post), class: "rounded-md bg-indigo-600 px-3 py-2 text-sm font-semibold text-white shadow-sm hover:bg-indigo-500") do
          "Edit"
        end

        form(action: helpers.admin_post_path(@post), method: "post", class: "inline") do
          input(type: "hidden", name: "_method", value: "delete")
          input(type: "hidden", name: "authenticity_token", value: helpers.form_authenticity_token)
          button(type: "submit",
                class: "rounded-md bg-red-600 px-3 py-2 text-sm font-semibold text-white shadow-sm hover:bg-red-500",
                data: { confirm: "Are you sure?" }) do
            "Delete"
          end
        end

        a(href: helpers.admin_posts_path, class: "rounded-md bg-gray-200 px-3 py-2 text-sm font-semibold text-gray-900 shadow-sm hover:bg-gray-300") do
          "Back to posts"
        end
      end
    end
  end
end
