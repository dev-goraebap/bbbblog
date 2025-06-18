class Views::Partials::ImageUploader < Views::Base
  def initialize(
    # 업로드된 이미지 데이터가 있을경우 사용됨
    uploaded_images: []
  )
    @uploaded_images = uploaded_images
  end

  def view_template
    div(
      data: { controller: "image-uploader" },
      class: "flex flex-col gap-4") do
      # 업로드 박스
      label(
        data: { action: "drop->image-uploader#onDrop dragover->image-uploader#onDragOver" },
        class: "flex flex-col gap-4 items-center w-full p-4 rounded-xl
            border-2 border-neutral-500 border-dashed cursor-pointer") do
        render Views::Partials::Icon.new(name: "image", classes: "text-neutral-700 size-10")
        div(class: "flex flex-col gap-2 items-center") do
          p(class: "text-2xl") { "이미지 업로드" }
          plain "드레그&드롭으로 이미지를 가져오거나 클릭하여 이미지를 첨부해주세요."
        end

        # 새로 추가되는 파일 인풋
        input(
          data: {
            image_uploader_target: "addFileInput",
            action: "change->image-uploader#onChange"
          },
          class: "hidden",
          type: "file",
          multiple: "true",
          name: "added_files",
          accept: "image/*")
      end

      # 업로드된 이미지 미리보기 박스
      div(class: "flex flex-col gap-2") do
        @uploaded_images.each do |image|
          render ssr_preview_item(
            id: image.blob.id,
            url: helpers.url_for(image),
            name: image.blob.filename,
            size: image.blob.byte_size,
            type: image.blob.content_type
          )
        end
      end

      # 생성할 이미지 미리보기 박스
      div(
        data: { image_uploader_target: "newImagesView" },
        class: "flex flex-col gap-2"
      )

      # 생성될 이미지 템플릿(스티뮬러를 통해 동적으로 복제됨)
      render csr_preview_item_template

      # 업로드된 이미지를 삭제할 경우 삭제할 아이디를 담는 Input 템플릿(스티뮬러를 통해 동적으로 복제됨)
      render csr_remove_id_input_template
    end
  end

  private

  def csr_preview_item_template
    template(data: { image_uploader_target: "newImageTemplate" }) do
      div(class: "flex gap-2 justify-start items-center") do
        div(class: "bg-neutral-content w-16 h-10 min-w-16 min-h-10 max-w-16 max-h-10 overflow-hidden") do
          img("x-data": "img", alt: "preview image", class: "w-full h-full")
        end
        div(class: "overflow-hidden") do
          p("x-data": "name", class: "text-sm text-neutral truncate whitespace-nowrap")
          div(class: "flex gap-2 text-xs text-neutral/50") do
            span("x-data": "size")
            span("x-data": "type")
          end
        end
        button(
          data: { action: "click->image-uploader#onRemoveNewImage" },
          "x-data": "removeBtn",
          type: "button"
        ) do
          render Views::Partials::Icon(name: "close")
        end
      end
    end
  end

  def ssr_preview_item(id:, url:, name:, size:, type:)
    div(
      id: "preview_item_#{id}",
      class: "flex gap-2 justify-start items-center") do
      div(class: "bg-neutral-content w-16 h-10 min-w-16 min-h-10 max-w-16 max-h-10 overflow-hidden") do
        img(src: url, alt: "preview image", class: "w-full h-full")
      end
      div(class: "overflow-hidden") do
        p("x-data": "name", class: "text-sm text-neutral truncate whitespace-nowrap") { "#{name}" }
        div(class: "flex gap-2 text-xs text-neutral/50") do
          span("x-data": "size") { size }
          span("x-data": "type") { type }
        end
      end
      button(
        data: {
          id: id,
          action: "click->image-uploader#onRemoveUploadedImage"
        },
        type: "button"
      ) do
        render Views::Partials::Icon(name: "close")
      end
    end
  end

  def csr_remove_id_input_template
    template(data: { image_uploader_target: "removeIdInputTemplate" }) do
      input(name: "removeFileIds[]", class: "hidden")
    end
  end
end
