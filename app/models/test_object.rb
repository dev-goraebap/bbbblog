class TestObject < ApplicationRecord
  has_many_attached :images, dependent: :purge_later
end
