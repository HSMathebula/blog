require 'rails_helper'
describe 'Posts-show', type: :feature do
  describe 'users/posts/show' do
    before(:each) do
      @user_one = User.create! name: 'Tom', photo: 'https://unsplash.com/photos/l-T-LpQnNRg', bio: 'designer', posts_counter: 0
      @user_two = User.create! name: 'Happen', photo: 'https://unsplash.com/photos/l-T-LpQnNRg', bio: 'developper', posts_counter: 0
      @post1 = @user_one.posts.create!(title: 'first post', text: 'description', comments_counter: 0, likes_counter: 0)
      @post2 = @user_one.posts.create!(title: 'second post', text: 'description', comments_counter: 0, likes_counter: 0)
      @comment_one = @post1.comments.create!(text: 'comment one', author_id: @user_one.id)
      @comment_two = @post1.comments.create!(text: 'comment two', author_id: @user_two.id)
      @like = @post1.likes.create!(author_id: @user_one.id)
      visit(user_post_path(@user_one.id, @post1.id))
    end
    scenario "can see the post's title." do
      expect(page).to have_content('first post')
    end
    scenario 'I can see who wrote the post.' do
      expect(page).to have_content('first post by Tom')
    end
    scenario 'I can see how many comments it has.' do
      expect(page).to have_content('Comments: 2')
    end
    scenario 'I can see how many likes it has.' do
      expect(page).to have_content('Likes: 1')
    end
    scenario 'I can see the post body.' do
      expect(page).to have_content('description')
    end
    scenario 'I can see the comment each commentor left.' do
      expect(page).to have_content('comment one')
      expect(page).to have_content('comment two')
    end
    scenario 'I can see the username of each commentor' do
      expect(page).to have_content('Tom')
      expect(page).to have_content('Happen')
    end
  end
end
