module CapybaraHelpers
  def fill_in_trix_editor(id, with:)
    puts page.html
    trix_editor = find(:xpath, "//trix-editor[@input='#{id}']")
    trix_editor.click.set(with)
  end

  def find_trix_editor(id)
    find(:xpath, "//*[@id='#{id}']", visible: false)
  end
end
