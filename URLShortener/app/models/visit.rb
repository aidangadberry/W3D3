class Visit < ApplicationRecord
  validates :user_id, :url_id, presence: true
  
  belongs_to :user,
    primary_key: :id,
    foreign_key: :user_id,
    class_name: :User
  
  belongs_to :url,
    primary_key: :id,
    foreign_key: :url_id,
    class_name: :ShortenedUrl
  
  def self.record_visit!(user, shortened_url)
    self.create(
      user_id: user.id,
      url_id: shortened_url.id
    )
  end
end 
