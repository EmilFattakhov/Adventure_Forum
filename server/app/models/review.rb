class Review < ApplicationRecord
  validates :rating, presence: true, numericality: { greater_than_or_equal_to: 1, less_than_or_equal_to: 5 }

  belongs_to :product
  belongs_to :user

  has_many :likes, dependent: :destroy 
  has_many :likers, through: :likes, source: :user

  has_many :votes, dependent: :destroy 
  has_many :voters, through: :votes, source: :user

  def vote_total 
    votes.up.count - votes.down.count 
  end 

end
