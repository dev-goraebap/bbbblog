class Views::Lab::FlashV2::Index < Views::Base
  def view_template
    div(class: "prose-sm") do
      h1(class: "font-bold") { "플래시 메시지 (Flash Messages)에 반응 추가하기" }

      p do
        plain "기존의 플레시 메시지에 stimulus를 통해 컨트롤러를 연결하였습니다."
        br
        plain "X버튼을 클릭하여 요소를 제거하거나"
        br
        plain "3초 후에 자동으로 사라지는 요구사항을 충족합니다."
      end

      render Views::Partials::Flash.new(version: "v2")

      br

      div(class: "flex gap-4") do
        a(
          href: "/lab/flash-v2/success",
          data: { turbo_method: "post" },
          class: "btn btn-soft btn-primary"
        ) { "어떤 작업의 성공.." }

        a(
          href: "/lab/flash-v2/failure",
          data: { turbo_method: "post" },
          class: "btn btn-soft btn-warning"
        ) { "어떤 작업의 실패.." }
      end
    end
  end
end
