class Views::Partials::UploadBox < Views::Base
  def view_template
    div(class: "border-2 border-dashed border-base-300 rounded-3xl p-10 bg-base-200") do
      "이미지를 끌어다 놓으세요!"
    end
  end
end
