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
      # 저장 후 이미지마다 대표색상 추출 작업을 백그라운드로 전환
      if @test_object.images.attached?
        @test_object.images.each do |image|
          # 각 이미지에 대한 색상 추출을 백그라운드 작업으로 예약
          ExtractDominantColorJob.perform_later(image.id)
        end
      end

      flash[:notice] = "이미지 업로드 성공! 파일 개수: #{@test_object.images.count}. 이미지 처리는 백그라운드에서 계속됩니다."
      redirect_to "/lab/image-uploads"
    else
      flash[:alert] = "이미지 업로드 실패! #{@test_object.errors.full_messages.to_sentence}"
      redirect_to "/lab/image-uploads/new"
    end
  end

  def edit
    test_object = TestObject.find(params[:id])
    render Views::Lab::ImageUploads::Edit.new(test_object: test_object)
  end

  def update
    @test_object = TestObject.find(params[:id])
    remove_ids = params[:remove_file_ids] || []

    # 1. 제거할 이미지 처리
    if remove_ids.present?
      remove_ids.each do |blob_id|
        attachment = ActiveStorage::Attachment
          .joins(:blob)
          .where(record: @test_object,
            record_type: "TestObject",
            name: "images",
            blob_id: blob_id)
          .first

        attachment&.purge_later
      end
    end

    # 2. 이름 업데이트
    @test_object.name = test_object_params[:name] if test_object_params[:name].present?
    @test_object.save

    # 3. 새 이미지 추가 처리
    if test_object_params[:images].present?
      test_object_params[:images].each do |image|
        @test_object.images.attach(image)

        # 새로 첨부된 이미지의 메타데이터 처리는 백그라운드 작업으로 전환
        # 메타데이터 처리를 위해 ID만 전달
        attachment_id = @test_object.images.last.id
        ExtractDominantColorJob.perform_later(attachment_id)
      end
    end

    flash[:notice] = "이미지가 성공적으로 업데이트되었습니다. 이미지 처리는 백그라운드에서 계속됩니다."
    redirect_to "/lab/image-uploads/#{@test_object.id}"

  rescue => e
    Rails.logger.error "업데이트 실패: #{e.message}"
    flash[:alert] = "업데이트 실패: #{e.message}"
    redirect_to "/lab/image-uploads/#{@test_object.id}/edit"
  end

  def destroy
    test_object = TestObject.find(params[:id])

    if test_object.destroy
      redirect_to "/lab/image-uploads", notice: "게시물이 삭제되었습니다"
    else
      redirect_to "/lab/image-uploads", alert: "게시물 삭제에 실패하였습니다."
    end
  end

  private

  def test_object_params
    params.require(:test_object).permit(:name, images: [])
  end
end
