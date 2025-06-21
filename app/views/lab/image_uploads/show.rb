class Views::Lab::ImageUploads::Show < Views::Base
  def initialize(test_object: nil)
    @test_object = test_object
  end

  def view_template
    div(class: "flex flex-col gap-4") do
      a(href: "/lab/image-uploads") { "뒤로가기" }

      div(class: "flex flex-col gap-4 bg-base-100") do
        p(class: "text-2xl") do
          plain "##{@test_object.name}"
        end

        div(class: "flex flex-col gap-2") do
          @test_object.images.each do |image|
            # 이미지 컴포넌트 렌더링
            render Views::Partials::Image.new(
              url: helpers.url_for(image),
              dominant_color: image.blob.metadata["dominant_color"],
              width: "w-36",
              height: "h-36",
              alt: @test_object.name
            )

            # 이미지 객체 정보 출력
            pre do
              code do
                plain image.blob.inspect
              end
            end
          end
        end
      end

      div(class: "flex gap-4") do
        a(
          href: "/lab/image-uploads/#{@test_object.id}/edit",
          class: "text-warning"
        ) { "수정하기" }
        a(
          href: "/lab/image-uploads/#{@test_object.id}",
          data: {
            turbo_method: "delete"
          },
          class: "text-error"
        ) { "삭제하기" }
      end
    end
  end
end
