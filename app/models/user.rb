class User < ActiveRecord::Base
  has_many :items
  has_secure_password

  validates :username, :email, presence: true, uniqueness: true

  def slug
    self.username.strip.downcase.gsub(' ', '-')
  end

  def self.find_by_slug(slug)
    self.all.find { |instance| instance.slug == slug}
  end

end
