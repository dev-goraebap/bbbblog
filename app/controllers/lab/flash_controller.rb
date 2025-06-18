class Lab::FlashController < LabController
  # rails에서 성공시 notice, 실패시 alert 명명을 사용하는 관례가 있음

  def index
    render Views::Lab::Flash::Index.new
  end

  def success
    redirect_to "/lab/flash", notice: "무언가 성공했어요!"
  end

  def failure
    redirect_to "/lab/flash", alert: "무언가 실패했어요!"
  end
end
