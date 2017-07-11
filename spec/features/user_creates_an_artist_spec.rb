require 'rails_helper'

RSpec.feature "user submits new artist and expects to see show page with their entry" do
  scenario "user enters data to create new artist" do
    artist_name = "Bob Marley"
    artist_image_path = "http://cps-static.rovicorp.com/3/JPG_400/MI0003/146/MI0003146038.jpg"

    visit "/artists"
    click_on "New Artist"
    fill_in "artist_name", with: artist_name
    fill_in "artist_image_path", with: artist_image_path
    click_on "Create Artist"

    expect(page).to have_content artist_name
    expect(page).to have_css("img[src=\"#{artist_image_path}\"]")
  end

  context "but the submitted data is invalid( testing sad path/entry not created if invalid attributes" do
    scenario "and they see an error message" do
      artist_image_path = "http://cps-static.rovicorp.com/3/JPG_400/MI0003/146/MI0003146038.jpg"


      visit "/artists"
      click_on "New Artist"
      # and I fill in path
      fill_in "artist_image_path", with: artist_image_path
      # but I forget artist name
      click_on "Create Artist"
      # to make this pass, go to model level testing to validate presence of attributes
      expect(page).to have_content "Name can't be blank"
    end
  end
end
