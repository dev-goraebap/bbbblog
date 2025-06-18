class Views::Lab::Index < Views::Base
  def view_template
    div(class: "prose-sm flex flex-col gap-2") do
      introduction_paragraph

      modal_section

      flash_section

      image_preview_section

      image_uploads_section
    end
  end

  private

  def introduction_paragraph
    p do
      plain "이곳은 "
      a(href: "https://rubyonrails.org/", target: "_blank", class: "font-bold underline decoration-wavy decoration-red-400") { "Ruby on Rails" }
      plain "를 다루며 제가 겪었던 삽질과 그 해결 과정을 기록하는 공간입니다."
      br
      plain "Front-end와 Back-end를 나누는 개발 방식에 대한 깊은 고민과 함께, 혼자서 개발하는 경우 효율성을 어떻게 높일 수 있을지 탐구하고 있습니다."
      br
      plain "최근 Front-end 프레임워크들이 SSR(서버 사이드 렌더링)을 지원하는 추세와는 대조적으로, 저는 기존의 SSR 중심인 Back-end 기반 풀스택 프레임워크를 사용하면서도"
      br
      plain "현대적인 Front-end 개발의 사용자 경험을 놓치고 싶지 않습니다."
      br
      plain "이러한 점에서 "
      a(class: "underline decoration-wavy decoration-blue-400", href: "https://hotwired.dev/", target: "_blank") do
        strong { "Hotwired 시리즈" }
      end
      plain "에 큰 흥미를 느끼고 있으며, 앞으로 이곳 실험실의 주요 테마로 다루게 될 것 같습니다."
    end
  end

  def modal_section
    div do
      h3(class: "font-bold") { "# 이곳에서 모달은 어떻게 만드나요" }
      a(class: "underline decoration-primary", href: "/lab/modal") { "SSR, Turbo Frame을 사용한 기본적인 모달편" }
      br
      a(class: "underline decoration-warning", href: "/lab/modal-v2") { "Stimulus에 무게를 더하여 CSR처리" }
    end
  end

  def flash_section
    div do
      h3(class: "font-bold") { "# 작업 성공,실패 피드백 어떻게 처리함.." }
      a(class: "underline decoration-primary", href: "/lab/flash") { "레일즈에서 제공하는 기본적인 플레시의 개념, 관례" }
      br
      a(class: "underline decoration-warning", href: "/lab/flash-v2") { "stimulus를 사용하여 플래시UI에 반응추가" }
    end
  end

  def image_preview_section
    div do
      h3(class: "font-bold") { "# 이미지 미리보기" }
      a(class: "underline decoration-primary", href: "/lab/image-preview") { "개발경험 생각보다 나쁘지않아 ㄹㅇ루.." }
      br
      a(class: "underline decoration-warning", href: "/lab/image-preview-v2") { "Stimulus 컨트롤러간의 상속. 드레그 드롭기능 확장" }
    end
  end

  def image_uploads_section
    div do
      h3(class: "font-bold") { "# 이미지 처리" }
      a(class: "underline decoration-primary", href: "/lab/image-uploads") { "이미지 랜더링 처리" }
      br
      a(class: "line-through decoration-error", href: "/lab/image-uploads/new") { "파일업로드 너무 쉽게 해버리니까 오히려 더 빡치는데" }
      br
    end
  end
end
