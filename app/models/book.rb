class Book < ApplicationRecord
  belongs_to :user
  has_many :favorites, dependent: :destroy
  has_many :notifications, as: :notifiable, dependent: :destroy
  has_many :book_comments, dependent: :destroy
  validates :title,presence:true
  validates :body,presence:true,length:{maximum:200}
  
  def self.looks(search, word)
    if search == "perfect_match"
      @book = Book.where("title LIKE?","#{word}")
    elsif search == "forward_match"
      @book = Book.where("title LIKE?","#{word}%")
    elsif search == "backward_match"
      @book = Book.where("title LIKE?","%#{word}")
    elsif search == "partial_match"
      @book = Book.where("title LIKE?","%#{word}%")
    else
      @book = Book.all
    end
  end
  
  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end
  
  after_create do
    user.followers.each do |follower|
      notifications.create(user_id: follower.id)
    end
    
  user.followers.each do |follower|
    Notification.create(user_id: follower.id, notifiable_type: "Book", notifiable_id: id)
  end
  end  
  
end
