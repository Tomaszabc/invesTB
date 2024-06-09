require "rails_helper"

RSpec.feature "Add comment", type: :feature do
  scenario "User adds a comment to an article" do
    user = create(:user)
    article = create(:article)

    login_as(user, scope: :user)

    visit article_path(article)

    expect(page).to have_selector("turbo-frame#new_comment_form")

    within("turbo-frame#new_comment_form") do
      fill_in_rich_text_area("comment[content]", with: "To jest nowy komentarz.")
      find(".svg-button-comment").click
    end

    expect(page).to have_content("To jest nowy komentarz.")
  end

  scenario "Not logged user adds a comment to an article" do
    article = create(:article)

    visit article_path(article)

    expect(page).to have_selector("turbo-frame#new_comment_form")

    within("turbo-frame#new_comment_form") do
      fill_in "Autor:", with: "Example user"
      fill_in_rich_text_area("comment[content]", with: "To jest nowy komentarz.")
      find(".svg-button-comment").click
    end

    expect(page).to have_content("Example user")
    expect(page).to have_content("To jest nowy komentarz.")
  end

  scenario "User adds a comment exceeding the maximum length" do
    article = create(:article)
    long_comment = "a" * 10001

    visit article_path(article)

    expect(page).to have_selector("turbo-frame#new_comment_form")

    within("turbo-frame#new_comment_form") do
      fill_in "Autor:", with: "Example user"
      fill_in_rich_text_area("comment[content]", with: long_comment)
      find(".svg-button-comment").click
    end

    expect(page).to have_content("Treść komentarza nie może przekraczać 10000 znaków")
  end
end
