require "rails_helper"

RSpec.feature "LikeArticle", type: :feature, js: true do
  let(:user) { create(:user, email: "user@example.com", password: "password") }
  let(:article) { create(:article, title: "Test Article", content: "This is the content of the test article.") }

  before do
    login_as(user, scope: :user)
  end

  scenario "User likes an article" do
    visit article_path(article)

    expect(find("#like-counter")).to have_content("0")

    find(".like-svg-button").click

    expect(find("#like-counter")).to have_content("1")
  end
end
