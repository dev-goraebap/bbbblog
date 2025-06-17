class Lab::ModalV2Controller < ApplicationController
  def index
    render "lab/modal_v2/index"
  end

  # 비동기 요청으로 가져올 컨텐츠
  def content
    render "lab/modal_v2/content", layout: false
  end

  def lazy_content
    sleep(0.8)
    render "lab/modal_v2/content", layout: false
  end
end
