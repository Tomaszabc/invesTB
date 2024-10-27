class AddNotificationToArticles < ActiveRecord::Migration[7.0]
  def change
    add_column :articles, :notification, :boolean, default: false
    add_column :articles, :notification_sent_at, :datetime
  end
end
