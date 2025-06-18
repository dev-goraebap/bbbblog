class Views::Partials::ImagePreview < Views::Base
  def initialize(version: "v1", name: "files", isMultiple: false)
    @version = version
    @name = name
    @isMultiple = isMultiple
  end

  def view_template
    if @version == "v2"
      v2
    else
      v1
    end
  end

  private

  # 기본 이미지 프리뷰 (드래그 앤 드롭 없음)
  def v1
    div(
      data: { controller: "image-preview" },
      class: "flex flex-col gap-4 w-full md:w-[300px]"
    ) do
      # 라벨 영역
      label(
        data: { image_preview_target: "label" },
        class: "flex flex-col items-center w-full p-4 border-2 border-dashed border-neutral-content rounded-3xl cursor-pointer"
      ) do
        # 아이콘
        div do
          render Views::Partials::Icon(name: "image")
        end

        # 텍스트 안내
        div(class: "flex flex-col items-center text-neutral/80") do
          p do
            strong { "Browse files" }
          end
        end

        # 파일 인풋
        input(
          data: { image_preview_target: "fileInput", action: "image-preview#onChange" },
          type: "file",
          class: "hidden",
          accept: "image/*",
          multiple: @isMultiple
        )
      end

      # 프리뷰 영역
      div(
        data: { image_preview_target: "previewArea" },
        class: "px-2 flex flex-col gap-4"
      )

      # 이미지 미리보기 템플릿
      render_preview_item_template("image-preview")

      # 초기화 버튼 템플릿
      render_clear_button_template("image-preview")
    end
  end

  # 드래그 앤 드롭이 가능한 이미지 프리뷰
  def v2
    div(
      data: {
        controller: "image-preview-v2",
        action: "drop->image-preview-v2#onDrop dragover->image-preview-v2#onDragOver dragleave->image-preview-v2#onDragLeave"
      },
      class: "flex flex-col gap-4 w-full md:w-[300px]"
    ) do
      # 라벨 영역
      label(
        data: { image_preview_v2_target: "label" },
        class: "flex flex-col items-center w-full p-4 border-2 border-dashed border-neutral-content rounded-3xl cursor-pointer"
      ) do
        # 아이콘
        div do
          raw(<<~SVG.html_safe)
            <svg class="size-10 text-neutral/50" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor">
              <path stroke-linecap="round" stroke-linejoin="round" d="m2.25 15.75 5.159-5.159a2.25 2.25 0 0 1 3.182 0l5.159 5.159m-1.5-1.5 1.409-1.409a2.25 2.25 0 0 1 3.182 0l2.909 2.909m-18 3.75h16.5a1.5 1.5 0 0 0 1.5-1.5V6a1.5 1.5 0 0 0-1.5-1.5H3.75A1.5 1.5 0 0 0 2.25 6v12a1.5 1.5 0 0 0 1.5 1.5Zm10.5-11.25h.008v.008h-.008V8.25Zm.375 0a.375.375 0 1 1-.75 0 .375.375 0 0 1 .75 0Z" />
            </svg>
          SVG
        end

        # 텍스트 안내
        div(class: "flex flex-col items-center text-neutral/80") do
          p do
            strong { "Drag and drop." }
            plain " or"
          end
          p do
            strong { "Browse files" }
          end
        end

        # 파일 인풋
        input(
          data: { image_preview_v2_target: "fileInput", action: "image-preview-v2#onChange" },
          name: @name,
          type: "file",
          class: "hidden",
          accept: "image/*",
          multiple: @isMultiple
        )
      end

      # 프리뷰 영역
      div(
        data: { image_preview_v2_target: "previewArea" },
        class: "px-2 flex flex-col gap-4"
      )

      # 이미지 미리보기 템플릿
      render_preview_item_template("image-preview-v2")

      # 초기화 버튼 템플릿
      render_clear_button_template("image-preview-v2")
    end
  end

  # 이미지 미리보기 템플릿 (v1, v2 공통 사용)
  def render_preview_item_template(controller_name)
    template(data: { "#{controller_name}_target": "previewItemTemplate" }) do
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
      end
    end
  end

  # 초기화 버튼 템플릿 (v1, v2 공통 사용)
  def render_clear_button_template(controller_name)
    template(data: { "#{controller_name}_target": "clearButtonTemplate" }) do
      button(
        data: { action: "#{controller_name}#onClear" },
        type: "button",
        class: "btn btn-soft btn-warning text-xs"
      ) { "초기화" }
    end
  end
end
