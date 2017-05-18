class Article < ApplicationRecord
  belongs_to :user

  validates :movie_title, presence: true
  validates :article_title, presence: true
  validates :director, presence: true
  validates :performer, presence: true
  validates :content, presence: true
  validates :release_date, presence: true
  validates :user_id, presence: true
  validates :point_1, presence: true
  validates :point_2, presence: true
  validates :point_3, presence: true
  validates :point_4, presence: true
  validates :point_5, presence: true

  has_many :user_articles, class_name: 'UserArticle', dependent: :delete_all
  has_many :users, through: :user_articles

  is_impressionable

end
