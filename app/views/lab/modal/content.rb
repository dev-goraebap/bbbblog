class Views::Lab::Modal::Content < Views::Base
  def view_template
    h1 { "테스트용 모달 컨텐츠입니다" }

    p do
      plain "서버에서 랜더링된 html 컨텐츠 🧀"
    end
  end
end
