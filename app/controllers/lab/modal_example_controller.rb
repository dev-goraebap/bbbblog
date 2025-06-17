class Lab::ModalExampleController < ApplicationController
  def index
    render "lab/modal_example/index"
  end

  # 비동기 요청으로 가져올 컨텐츠
  def content
    render "lab/modal_example/content", layout: "modal"
  end

  def lazy_content
    sleep(0.8)
    render "lab/modal_example/content", layout: "modal"
  end
end
