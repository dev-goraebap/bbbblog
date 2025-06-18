class Lab::ModalV2Controller < LabController
  def index
    render Views::Lab::ModalV2::Index.new
  end

  # 비동기 요청으로 가져올 컨텐츠
  def content
    render Views::Lab::ModalV2::Content.new, layout: false
  end

  def lazy_content
    sleep(0.8)
    render Views::Lab::ModalV2::Content.new, layout: false
  end
end
