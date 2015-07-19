class Blog < ActiveRecord::Base
  has_many :comments, dependent: :destroy
  has_many :images, dependent: :destroy

  validates :title, presence: true
  validates :body, presence: true
end
