class Comment < ApplicationRecord
  belongs_to :article
  belongs_to :user, optional: true
  has_rich_text :content
  validates :content, presence: { message: "Treść komentarza nie może być pusta" }
  validates :username, presence: { message: "Nazwa użytkownika nie może być pusta" }, unless: -> { user.present? }
end
