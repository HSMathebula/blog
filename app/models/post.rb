class Post < ApplicationRecord
  belongs_to :author, class_name: 'User'
  has_many :comments
  has_many :likes
  after_save :update_posts_counter

  validates :title, presence: true, length: { maximum: 250 }
  validates :comments_counter, :likes_counter,
            numericality: { only_integer: true, greater_than_or_equal_to: 0, allow_nil: true }

  def update_posts_counter
    author.update(posts_counter: author.posts.count)
  end

  # returns 5 recent comments
  def recent_comments
    comments.includes(:post).order(created_at: :desc).limit(5)
  end
end
