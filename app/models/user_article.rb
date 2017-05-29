class UserArticle < ApplicationRecord
  belongs_to :user
  belongs_to :article

  validates :user_id, presence: true
  validates :article_id, presence: true

  def self.good_ranking
    self.group(:article_id).order('count_article_id').reverse_order.count(:article_id)
  end

end
