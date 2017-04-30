class User < ApplicationRecord
  before_save { self.email.downcase! }
  validates :name, presence: true, length: { maximum: 50 }
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                    uniqueness: { case_sensitive: false }
  has_secure_password

  has_many :articles
  has_many :user_articles, class_name: 'UserArticle'
  has_many :stocks, through: :user_articles, source: :article

  def stock(article)
    self.user_articles.find_or_create_by(article_id: article.id)
  end

  def unstock(article)
    stock = self.user_articles.find_by(article_id: article.id)
    stock.destroy if stock
  end

  def stock?(article)
    self.stocks.include?(article)
  end

end