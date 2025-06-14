class Views::Admin::Post::New < Views::Base
  def view_template
    form(data: { controller: "tinymce" },
        class: "flex flex-col h-full") do

      # 실제 에디터용 텍스트 영역
      textarea(id: "tinymce-editor", class: "h-full")
      # hidden 필드로 내용 전송
      input(type: "hidden", name: "policy[content]", id: "policy_content_hidden")
    end
  end
end
