class Lab::ModalTest2Controller < ApplicationController
  def index
    render "lab/modal_test2/index"
  end

  # 비동기 요청으로 가져올 컨텐츠
  def content
    render "lab/modal_test2/content", layout: false
  end

  def lazy_content
    sleep(0.8)
    render "lab/modal_test2/content", layout: false
  end
end
