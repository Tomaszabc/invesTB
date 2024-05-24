class Comment < ApplicationRecord
  belongs_to :article
  belongs_to :user, optional: true
  has_rich_text :content
  validates :content, presence: true
  validates :username, presence: true, unless: :user_id?
end
