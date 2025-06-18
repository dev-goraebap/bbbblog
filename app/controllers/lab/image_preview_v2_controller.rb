class Lab::ImagePreviewV2Controller < LabController
  def index
    render Views::Lab::ImagePreviewV2::Index.new
  end
end
