# == Schema Information
#
# Table name: shortened_urls
#
#  id         :bigint(8)        not null, primary key
#  short_url  :string           not null
#  long_url   :string           not null
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'securerandom'

class ShortenedUrl < ApplicationRecord
  validates :short_url, :long_url, presence: true, uniqueness: true
  validates :user_id, presence: true
  
  belongs_to :submitter,
    primary_key: :id,
    foreign_key: :user_id,
    class_name: :User
  
  has_many :visits,
    primary_key: :id,
    foreign_key: :url_id,
    class_name: :Visit
    
  has_many :visitors,
    through: :visits,
    source: :user  
    
  def self.generate_url(user, long_url)
    url_code = self.random_code
    
    self.create(
      user_id: user.id,
      long_url: long_url,
      short_url: url_code
    )
  end
  
  def num_clicks
    visits.count
  end
  
  def num_uniques
    ShortenedUrl.select(:user_id).distinct.count
  end
  
  def num_recent_uniques
    
  end
    
  private
    
  def self.random_code
    code = SecureRandom.urlsafe_base64
    
    while ShortenedUrl.exists?(short_url: code)
      code = SecureRandom.urlsafe_base64
    end
    
    code
  end
  
end
