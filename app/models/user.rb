class User < ApplicationRecord
  before_save { self.email.downcase!}
  validates :name, presence: true, length: { maximum: 50 }
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                    uniqueness: { case_sensitive: false }
  validates :university, presence: true, length: { maximum: 50 }
  validates :entrance_year, length: { is: 4 }
  
  has_secure_password
  has_many :reports, dependent: :destroy
end
