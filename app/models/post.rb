class Post < ApplicationRecord
  belongs_to :user
  has_many :comments
  has_many :likes

  after_save :update_counter

  def five_recent_comments
    comments.includes(:post).order(created_at: :desc).limit(5)
  end

  private

  def update_counter
    user.increment!(:PostsCounter)
  end
end