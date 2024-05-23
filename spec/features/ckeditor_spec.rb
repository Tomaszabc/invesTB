# spec/features/ckeditor_spec.rb
require "rails_helper"

RSpec.feature "CKEditor", type: :feature, js: true do
  let(:user) { create(:user, email: "admin@example.com", password: "password") }

  before do
    login_as(user, scope: :user)
  end

  scenario "User uses CKEditor in a form" do
    visit new_article_path

    fill_in "Title", with: "Test Article"

    expect(page).to have_css(".cke", visible: true)

    page.execute_script("CKEDITOR.instances['editor'].setData('<p>This is the content of the test article.</p>');")

    click_button "Create Article"

    expect(page).to have_content("Artykuł utworzony.")
    expect(page).to have_content("Test Article")
    expect(page).to have_content("This is the content of the test article.")
  end
end
