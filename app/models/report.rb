class Report < ApplicationRecord
  belongs_to :user
  
  has_one_attached :repo
  

  validates :title, presence: true, length: { maximum: 50 }
  validates :day, presence: true, length: { is: 8 }
  validates :teaching, length: { maximum: 50 }
end
