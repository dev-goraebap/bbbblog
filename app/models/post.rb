class Post < ApplicationRecord
  has_many :post_tags, dependent: :destroy
  has_many :tags, through: :post_tags

  # 태그 관련 메서드 추가
  def tag_names=(names)
    # 쉼표로 구분된 문자열이나 배열을 처리
    names = names.split(",").map(&:strip) if names.is_a?(String)

    # 기존 태그 제거 방지를 위해 트랜잭션 사용
    self.transaction do
      # 새 태그 생성 또는 기존 태그 찾기
      tag_objects = names.map do |name|
        Tag.find_or_create_by(name: name) do |tag|
          tag.slug = name.parameterize
        end
      end

      # 태그 할당
      self.tags = tag_objects
    end
  end

  def tag_names
    tags.pluck(:name).join(", ")
  end
end
