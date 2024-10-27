Trestle.resource(:articles) do
  menu do
    item :articles, icon: "fa fa-star"
  end

  table do
    column :id
    column :title
    column :created_at, align: :center
    column :slug
    column :views_count
    column :likes_count
    column :sequential_number
    column :category
    column :top_article_number
    column :publish, align: :center
    column :notification
    column :notification_sent_at
    actions
  end

  # Formularz tworzenia/edycji artykułu
  form do |article|
    row do
      col(sm: 6) { text_field :title }
      col(sm: 6) { static_field :created_at }
    end

    row do
      col(sm: 6) { number_field :sequential_number }
      col(sm: 6) { select :category, Article.categories.keys }
    end

    row do
      col(sm: 6) { number_field :top_article_number }
      col(sm: 6) { check_box :publish }
    end

    row do
      if article.notification_sent_at.present?
        col(sm: 6) { static_field :notification, label: "Notification (already sent, you can't do it again)" }
      else
        col(sm: 6) { check_box :notification }
      end
      col(sm: 6) { static_field :notification_sent_at }
    end
  end

  # Opcjonalnie: Dostosowanie listy dozwolonych parametrów
  params do |params|
    params.require(:article).permit(:title, :sequential_number, :category, :top_article_number, :publish, :notification, :notification_sent_at)
  end
end

# Customize the table columns shown on the index view.
#
# table do
#   column :name
#   column :created_at, align: :center
#   actions
# end

# Customize the form fields shown on the new/edit views.
#
# form do |article|
#   text_field :name
#
#   row do
#     col { datetime_field :updated_at }
#     col { datetime_field :created_at }
#   end
# end

# By default, all parameters passed to the update and create actions will be
# permitted. If you do not have full trust in your users, you should explicitly
# define the list of permitted parameters.
#
# For further information, see the Rails documentation on Strong Parameters:
#   http://guides.rubyonrails.org/action_controller_overview.html#strong-parameters
#
# params do |params|
#   params.require(:article).permit(:name, ...)
# end
