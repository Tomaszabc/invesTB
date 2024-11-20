class ArticleSubscription < ApplicationRecord
  belongs_to :user
  validates :email, presence: true, uniqueness: true
end
