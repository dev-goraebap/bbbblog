class Views::Partials::Modal < Views::Base
  def view_template
    # CSR 렌더링 방식의 modal
    # stimulus 컨트롤러에서 모달관련 마크업을 처리하지 않기 위해
    # <template> 태그 내부에 미리 UI작성: js보다 html을 우선순위로 생각해야함
    
    template(id: "modal_template") do
      # 모달 오버레이
      div(
        data: { csr_modal_target: "backdrop", action: "click->csr-modal#onBackdropClose" },
        class: "fixed inset-0 bg-neutral/70 flex items-center justify-center"
      ) do
        # 모달 컨텐츠 컨테이너
        div(
          class: "relative flex flex-col w-full h-full bg-base-100 md:w-[600px] md:h-auto md:rounded-xl"
        ) do
          # 테블릿사이즈부터 보이는 영역
          div(
            class: "hidden w-full p-3 md:flex md:justify-end md:items-center"
          ) do
            button(data: { action: "csr-modal#onClose" }) do
              render Views::Partials::Icon(name: "close")
            end
          end

          # 컨텐츠 영역
          div(class: "grow p-6") do
            # 서버에서 받아온 html로 대체될 영역
            turbo_frame(id: "modal_content_frame") do
              # 로딩박스
              div(class: "flex justify-center w-full") do
                div(class: "loading loading-dots text-primary-content")
              end
            end
          end

          # 모바일에서 보이는 하단 영역
          div(class: "flex justify-center items-center w-full p-6 md:hidden") do
            button(data: { action: "csr-modal#onClose" }) do
              render Views::Partials::Icon(name: "close")
            end
          end
        end
      end
    end
  end
end