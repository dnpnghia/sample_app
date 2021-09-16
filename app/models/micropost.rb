class Micropost < ApplicationRecord
  belongs_to :user
  scope :recent_posts, ->{order created_at: :desc}
  has_one_attached :image
  validates :content, presence: true,
            length: {maximum: Settings.content.max_length}
  validates :image,
            content_type: {in: Settings.content.image_type,
                           message: I18n.t("microposts.image_invalid_format")},
            size:         {less_than: Settings.content.image_size.megabytes,
                           message: I18n.t("microposts.image_invalid_size")}

  def display_image
    image.variant resize_to_limit: Settings.content.resize_to_limit
  end
end
