class Gallery < ApplicationRecord

    validates :movie_id, presence: true
    validates :image, presence: true

    mount_uploader :image, ImageUploader
end
