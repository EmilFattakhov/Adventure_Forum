class User < ApplicationRecord

  has_secure_password

  has_many :products
  has_many :reviews

  has_many :likes, dependent: :destroy 
  has_many :liked_reviews, through: :likes, source: :review

  has_many :favourites, dependent: :destroy 
  has_many :favourited_products, through: :favourites, source: :product 

  has_many :votes, dependent: :destroy 
  has_many :voted_reviews, through: :votes, source: :review

  has_many :news_articles, dependent: :nullify

  # Validations
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :first_name, :last_name, presence: true
  validates :email, presence: true, uniqueness: true, format: VALID_EMAIL_REGEX

  scope(:created_after, -> (date) { where("created_at < ?", "#{date}") })
  scope(:search, -> (query) { where("first_name ILIKE ? OR last_name ILIKE ? OR email ILIKE ?", "%#{query}%", "%#{query}%", "%#{query}%") })

  def full_name
    "#{first_name} #{last_name}".strip.titleize
  end
end

# Generated this model using `rails g model user first_name:string last_name:string email:string`
