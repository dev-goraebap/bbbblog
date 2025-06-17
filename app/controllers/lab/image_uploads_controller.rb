class Lab::ImageUploadsController < ApplicationController
  def index
    @test_objects = TestObject.order(created_at: :desc)
  end

  def show
    @test_object = TestObject.find(params[:id])
  end

  def new
  end

  def create
    puts "==================="
    puts test_object_params
    puts test_object_params[:images]
    puts test_object_params[:name]
    puts "==================="

    @test_object = TestObject.new(test_object_params)
    if @test_object.save
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
