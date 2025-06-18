class Views::Partials::Flash < Views::Base
  def initialize(version: "v1")
    @version = version
  end

  def view_template
    if @version == "v2"
      v2
    else
      v1
    end
  end

  private

  # 단순히 보여주기용도, 동작 추가 없음
  def v1
    if helpers.flash[:notice].present?
      div(role: "alert", class: "alert alert-info alert-soft") do
        span { helpers.flash[:notice] }
      end
    end
    if helpers.flash[:alert].present?
      div(role: "alert", class: "alert alert-error alert-soft") do
        span { helpers.flash[:alert] }
      end
    end
  end

  # 동작을 추가하여, 랜더링 이후에 사용자 상호작용 추가
  def v2
    if helpers.flash[:notice].present?
      div(data: { controller: "flash" }, role: "alert", class: "alert alert-info alert-soft flex justify-between") do
        span { helpers.flash[:notice] }
        button(data: { action: "flash#onClose" }) do
          render Views::Partials::Icon(name: "close")
        end
      end
    end
    
    if helpers.flash[:alert].present?
      div(data: { controller: "flash" }, role: "alert", class: "alert alert-error alert-soft flex justify-between") do
        span { helpers.flash[:alert] }
        button(data: { action: "flash#onClose" }) do
          render Views::Partials::Icon(name: "close")
        end
      end
    end
  end
end
