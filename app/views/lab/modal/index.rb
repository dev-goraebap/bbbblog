class Views::Lab::Modal::Index < Views::Base
  def view_template
    div(class: "prose-sm") do
      h1(class: "font-bold") { "모달: 방법1" }

      p do
        plain "turbo frame을 통해 비동기로 서버에 데이터를 요청. 이 때 모달UI 까지 SSR 해서 제공."
        br
        plain "이후에 클라이언트측에서 stimulus를 사용하여 닫기 이벤트 등을 처리"
      end

      p(class: "text-success") { "장점: 구현방법이 넘사벽급으로 간단함. 관리해야할 코드가 적음" }

      p(class: "text-warning") do
        plain "단점: 모달UI까지 서버에서 랜더링하므로 CSR하는것 보다 모달이 사용자에게 보여지기까지 딜레이가 있음."
        br
        plain "받아올 데이터가 크면 클 수록 채감이 많이 됨 (결국 못써먹는거 아닌가..)"
      end

      div(class: "flex gap-4") do
        a(
          href: "/lab/modal/content",
          data: { turbo_frame: "modal_frame" },
          class: "btn btn-primary"
        ) { "모달 열기" }

        a(
          href: "/lab/modal/lazy-content",
          data: { turbo_frame: "modal_frame" },
          class: "btn btn-warning"
        ) { "조금 느린 모달 열기" }
      end
    end

    turbo_frame(id: "modal_frame")
  end
end
