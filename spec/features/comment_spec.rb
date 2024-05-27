require 'rails_helper'

RSpec.feature "Add comment", type: :feature do
  scenario "User adds a comment to an article" do
    # Tworzymy użytkownika i artykuł w bazie danych
    user = create(:user)
    article = create(:article)

    # Logujemy się jako użytkownik
    login_as(user, :scope => :user)

    # Przechodzimy do strony z artykułem
    visit article_path(article)

    expect(page).to have_selector("#new_comment_form")

    # Wypełniamy formularz dodawania komentarza
    within("#new_comment_form") do
      fill_in "comment_content", with: "To jest nowy komentarz."
      find('.svg-button-comment').click
    end
    
    

    # Oczekujemy, że po złożeniu formularza pojawi się nowy komentarz na stronie
    expect(page).to have_content("To jest nowy komentarz.")
  end
end
