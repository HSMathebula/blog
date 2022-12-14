require 'rails_helper'
RSpec.describe 'Users-show', type: :feature do
  describe 'users show' do
    before(:each) do
      @user_one = User.create! name: 'Tom', photo: 'https://unsplash.com/photos/l-T-LpQnNRg', bio: 'designer',
                               posts_counter: 0
      @user_two = User.create! name: 'Happen', photo: 'https://unsplash.com/photos/l-T-LpQnNRg', bio: 'developper',
                               posts_counter: 0
      @post1 = @user_one.posts.create!(title: 'first post', text: 'text', comments_counter: 0, likes_counter: 0)
      @post2 = @user_one.posts.create!(title: 'second post', text: 'text', comments_counter: 0, likes_counter: 0)
      @post3 = @user_one.posts.create!(title: 'third post', text: 'text', comments_counter: 0, likes_counter: 0)
      @post4 = @user_one.posts.create!(title: 'fourth post', text: 'text', comments_counter: 0, likes_counter: 0)
      @post5 = @user_one.posts.create!(title: 'fifth post', text: 'text', comments_counter: 0, likes_counter: 0)

      @comment = @post1.comments.create!(text: 'comment one', author_id: @user_one.id)
      @comment2 = @post1.comments.create!(text: 'comment two', author_id: @user_two.id)
      visit(user_path(@user_one.id))
    end
    scenario "can see the user's profile picture" do
      expect(page).to have_selector('span')
    end
    scenario 'I can see the username of all other users.' do
      expect(page).to have_content('Tom')
    end
    scenario 'I can see the number of posts the user has written.' do
      expect(page).to have_content(/#{Regexp.escape('Number of posts: 5')}/i)
    end
    scenario "I can see the user's bio." do
      expect(page).to have_content('designer')
    end
    scenario "I can see the user's first 3 posts." do
      expect(page).to have_content 'fifth post'
      expect(page).to have_content 'fourth post'
      expect(page).to have_content 'third post'
    end
    scenario "I can see a button that lets me view all of a user's posts." do
      expect(page).to have_content 'See all posts'
    end
    scenario "When I click a user's post, it redirects me to that post's show page" do
      visit(user_posts_path(@user_one.id))
      expect(page).to have_current_path user_posts_path(@user_one.id)
    end
    scenario 'When I click to see all posts, it redirects me to the users posts index page.' do
      click_link 'See all posts'
      expect(page).to have_current_path user_posts_path(@user_one)
    end
  end
end
