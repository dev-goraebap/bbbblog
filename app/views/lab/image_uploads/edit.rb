class Views::Lab::ImageUploads::Edit < Views::Base
  def initialize(test_object:)
    @test_object = test_object
  end

  def view_template
    div(class: "flex flex-col gap-4") do
      h1(class: "font-bold text-3xl") { "이미지 업로드 수정" }

      form(
        action: "/lab/image-uploads",
        method: "put",
        enctype: "multipart/form-data",
        class: "flex flex-col items-start gap-4"
      ) do
        fieldset(class: "fieldset") do
          legend(class: "fieldset-legend") { "대충 아무런 이름 ㄱㄱ" }
          input(class: "input", name: "test_object[name]", value: @test_object.name)
        end

        div(class: "w-[300px]") do
          render Views::Partials::ImageUploader.new(uploaded_images: @test_object.images)
        end

        button(class: "btn btn-primary") { "업로드" }
      end
    end
  end
end
