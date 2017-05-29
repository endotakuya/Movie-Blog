class User < ApplicationRecord
  before_save { self.email.downcase! }
  validates :name, presence: true, length: { maximum: 50 }
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                    uniqueness: { case_sensitive: false }
  has_secure_password

  has_many :articles
  has_many :user_articles, class_name: 'UserArticle'
  has_many :goods, through: :user_articles, source: :article
  has_many :messages
  has_many :user_rooms
  has_many :galleries

  def good(article)
    self.user_articles.find_or_create_by(article_id: article.id)
  end

  def ungood(article)
    good = self.user_articles.find_by(article_id: article.id)
    good.destroy if good
  end

  def good?(article)
    self.goods.include?(article)
  end

  def join_room(room_id)
    self.user_rooms.find_or_create_by(room_id: room_id)
  end

end