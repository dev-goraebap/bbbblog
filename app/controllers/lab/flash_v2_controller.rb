class Lab::FlashV2Controller < LabController
  # rails에서 성공시 notice, 실패시 alert 명명을 사용하는 관례가 있음

  def index
    render Views::Lab::FlashV2::Index.new
  end

  def success
    redirect_to "/lab/flash-v2", notice: "무언가 성공했어요!"
  end

  def failure
    redirect_to "/lab/flash-v2", alert: "무언가 실패했어요!"
  end
end
