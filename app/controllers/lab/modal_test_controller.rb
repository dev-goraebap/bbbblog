class Lab::ModalTestController < ApplicationController
  def index
    render "lab/modal_test/index"
  end

  # 비동기 요청으로 가져올 컨텐츠
  def content
    render "lab/modal_test/content", layout: "modal"
  end

  def lazy_content
    sleep(0.8)
    render "lab/modal_test/content", layout: "modal"
  end
end
