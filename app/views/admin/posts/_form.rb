class Views::Admin::Posts::Form < Views::Base
  def initialize(post: nil, mode: "new")
    @post = post
    @mode = mode
  end

  def view_template
    if @post.errors.any?
      h2 { "#{pluralize(@post.errors.count, "error")} prohibited this post from being saved:" }
      ul do
        @post.errors.each do |error|
          li { error.full_message }
        end
      end
    end

    form(data: { controller: "tiny-mce" },
        class: "flex gap-4 w-full h-full max-h-[1000px]") do
      div(class: "w-[800px] flex flex-col gap-4") do
        fieldset(class: "fieldset") do
          input(name: "policy[title]",
            type: "text",
            value: @post.title,
            class: "text-3xl font-extrabold",
            placeholder: "제목을 입력하세요")
        end

        # 실제 에디터용 텍스트 영역
        textarea(id: "tiny-mce-editor", class: "h-full")
        # hidden 필드로 내용 전송
        input(type: "hidden", name: "policy[content]", id: "policy_content_hidden", value: @post.body)

        div(class: "my-10 border") do
          plain "태그 생성영역"
        end

        button(class: "btn btn-soft btn-primary") { @mode == "new" ? "저장" : "수정" }
      end
    end
  end
end
