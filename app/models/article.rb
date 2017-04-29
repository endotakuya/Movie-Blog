class Article < ApplicationRecord
  belongs_to :user
  
  validates :movie_title, presence: true
  validates :article_title, presence: true
  validates :director, presence: true
  validates :performer, presence: true
  validates :content, presence: true
  validates :release_date, presence: true
  validates :user_id, presence: true
  
end
