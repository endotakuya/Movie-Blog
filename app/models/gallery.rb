class Gallery < ApplicationRecord

    validates :movie_id, presence: true
    validates :image, presence: true
    validates :user_id, presence: true

    belongs_to :user

    mount_uploader :image, ImageUploader
end
