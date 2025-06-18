class Views::Partials::Icon < Phlex::HTML
  def initialize(name:, classes: nil)
    @name = name.to_s
    @classes = classes
  end

  def view_template
    # icon_name과 일치하는 메서드가 있는지 확인
    if respond_to?(:"icon_#{@name}", true)
      div(class: "size-6 #{@classes}") do
        # 동적으로 해당 아이콘 메서드 호출
        send(:"icon_#{@name}")
      end
    else
      # 일치하는 메서드가 없으면 기본 아이콘이나 오류 표시
      div(class: "text-error #{@classes}") do
        plain "아이콘을 찾을 수 없음: #{@name}"
      end
    end
  end

  private

  # 각 아이콘에 대한 메서드 정의
  def icon_close
    raw(<<~SVG.html_safe)
      <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor">
        <path stroke-linecap="round" stroke-linejoin="round" d="M6 18 18 6M6 6l12 12" />
      </svg>
    SVG
  end

  def icon_check
    raw(<<~SVG.html_safe)
      <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor">
        <path stroke-linecap="round" stroke-linejoin="round" d="M4.5 12.75l6 6 9-13.5" />
      </svg>
    SVG
  end

  def icon_warning
    raw(<<~SVG.html_safe)
      <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor">
        <path stroke-linecap="round" stroke-linejoin="round" d="M12 9v3.75m-9.303 3.376c-.866 1.5.217 3.374 1.948 3.374h14.71c1.73 0 2.813-1.874 1.948-3.374L13.949 3.378c-.866-1.5-3.032-1.5-3.898 0L2.697 16.126zM12 15.75h.007v.008H12v-.008z" />
      </svg>
    SVG
  end

  def icon_image
    raw(<<~SVG.html_safe)
      <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor">
        <path stroke-linecap="round" stroke-linejoin="round" d="m2.25 15.75 5.159-5.159a2.25 2.25 0 0 1 3.182 0l5.159 5.159m-1.5-1.5 1.409-1.409a2.25 2.25 0 0 1 3.182 0l2.909 2.909m-18 3.75h16.5a1.5 1.5 0 0 0 1.5-1.5V6a1.5 1.5 0 0 0-1.5-1.5H3.75A1.5 1.5 0 0 0 2.25 6v12a1.5 1.5 0 0 0 1.5 1.5Zm10.5-11.25h.008v.008h-.008V8.25Zm.375 0a.375.375 0 1 1-.75 0 .375.375 0 0 1 .75 0Z" />
      </svg>
    SVG
  end
end
