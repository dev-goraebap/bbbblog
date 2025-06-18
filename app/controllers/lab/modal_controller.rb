class Lab::ModalController < LabController
  def index
    render Views::Lab::Modal::Index.new
  end

  # 비동기 요청으로 가져올 컨텐츠
  def content
    render Views::Lab::Modal::Content.new, layout: "modal"
  end

  def lazy_content
    sleep(0.8)
    render Views::Lab::Modal::Content.new, layout: "modal"
  end
end
