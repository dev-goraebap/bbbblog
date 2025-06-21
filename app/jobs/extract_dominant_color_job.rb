class ExtractDominantColorJob < ApplicationJob
  queue_as :default

  def perform(attachment_id)
    attachment = ActiveStorage::Attachment.find_by(id: attachment_id)
    return unless attachment

    # 분석이 완료되지 않았다면 기다림
    unless attachment.analyzed?
      attachment.analyze
    end

    # 파일 열기 시도
    begin
      attachment.blob.open do |file|
        # 색상 추출
        colors = GoogleVision.extract_colors(file)

        # 첫 번째 색상의 hex만 메타데이터로 저장
        if colors.present? && colors.first.present?
          dominant_color = colors.first[:hex]

          # 현재 blob에서 직접 메타데이터 가져오기
          current_metadata = attachment.blob.metadata || {}

          # 새 메타데이터를 기존 메타데이터와 병합
          new_metadata = current_metadata.merge("dominant_color" => dominant_color)

          # 안전하게 메타데이터 업데이트
          attachment.blob.update_column(:metadata, new_metadata)

          Rails.logger.info "Attachment ID #{attachment_id}의 대표색상 업데이트 완료: #{dominant_color}"
        end
      end
    rescue => e
      Rails.logger.error "Attachment ID #{attachment_id}의 색상 추출 중 오류 발생: #{e.message}"
      # 작업을 재시도할 수 있도록 예외 다시 발생
      raise e
    end
  end
end
