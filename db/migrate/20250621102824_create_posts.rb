class CreatePosts < ActiveRecord::Migration[8.0]
  def change
    create_table :posts do |t|
      t.string :title                # 제목
      t.text :body                   # 본문
      t.string :status, default: 'draft' # 상태 (draft, published, archived 등)
      t.datetime :published_at       # 발행 시간
      t.integer :views_count, default: 0   # 조회수
      t.string :slug                 # URL 슬러그 (SEO 친화적인 URL)
      t.string :description          # 메타 설명 (SEO용)
      t.integer :reading_time        # 예상 읽기 시간 (분 단위)
      t.timestamps
    end

    add_index :posts, :slug, unique: true
    add_index :posts, :status
    add_index :posts, :published_at
  end
end
