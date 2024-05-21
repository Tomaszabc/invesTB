require "rails_helper"

RSpec.feature "ViewArticle", type: :feature, js: true do
  let(:user) { create(:user, email: "user@example.com", password: "password") }
  let(:article) { create(:article, title: "Test Article", content: "This is the content of the test article.") }

  scenario 'Views count increases only once per session' do
    visit article_path(article)
    expect(page).to have_content('Wyświetlenia: 1')

    visit article_path(article)
    expect(page).to have_content('Wyświetlenia: 1')  

    Capybara.reset_session!

    visit article_path(article)
    expect(page).to have_content('Wyświetlenia: 2')
  end
end
