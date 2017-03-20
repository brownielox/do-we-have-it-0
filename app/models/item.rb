class Item < ActiveRecord::Base
  belongs_to :user
  validates :content, presence: true, uniqueness: true
end
