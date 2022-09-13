require 'rails_helper'

RSpec.describe 'Users', type: :feature do
  describe 'user#index' do
    before(:each) do
      User.create! name: 'Happen', photo: 'https://unsplash.com/photos/l-T-LpQnNRg', bio: 'developper', posts_counter: 0
      visit root_path
      @user = User.first!
    end

    scenario 'I can see the username of all other users.' do
      expect(page).to have_content('Happen')
    end
    scenario 'I can see the profile picture for each user.' do
      expect(page).to have_selector('.user_picture')
    end
    scenario 'I can see the number of posts each user has written.' do
      expect(page).to have_content('Number of Posts: 0')
    end
    scenario "When I click on a user, I am redirected to that user's show page" do
      visit(user_path(@user.id))
      expect(page).to have_content('Bio')
    end
  end
end
