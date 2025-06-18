class Views::Lab::ImagePreview::Index < Views::Base
  def view_template
    div(class: "flex flex-col gap-4") do
      # 제목과 설명 영역
      div(class: "prose-sm") do
        h1(class: "font-bold") { "이미지 업로드 및 미리보기" }
        p do
          plain "서버사이드 랜더링측의 isMultiple(boolean) 상태값을 통해 단건/여러건의 이미지 파일을 등록."
          br
          plain "요청된 파일 수만큼 template 영역에 정의된 미리보기 컴포넌트를 랜더링."
        end
      end

      # 이미지 프리뷰 컴포넌트
      div do
        render Views::Partials::ImagePreview.new(
          isMultiple: helpers.params[:isMultiple] == "true"
        )
      end
    end
  end
end
