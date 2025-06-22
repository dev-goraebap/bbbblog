class Views::Admin::Posts::Form < Views::Base
  def initialize(post: nil, tags: [], mode: "new")
    @post = post
    @tags = tags
    @mode = mode
  end

  def view_template
    # 오류 메시지 표시
    if @post.errors.any?
      div(class: "bg-red-50 p-4 rounded-md mb-4") do
        h2(class: "text-red-800") { "#{pluralize(@post.errors.count, "error")} prohibited this post from being saved:" }
        ul(class: "list-disc ml-5 text-red-700") do
          @post.errors.each do |error|
            li { error.full_message }
          end
        end
      end
    end

    form(action: form_action, method: "post", class: "space-y-6") do
      # CSRF 토큰
      input(type: "hidden", name: "authenticity_token", value: helpers.form_authenticity_token)

      # PATCH 메소드 오버라이드 (필요한 경우)
      if @post.persisted?
        input(type: "hidden", name: "_method", value: "patch")
      end

      # 기본 정보 섹션
      div(class: "border-b border-gray-900/10 pb-12") do
        h2(class: "text-base font-semibold leading-7 text-gray-900") { "Post Information" }

        div(class: "mt-4 grid grid-cols-1 gap-x-6 gap-y-8 sm:grid-cols-6") do
          # 제목 필드
          div(class: "col-span-full") do
            label(for: "post_title", class: "block text-sm font-medium leading-6 text-gray-900") { "Title" }
            input(type: "text", name: "post[title]", id: "post_title", value: @post&.title,
                  class: "block w-full rounded-md border-0 py-1.5 text-gray-900 shadow-sm ring-1 ring-inset ring-gray-300 placeholder:text-gray-400 focus:ring-2 focus:ring-inset focus:ring-indigo-600 sm:text-sm sm:leading-6")
          end

          # 본문 필드
          div(class: "col-span-full") do
            label(for: "post_body", class: "block text-sm font-medium leading-6 text-gray-900") { "Content" }
            div(class: "mt-2") do
              textarea(name: "post[body]", id: "post_body", rows: 15,
                      class: "block w-full rounded-md border-0 py-1.5 text-gray-900 shadow-sm ring-1 ring-inset ring-gray-300 placeholder:text-gray-400 focus:ring-2 focus:ring-inset focus:ring-indigo-600 sm:text-sm sm:leading-6") do
                @post&.body.to_s
              end
            end
          end

          # 슬러그 필드
          div(class: "sm:col-span-4") do
            label(for: "post_slug", class: "block text-sm font-medium leading-6 text-gray-900") { "Slug" }
            div(class: "mt-2") do
              input(type: "text", name: "post[slug]", id: "post_slug", value: @post&.slug,
                    class: "block w-full rounded-md border-0 py-1.5 text-gray-900 shadow-sm ring-1 ring-inset ring-gray-300 placeholder:text-gray-400 focus:ring-2 focus:ring-inset focus:ring-indigo-600 sm:text-sm sm:leading-6")
            end
            p(class: "mt-1 text-sm text-gray-500") { "URL-friendly identifier (e.g. my-post-title)" }
          end

          # 상태 필드
          div(class: "sm:col-span-3") do
            label(for: "post_status", class: "block text-sm font-medium leading-6 text-gray-900") { "Status" }
            div(class: "mt-2") do
              select(name: "post[status]", id: "post_status",
                     class: "block w-full rounded-md border-0 py-1.5 text-gray-900 shadow-sm ring-1 ring-inset ring-gray-300 focus:ring-2 focus:ring-inset focus:ring-indigo-600 sm:text-sm sm:leading-6") do
                option(value: "draft", selected: @post&.status == "draft") { "Draft" }
                option(value: "published", selected: @post&.status == "published") { "Published" }
                option(value: "scheduled", selected: @post&.status == "scheduled") { "Scheduled" }
              end
            end
          end

          # 발행일 필드
          div(class: "sm:col-span-3") do
            label(for: "post_published_at", class: "block text-sm font-medium leading-6 text-gray-900") { "Published At" }
            div(class: "mt-2") do
              input(type: "datetime-local", name: "post[published_at]", id: "post_published_at",
                    value: format_datetime(@post&.published_at),
                    class: "block w-full rounded-md border-0 py-1.5 text-gray-900 shadow-sm ring-1 ring-inset ring-gray-300 placeholder:text-gray-400 focus:ring-2 focus:ring-inset focus:ring-indigo-600 sm:text-sm sm:leading-6")
            end
          end

          # 설명 필드
          div(class: "col-span-full") do
            label(for: "post_description", class: "block text-sm font-medium leading-6 text-gray-900") { "Description" }
            div(class: "mt-2") do
              textarea(name: "post[description]", id: "post_description", rows: 3,
                      class: "block w-full rounded-md border-0 py-1.5 text-gray-900 shadow-sm ring-1 ring-inset ring-gray-300 placeholder:text-gray-400 focus:ring-2 focus:ring-inset focus:ring-indigo-600 sm:text-sm sm:leading-6") do
                @post&.description.to_s
              end
            end
            p(class: "mt-1 text-sm text-gray-500") { "Brief description for SEO and social sharing" }
          end

          # 읽기 시간 필드
          div(class: "sm:col-span-2") do
            label(for: "post_reading_time", class: "block text-sm font-medium leading-6 text-gray-900") { "Reading Time (minutes)" }
            div(class: "mt-2") do
              input(type: "number", name: "post[reading_time]", id: "post_reading_time",
                    value: @post&.reading_time, min: "1",
                    class: "block w-full rounded-md border-0 py-1.5 text-gray-900 shadow-sm ring-1 ring-inset ring-gray-300 placeholder:text-gray-400 focus:ring-2 focus:ring-inset focus:ring-indigo-600 sm:text-sm sm:leading-6")
            end
          end
        end
      end

      # 태그 섹션
      div(class: "border-b border-gray-900/10 pb-12") do
        h2(class: "text-base font-semibold leading-7 text-gray-900") { "Tags" }
        p(class: "mt-1 text-sm leading-6 text-gray-600") { "Add or create tags for this post" }

        div(class: "mt-5 grid grid-cols-1 gap-x-6 gap-y-8 sm:grid-cols-6") do
          # 기존 태그 선택 (체크박스)
          div(class: "col-span-full") do
            label(class: "text-sm font-medium leading-6 text-gray-900") { "Select existing tags" }
            div(class: "mt-3 space-y-2") do
              @tags.each do |tag|
                div(class: "flex items-center gap-x-3") do
                  input(type: "checkbox",
                        id: "post_tag_ids_#{tag.id}",
                        name: "post[tag_ids][]",
                        value: tag.id,
                        checked: @post&.tag_ids&.include?(tag.id),
                        class: "h-4 w-4 rounded border-gray-300 text-indigo-600 focus:ring-indigo-600")
                  label(for: "post_tag_ids_#{tag.id}",
                        class: "block text-sm font-medium leading-6 text-gray-900") { tag.name }
                end
              end
            end
          end

          # 새 태그 생성 (쉼표로 구분)
          div(class: "col-span-full") do
            label(for: "post_tag_names", class: "block text-sm font-medium leading-6 text-gray-900") { "Create new tags" }
            div(class: "mt-2") do
              input(type: "text", name: "post[tag_names]", id: "post_tag_names",
                    value: @post&.persisted? ? "" : @post&.tag_names,
                    class: "block w-full rounded-md border-0 py-1.5 text-gray-900 shadow-sm ring-1 ring-inset ring-gray-300 placeholder:text-gray-400 focus:ring-2 focus:ring-inset focus:ring-indigo-600 sm:text-sm sm:leading-6",
                    placeholder: "Enter tags separated by commas")
            end
            p(class: "mt-1 text-sm text-gray-500") { "Example: ruby, rails, programming" }
          end
        end
      end

      # 제출 버튼
      div(class: "mt-6 flex items-center justify-end gap-x-6") do
        a(href: helpers.admin_posts_path, class: "text-sm font-semibold leading-6 text-gray-900") { "Cancel" }
        button(type: "submit",
               class: "rounded-md bg-indigo-600 px-3 py-2 text-sm font-semibold text-white shadow-sm hover:bg-indigo-500 focus-visible:outline focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-indigo-600") do
          @mode == "new" ? "Create post" : "Update post"
        end
      end
    end
  end

  private

  # 폼 액션 URL 생성
  def form_action
    if @post&.persisted?
      helpers.admin_post_path(@post)
    else
      helpers.admin_posts_path
    end
  end

  # 날짜 포맷팅
  def format_datetime(datetime)
    datetime&.strftime("%Y-%m-%dT%H:%M")
  end

  # pluralize 헬퍼 메서드
  def pluralize(count, singular, plural = nil)
    if count == 1
      "#{count} #{singular}"
    else
      "#{count} #{plural || singular + 's'}"
    end
  end
end
