class Post < ApplicationRecord
  belongs_to :author, class_name: 'User'
  has_many :comments
  has_many :likes
  after_save :update_counter

  def update_posts_counter
    author.update(posts_counter: author.posts.count)
  end

  def last_five_comment
    comments.includes(:post).order(created_at: :desc).limit(5)
  end
end
