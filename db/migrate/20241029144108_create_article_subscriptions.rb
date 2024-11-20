class CreateArticleSubscriptions < ActiveRecord::Migration[7.0]
  def change
    create_table :article_subscriptions do |t|
      t.references :user, null: false, foreign_key: true
      t.string :email
      t.datetime :subscribed_at

      t.timestamps
    end
  end
end
