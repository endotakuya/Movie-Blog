class Watch < ApplicationRecord
  belongs_to :user

  validates :movie_id, presence: true
  validates :movie_title, presence: true
  validates :movie_poster_path, presence: true
  
end
