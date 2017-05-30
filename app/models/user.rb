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
  has_many :watches

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

  def watched(id, title, poster_path)
    self.watches.find_or_create_by(movie_id: id, movie_title: title, movie_poster_path: poster_path)
  end

  def unwatch(movie_id)
    watch = self.watches.find_by(movie_id: movie_id)
    watch.destroy if watch
  end

  def watched?(movie)
    self.watches.exists?(movie_id: movie['id'])
  end

end