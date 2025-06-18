class Lab::ImageUploadsController < LabController
  def index
    test_objects = TestObject.order(created_at: :desc)
    render Views::Lab::ImageUploads::Index.new(test_objects: test_objects)
  end

  def show
    test_object = TestObject.find(params[:id])
    render Views::Lab::ImageUploads::Show.new(test_object: test_object)
  end

  def new
    render Views::Lab::ImageUploads::New.new
  end

  def create
    @test_object = TestObject.new(test_object_params)

    if @test_object.save
      # 저장 후 이미지마다 대표색상 추출 및 저장
      if @test_object.images.attached?
        @test_object.images.each do |image|
          # 분석이 완료될 때까지 기다림
          image.analyze if !image.analyzed?

          # 이미지 열기
          image.blob.open do |file|
            # 색상 추출
            colors = GoogleVision.extract_colors(file)
            # 첫 번째 색상의 hex만 메타데이터로 저장
            if colors.present? && colors.first.present?
              dominant_color = colors.first[:hex]

              # 현재 blob에서 직접 메타데이터 가져오기
              current_metadata = ActiveStorage::Blob.find(image.blob.id).metadata

              # 새 메타데이터를 기존 메타데이터와 병합
              new_metadata = current_metadata.merge("dominant_color" => dominant_color)

              # 안전하게 메타데이터 업데이트 (직접 SQL 업데이트)
              image.blob.update_column(:metadata, new_metadata)
            end
          end
        end
      end

      flash[:notice] = "이미지 업로드 성공! 파일 개수: #{@test_object.images.count}"
      redirect_to "/lab/image-uploads"
    else
      flash[:alert] = "이미지 업로드 실패! #{@test_object.errors.full_messages.to_sentence}"
      redirect_to "/lab/image-uploads/new"
    end
  end

  private

  def test_object_params
    params.require(:test_object).permit(:name, images: [])
  end
end
