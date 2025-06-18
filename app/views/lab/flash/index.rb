class Views::Lab::Flash::Index < Views::Base
  def view_template
    div(class: "prose-sm") do
      h1(class: "font-bold") { "플래시 메시지 (Flash Messages)" }

      p do
        plain "플래시 메시지는 최신 프론트엔드 환경과는 다르게, 서버 측 렌더링(SSR) 방식에서 사용자 작업(생성, 수정, 삭제 등)에 대한 성공 또는 실패 피드백을 제공하는 데 사용됩니다."
        br
        plain "이 메시지들은 세션을 통해 일시적으로 저장되고,"
        br
        plain "다음 요청에서 한 번만 표시된 후 자동으로 사라지는 특징이 있습니다."
      end

      h3 { "아래 예제는 SSR만 사용한 플래시 메시지가 노출됩니다." }

      p do
        plain "버튼을 클릭하면 서버에서 생성,수정,삭제등의 작업을 했다고 가정하고 해당 페이지로 다시 리다이렉트됩니다."
        br
        plain "이번 예제에서는 플래시메시지 UI에 별도의 동작을 추가하지 않았기 때문에 노출된 이후에는 기본적으로 사라지지 않습니다."
        br
        plain "페이지를 다시 요청할 때 한번 플레시를 포함하기 때문에 페이지를 새로고침하면 사라지는 것을 볼 수 있습니다."
        br
        plain "동작을 포함하는 예제는 "
        a(class: "underline decoration-primary", href: "/lab/flash-v2") { "플레시메시지에 동작 추가" }
        plain "에서 확인할 수 있습니다."
      end

      render Views::Partials::Flash.new

      br

      div(class: "flex gap-4") do
        a(
          href: "/lab/flash/success",
          data: { turbo_method: "post" },
          class: "btn btn-soft btn-primary"
        ) { "어떤 작업의 성공.." }

        a(
          href: "/lab/flash/failure",
          data: { turbo_method: "post" },
          class: "btn btn-soft btn-warning"
        ) { "어떤 작업의 실패.." }
      end
    end
  end
end
