class GoogleVision
  # Google Vision API를 사용하여 이미지에서 텍스트를 추출하는 메소드
  def self.extract_text_lines(file)
    # 이미지 파일 검증 (클래스 메서드 사용)
    validation_result = Shared::ImageValidator.validate_image_file(file, max_size: 1.megabyte)
    return validation_result if validation_result.failure?

    begin
      vision = Google::Cloud::Vision.image_annotator
      response = vision.text_detection image: file.tempfile
      annotations = response.responses.first.text_annotations

      return Result.failure("추출된 텍스트가 없습니다.", "TEXT_EXTRACTION_NULL") if annotations.empty?

      # 전체 텍스트 블록을 줄 단위로 분리
      lines = annotations.first.description.strip.split("\n")
      Result.success(lines: lines)
    rescue => e
      Rails.logger.error("Google Vision API 오류: #{e.message}")
      Result.failure("이미지 텍스트 추출 중 오류가 발생했습니다.", "TEXT_EXTRACTION_ERROR")
    end
  end

  def self.extract_colors(file)
    return [] unless file.present?

    puts "이미지 파일 경로: #{file.path}" if file.respond_to?(:path)
    puts "이미지 파일 존재 여부: #{File.exist?(file.path) ? "존재" : "없음"}" if file.respond_to?(:path)

    begin
      vision = Google::Cloud::Vision.image_annotator
      puts "Vision API 클라이언트 생성 성공"

      response = vision.image_properties_detection(
        image: file.path,
        max_results: 10
      )
      puts "API 응답: #{response.inspect}"

      colors = []

      if response && response.responses[0] && response.responses[0].image_properties_annotation
        colors_info = response.responses[0].image_properties_annotation.dominant_colors.colors

        colors = colors_info.map do |color|
          red = color.color.red
          green = color.color.green
          blue = color.color.blue
          score = color.score
          pixel_fraction = color.pixel_fraction

          {
            hex: "##{to_hex(red)}#{to_hex(green)}#{to_hex(blue)}",
            rgb: "rgb(#{red}, #{green}, #{blue})",
            score: score,
            pixel_fraction: pixel_fraction
          }
        end
      end

      colors
    rescue => e
      puts "구체적인 오류 내용: #{e.message}"
      puts "오류 발생 위치: #{e.backtrace.join("\n")}"
      Rails.logger.error("Google Vision 색상 추출 오류: #{e.message}")
      []
    end
  end

  def self.to_hex(value)
    value.to_i.to_s(16).rjust(2, "0")
  end
end
