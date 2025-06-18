class Views::Lab::ImageUploads::New < Views::Base
  def view_template
    div(class: "flex flex-col gap-4") do
      h1(class: "font-bold text-3xl") { "이미지 업로드" }
      
      form(
        action: "/lab/image-uploads",
        method: "post",
        enctype: "multipart/form-data",
        class: "flex flex-col items-start gap-4"
      ) do
        fieldset(class: "fieldset") do
          legend(class: "fieldset-legend") { "대충 아무런 이름 ㄱㄱ" }
          input(class: "input", name: "test_object[name]")
        end
        
        render Views::Partials::ImagePreview.new(
          version: "v2",
          isMultiple: true,
          name: "test_object[images][]"
        )
        
        button(class: "btn btn-primary") { "업로드" }
      end
    end
  end
end