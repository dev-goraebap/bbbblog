class Lab::ImagePreviewController < LabController
  def index
    render Views::Lab::ImagePreview::Index.new
  end
end
