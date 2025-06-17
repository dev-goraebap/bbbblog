class Lab::ModalController < ApplicationController
  def index
    render "lab/modal/index"
  end

  # 비동기 요청으로 가져올 컨텐츠
  def content
    render "lab/modal/content", layout: "modal"
  end

  def lazy_content
    sleep(0.8)
    render "lab/modal/content", layout: "modal"
  end
end
