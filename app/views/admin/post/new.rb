class Views::Admin::Post::New < Views::Base
  def initialize(post: nil)
    @post = post
  end

  def view_template
    form(data: { controller: "tinymce" },
        class: "flex gap-4 w-full h-full") do
      div(class: "w-[800px] flex flex-col gap-4") do
        fieldset(class: "fieldset") do
          input(name: "policy[title]",
            type: "text",
            value: @post&.dig(:title),
            class: "text-3xl font-extrabold",
            placeholder: "제목을 입력하세요")
        end

        # 실제 에디터용 텍스트 영역
        textarea(id: "tinymce-editor", class: "h-full")
        # hidden 필드로 내용 전송
        input(type: "hidden", name: "policy[content]", id: "policy_content_hidden", value: @post&.dig(:content))
      end
      div(class: "grow border") do
        render Views::Partials::UploadBox.new

        button(class: "btn btn-primary") do
          "초안 저장"
        end

        button(class: "btn btn-primary") do
          "게시하기"
        end
      end
    end
  end
end
