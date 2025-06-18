class Views::Lab::ImageUploads::Index < Views::Base
  def initialize(test_objects: [])
    @test_objects = test_objects
  end

  def view_template
    div(class: "flex flex-col gap-4") do
      # 헤더 영역
      div(class: "flex justify-between") do
        h1(class: "font-bold text-3xl") { "이미지 겔러리" }
        a(href: "/lab/image-uploads/new") { "이미지 등록하기" }
      end

      # 설명 텍스트
      p do
        plain "이미지를 저장할 때 GoogleVisionAI 를 통해 이미지의 지배적 색상을 추출하여 메타데이터로 같이 저장합니다."
        br
        plain "처음엔 흔한 이미지 관련 라이브러리를 사용하여 색상추출까지는 쉬웠으나 단순히 pixel을 많이 차지하는 색상을 뽑아주니"
        br
        plain "사용하고 보면 어색한 경우들이 많았습니다."
        br
        plain "이미지 조회시 이미지가 완전히 로드 되기 전까지 이미지박스에 지배적색상을 먼저 노출하고 단순한 에니메이션 효과로 이미지를 서서히"
        br
        plain "보여주는 식으로 구현하였습니다."
      end

      # 플래시 메시지 영역
      div(class: "p-4") do
        render Views::Partials::Flash.new(version: "v2")
      end

      # 이미지 목록 영역
      div(class: "flex flex-col flex-wrap") do
        @test_objects.each do |test_object|
          render Views::Lab::ImageUploads::Item.new(test_object: test_object)
        end
      end
    end
  end
end
