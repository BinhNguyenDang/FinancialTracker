class User < ApplicationRecord
  has_one_attached :avatar
  has_many :user_stocks
  has_many :stocks, through: :user_stocks

  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  

  after_commit :add_default_avatar, on: %i[create update]       
  def stock_already_tracked?(ticker_symbol)
    stock = Stock.check_db(ticker_symbol)
    return false unless stock
    stocks.where(id: stock.id).exists?
  
  end
  def under_stock_limit?
    stocks.count < 6
  end 
  
  def can_track_stock?(ticker_symbol)
    under_stock_limit? && !stock_already_tracked?(ticker_symbol)
  end

  def full_name
    return "#{first_name} #{last_name}" if first_name || last_name
    "Anonymous"
  end

  def avatar_thumbnail
    avatar.variant(resize_to_limit: [150, 150]).processed
  end

  private
  def add_default_avatar
    return if avatar.attached?
    avatar.attach(
      io: File.open(Rails.root.join('app', 'assets', 'images', 'default.jpg')),
      filename: 'default.jpg',
      content_type: 'image/jpg'
    )
  end
end
